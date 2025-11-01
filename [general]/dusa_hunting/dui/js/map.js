// Custom CRS for the map
var customcrs = L.extend({}, L.CRS.Simple, {
  projection: L.Projection.LonLat,
  scale: function (zoom) {
    return Math.pow(2, zoom);
  },
  zoom: function (sc) {
    return Math.log(sc) / 0.6931471805599453;
  },
  distance: function (pos1, pos2) {
    var x_difference = pos2.lng - pos1.lng;
    var y_difference = pos2.lat - pos1.lat;
    return Math.sqrt(x_difference * x_difference + y_difference * y_difference);
  },
  transformation: new L.Transformation(0.02072, 117.3, -0.0205, 172.8),
  infinite: false,
  // Smooth zoom options
  smoothZoom: true,
  smoothSensitivity: 1,
});

// Global variables
var map;
var Animals = {};
var mapMarkers = L.layerGroup();


// Animal tracking system
var animalData = [];

// Default animal data (from Lua)
const defaultAnimalData = [
  {
    "active": true,
    "centerX": 2048.85205078125,
    "centerY": 3533.48291015625,
    "entityId": 1,
    "icon": "fa fa-deer",
    "id": 1,
    "name": "Geyik",
    "speed": 0.5,
    "type": "deer",
    "wanderRadius": 100,
    "x": 2031,
    "y": 3554
  },
  {
    "active": true,
    "centerX": 2048.85205078125,
    "centerY": 3533.48291015625,
    "entityId": 2,
    "icon": "fa fa-deer",
    "id": 2,
    "name": "Geyik",
    "speed": 0.5,
    "type": "deer",
    "wanderRadius": 100,
    "x": 2067,
    "y": 3599
  },
  {
    "active": true,
    "centerX": 2048.85205078125,
    "centerY": 3533.48291015625,
    "entityId": 3,
    "icon": "fa fa-deer",
    "id": 3,
    "name": "Geyik",
    "speed": 0.5,
    "type": "deer",
    "wanderRadius": 100,
    "x": 1956,
    "y": 3552
  },
  {
    "active": true,
    "centerX": 1957,
    "centerY": 3486,
    "entityId": 4,
    "icon": "fa fa-deer",
    "id": 4,
    "name": "Geyik",
    "speed": 0.5,
    "type": "deer",
    "wanderRadius": 200,
    "x": 1957,
    "y": 3486
  },
  {
    "active": true,
    "centerX": 2048.85205078125,
    "centerY": 3533.48291015625,
    "entityId": 5,
    "icon": "fa fa-deer",
    "id": 5,
    "name": "Geyik",
    "speed": 0.5,
    "type": "deer",
    "wanderRadius": 100,
    "x": 1958,
    "y": 3542
  }
];

// Animal markers storage
var animalMarkers = {};
var animalAnimations = {};

// Custom icon for animal pings
var AnimalPing = L.divIcon({
  html: '<i class="fa fa-location-dot fa-2x"></i>',
  iconSize: [20, 20],
  className: 'map-icon map-icon-ping',
  offset: [-10, 0]
});

// Function to create animal-specific icons
function createAnimalIcon(animalType, animalName) {
  const svg = getAnimalSVG(animalType);
  return L.divIcon({
    html: svg,
    iconSize: [30, 30],
    className: 'map-icon map-icon-animal map-icon-' + animalType,
    iconAnchor: [15, 15],
    popupAnchor: [0, -15]
  });
}

// Map image URL
var customImageUrl = "https://files.fivemerr.com/images/60c68fc9-1a7f-4e5a-800a-f760a74186ca.jpeg";

function initializeMap() {
  
  // Check if map container exists
  var mapContainer = document.getElementById('map-item');
  if (!mapContainer) {
    console.log('Map container not found');
    return;
  }

  // Eğer map zaten varsa, sadece log ver ve çık
  if (window.map) {
    return;
  }

  
  // Initialize the map
  map = L.map("map-item", {
    crs: customcrs,
    minZoom: 3,
    maxZoom: 8,
    zoom: 4,
    zoomSnap: 0.1,
    zoomDelta: 1.0,
    noWrap: true,
    continuousWorld: false,
    preferCanvas: false, // Canvas yerine DOM kullan
    center: [-300, -1500],
    maxBoundsViscosity: 1.0,
    wheelPxPerZoomLevel: 30,
    wheelDebounceTime: 20,
  });

  // Set map bounds
  var sw = map.unproject([0, 1024], 3 - 1);
  var ne = map.unproject([1024, 0], 3 - 1);
  var mapbounds = new L.LatLngBounds(sw, ne);
  map.setView([-300, -1500], 4);
  map.setMaxBounds(mapbounds);
  
  // Disable attribution
  map.attributionControl.setPrefix(false);

  // Add image overlay with error handling
  var imageOverlay = L.imageOverlay(customImageUrl, mapbounds);
  
  imageOverlay.on('error', function() {
    console.log('Failed to load map image');
  });
  
  imageOverlay.addTo(map);
  
  // Handle map drag events
  map.on("dragend", function () {
    if (!mapbounds.contains(map.getCenter())) {
      map.panTo(mapbounds.getCenter(), { animate: false });
    }
  });
  
  // Add click event to focus on clicked location
  map.on("click", function (e) {
    var clickedLatLng = e.latlng;
    
    map.setView(clickedLatLng, map.getZoom(), {
      animate: true,
      duration: 0.5
    });
  });
  
  // Add layer group to map
  mapMarkers.addTo(map);

  // Enable smooth zoom transitions
  map.options.zoomAnimation = true;
  map.options.zoomAnimationThreshold = 4;
  
  
  // Fetch animal data from Lua and initialize tracking
  fetchAnimalData();
  
  // Global referansları güncelle
  window.map = map;
  window.animalMarkers = animalMarkers;
  window.animalAnimations = animalAnimations;
}

// Function to fetch animal data from Lua
async function fetchAnimalData() {
  try {
    const response = await fetchNui('getAnimalData', {});
    if (response && response.success) {
      animalData = response.data || [];
      
      // Initialize animal tracking after data is loaded
      if (map) {
        initializeAnimalTracking();
      }
    } else {
      console.error('Failed to fetch animal data from Lua');
      // Fallback to default data if fetch fails
      animalData = defaultAnimalData;
      initializeAnimalTracking();
    }
  } catch (error) {
    console.error('Error fetching animal data:', error);
    // Fallback to default data
    animalData = defaultAnimalData;
    initializeAnimalTracking();
  }
}

function initializeAnimalTracking() {
  // fetchNui aktif, Lua'dan veri çekilecek
  
  // Mevcut markerları temizle (varsa)
  clearAnimalMarkers();
  
  // Create markers for all active animals
  animalData.forEach(function(animal) {
    if (animal.active) {
      createAnimalMarker(animal);
    }
  });
  
  // Start position updates every second
  setInterval(updateAnimalPositions, 1000);
  
}

function createAnimalMarker(animal) {
  var icon = createAnimalIcon(animal.type, animal.name);
  
  var marker = L.marker([animal.y, animal.x], { 
    icon: icon,
    title: animal.name
  });
  marker.addTo(map);
  
  // Add popup with only a big glowing button and a triangle below
  var popupContent = `
    <div class="custom-popup-btn-container">
      <button onclick="markLocation('${animal.id}', '${animal.entity}', '${animal.name}')"
        class="custom-popup-btn"
        onmouseover="this.classList.add('hovered')"
        onmouseout="this.classList.remove('hovered')">
        <i class='fas fa-map-marker-alt'></i>
        Yer İşaretle
      </button>
      <div class="custom-popup-triangle"></div>
    </div>
  `;
  
  marker.bindPopup(popupContent);
  
  // Store marker reference
  animalMarkers[animal.id] = marker;
  
  // Create animation object
  animalAnimations[animal.id] = {
    marker: marker,
    animal: animal,
    currentX: animal.x,
    currentY: animal.y,
    targetX: animal.x,
    targetY: animal.y,
    updateInterval: null
  };
  
}

// Function to mark location and show notification
function markLocation(animalId, entityId, animalName) {
  fetchNui('markAnimal', {
    entity: entityId,
  });
  showNotification(`${animalName} konumu işaretlendi!`);
  if (window.animalMarkers && window.animalMarkers[animalId]) {
    window.animalMarkers[animalId].closePopup();
  } else if (window.map && window.map.closePopup) {
    window.map.closePopup();
  }
}

// Function to show animated notification
function showNotification(message) {
  // Create notification element
  var notification = document.createElement('div');
  notification.className = 'location-notification';
  notification.innerHTML = `
    <div class="notification-content">
      <i class="fas fa-map-marker-alt"></i>
      <span>${message}</span>
    </div>
  `;
  
  // Add to body
  document.body.appendChild(notification);
  
  // Trigger animation
  setTimeout(() => {
    notification.classList.add('show');
  }, 100);
  
  // Remove after 5 seconds
  setTimeout(() => {
    notification.classList.remove('show');
    setTimeout(() => {
      if (notification.parentNode) {
        notification.parentNode.removeChild(notification);
      }
    }, 500);
  }, 5000);
}

function updateAnimalPositions() {
  animalData.forEach(function(animal) {
    if (animal.active && animalMarkers[animal.id]) {
      updateAnimalPosition(animal);
    }
  });
}

function updateAnimalPosition(animal) {
  var animation = animalAnimations[animal.id];
  if (!animation) return;
  
  // Get current position
  var currentX = animal.x;
  var currentY = animal.y;
  
  // Generate random movement within a small radius
  var moveRadius = animal.wanderRadius * 0.1; // 10% of wander radius for small movements
  var angle = Math.random() * Math.PI * 2;
  var distance = Math.random() * moveRadius;
  
  // Calculate new position
  var newX = currentX + Math.cos(angle) * distance;
  var newY = currentY + Math.sin(angle) * distance;
  
  // Ensure the animal stays within its wander area
  var centerX = animal.centerX;
  var centerY = animal.centerY;
  var maxDistance = animal.wanderRadius;
  
  var distanceFromCenter = Math.sqrt(Math.pow(newX - centerX, 2) + Math.pow(newY - centerY, 2));
  
  if (distanceFromCenter > maxDistance) {
    // If too far from center, move back towards center
    var angleToCenter = Math.atan2(centerY - newY, centerX - newX);
    newX = centerX + Math.cos(angleToCenter) * maxDistance * 0.8;
    newY = centerY + Math.sin(angleToCenter) * maxDistance * 0.8;
  }
  
  // Update animal position
  animal.x = newX;
  animal.y = newY;
  
  // Update marker position
  animation.marker.setLatLng([newY, newX]);
  
  // Update popup content with only button and triangle
  var popupContent = `
    <div class=\"custom-popup-btn-container\">
      <button onclick=\"markLocation('${animal.id}', '${animal.entity}', '${animal.name}')\"
        class=\"custom-popup-btn\"
        onmouseover=\"this.classList.add('hovered')\"
        onmouseout=\"this.classList.remove('hovered')\">
        <i class='fas fa-map-marker-alt'></i>
        Yer İşaretle
      </button>
      <div class=\"custom-popup-triangle\"></div>
    </div>
  `;
  animation.marker.bindPopup(popupContent);
  
  // Update animation object
  animation.currentX = newX;
  animation.currentY = newY;
  
}

function createWanderingMarker(centerX, centerY, markerTitle) {
  if (!map) {
    console.error('Map not initialized');
    return;
  }

  // Create marker at the specified coordinates
  var marker = L.marker([centerY, centerX], { 
    icon: AnimalPing,
    title: markerTitle
  });
  marker.addTo(map);
  
  // Add click event to focus on marker location
  marker.on("click", function (e) {
    e.originalEvent.preventDefault();
    e.originalEvent.stopPropagation();
    
    var markerLatLng = marker.getLatLng();
    map.setView(markerLatLng, map.getZoom(), {
      animate: true,
      duration: 0.5
    });
    
    // Show info in console instead of popup
  });
  
  // Add right-click for popup (context menu)
  marker.on("contextmenu", function (e) {
    e.originalEvent.preventDefault();
    marker.bindPopup(markerTitle + '<br>X: ' + centerX.toFixed(3) + '<br>Y: ' + centerY.toFixed(3)).openPopup();
  });
  
  // Animation object for this marker
  var markerAnimation = {
    marker: marker,
    centerX: centerX,
    centerY: centerY,
    currentX: centerX,
    currentY: centerY,
    targetX: centerX,
    targetY: centerY,
    speed: 0.5,
    wanderRadius: 200,
    updateInterval: null,
    title: markerTitle
  };
  
  function updateMarkerPosition() {
    // Randomly change target position within wander radius
    if (Math.random() < 0.02) { // 2% chance to change direction
      var angle = Math.random() * Math.PI * 2;
      var distance = Math.random() * markerAnimation.wanderRadius;
      markerAnimation.targetX = markerAnimation.centerX + Math.cos(angle) * distance;
      markerAnimation.targetY = markerAnimation.centerY + Math.sin(angle) * distance;
    }
    
    // Move towards target
    var dx = markerAnimation.targetX - markerAnimation.currentX;
    var dy = markerAnimation.targetY - markerAnimation.currentY;
    
    if (Math.abs(dx) > 0.1 || Math.abs(dy) > 0.1) {
      markerAnimation.currentX += dx * markerAnimation.speed * 0.01;
      markerAnimation.currentY += dy * markerAnimation.speed * 0.01;
      
      // Update marker position
      markerAnimation.marker.setLatLng([markerAnimation.currentY, markerAnimation.currentX]);
      
      // Update popup content
      markerAnimation.marker.bindPopup(markerAnimation.title + '<br>X: ' + markerAnimation.currentX.toFixed(3) + '<br>Y: ' + markerAnimation.currentY.toFixed(3));
    }
  }
  
  // Start animation
  markerAnimation.updateInterval = setInterval(updateMarkerPosition, 50);
  
  
  // Return the animation object for potential control
  return markerAnimation;
}

function AnimalMAP(ANIMAL) {
  if (!map) {
    console.error('Map not initialized');
    return;
  }

  var COORDS_X = ANIMAL.coords.x;
  var COORDS_Y = ANIMAL.coords.y;
  var CODE = ANIMAL.id;

  // Remove existing marker if it exists
  if (Animals[CODE]) {
    map.removeLayer(Animals[CODE]);
  }

  // Create new marker
  Animals[CODE] = L.marker([COORDS_Y, COORDS_X], { icon: AnimalPing });
  Animals[CODE].addTo(map);

  // Add click event to focus on marker location
  Animals[CODE].on("click", function (e) {
    e.originalEvent.preventDefault();
    e.originalEvent.stopPropagation();
    
    var markerLatLng = Animals[CODE].getLatLng();
    map.setView(markerLatLng, map.getZoom(), {
      animate: true,
      duration: 0.5
    });
    
  });

  // Add right-click event to remove marker
  Animals[CODE].on("contextmenu", function (e) {
    e.originalEvent.preventDefault();
    map.removeLayer(Animals[CODE]);
    delete Animals[CODE];
  });

}

function ClearMap() {
  // Clear all markers
  Object.keys(Animals).forEach(function(key) {
    if (Animals[key]) {
      map.removeLayer(Animals[key]);
    }
  });
  Animals = {};
  
  // Clear popups
  map.closePopup();
  
}

// Animal management functions
function addAnimal(animalData) {
  // Generate new ID
  var newId = Math.max(...animalData.map(a => a.id)) + 1;
  
  var newAnimal = {
    id: animalData.id || newId,
    type: animalData.type || "unknown",
    name: animalData.name || "Yeni Hayvan",
    icon: animalData.icon || "fa fa-paw",
    x: animalData.x || 4000,
    y: animalData.y || 1800,
    centerX: animalData.x || 4000,
    centerY: animalData.y || 1800,
    wanderRadius: animalData.wanderRadius || 200,
    speed: animalData.speed || 0.5,
    active: true
  };
  
  animalData.push(newAnimal);
  
  if (map) {
    createAnimalMarker(newAnimal);
  }
  
  return newAnimal;
}

function removeAnimal(animalId) {
  var animal = animalData.find(a => a.id === animalId);
  if (animal) {
    animal.active = false;
    
    if (animalMarkers[animalId]) {
      map.removeLayer(animalMarkers[animalId]);
      delete animalMarkers[animalId];
      delete animalAnimations[animalId];
    }

  }
}

function getAnimalData() {
  return animalData.filter(animal => animal.active);
}

function updateAnimalPositionById(animalId, newX, newY) {
  var animal = animalData.find(a => a.id === animalId);
  if (animal) {
    animal.x = newX;
    animal.y = newY;
    
    var animation = animalAnimations[animalId];
    if (animation) {
      animation.currentX = newX;
      animation.currentY = newY;
      animation.targetX = newX;
      animation.targetY = newY;
      animation.marker.setLatLng([newY, newX]);
    }
    
  }
}

// Tüm hayvan markerlarını temizle
function clearAnimalMarkers() {
  Object.keys(animalMarkers).forEach(function(id) {
    if (animalMarkers[id]) {
      map.removeLayer(animalMarkers[id]);
      delete animalMarkers[id];
    }
    if (animalAnimations[id]) {
      delete animalAnimations[id];
    }
  });
  // Alternatif olarak: animalMarkers = {}; animalAnimations = {};
}

// Export functions for external use
window.AnimalMAP = AnimalMAP;
window.ClearMap = ClearMap;
window.createWanderingMarker = createWanderingMarker;
window.addAnimal = addAnimal;
window.removeAnimal = removeAnimal;
window.getAnimalData = getAnimalData;
window.updateAnimalPositionById = updateAnimalPositionById;
window.markLocation = markLocation;
window.showNotification = showNotification;
window.animalData = animalData;
window.map = map;
window.animalMarkers = animalMarkers;
window.initializeMap = initializeMap;
window.fetchAnimalData = fetchAnimalData;