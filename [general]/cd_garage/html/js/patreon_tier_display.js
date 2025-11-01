// Patreon Tier Display System for cd_garage
// This file handles displaying tier indicators (Tier 1, Tier 2, Tier 3) next to Patreon vehicles in the garage UI

// Global variables to store patreon tier data
let patreonTiers = null;
let processedVehicles = new Set();
let lastGarageContent = '';
let monitoringActive = false;

// Vehicle name to spawn code mapping
const vehicleNameMapping = {
    // Tier 1 vehicles
    'Dominator Widebody': 'sc_dominatorwb',
    'Vacca Widebody': 'vacca2',
    'Clubta': 'clubta',
    'Furia Widebody': 'furiawb',
    'Sentinel Rt': 'sentinel_rts',
    'H4rxwindsor': 'h4rxwindsorcus',
    'GST Zr350': 'gstzr3503',
    'Schwarzer2': 'schwarzer2',
    'GP1 Widebody': 'gp1wb',
    'R300W': 'r300w',
    'Cypher CT': 'cypherct',
    'GB Club XR': 'gbclubxr',
    'GB Mogul RS': 'gbmogulrs',
    'GB 811 S2': 'gb811s2',
    'Contender C': 'contenderc',
    'Coquette Widebody': 'coquettewb',
    'Hoonie': 'Hoonie',
    'Jester GPR': 'jestgpr',
    'Komoda FR': 'komodafr',
    'Zentorno C': 'zentornoc',
    'MK2 Vigero ZX': 'mk2vigerozx',
    'Z190 Widebody': 'z190wb',
    'Comet RR': 'cometrr',
    'SR S Pback': 'srspback',
    'Boor BC': 'boorbc',
    'Sultan RS V8': 'sultanrsv8',
    'Sasevero Widebody': 'saseverowb',
    'GST Arg2': 'gstarg2',
    
    // Tier 2 vehicles
    'Turismo RR': 'turismorr',
    'Playboy': 'playboy',
    'Dominator TTC': 'domttc',
    'Itali GTS': 'italigts',
    'Jester Widebody': 'jesterwb',
    'GB Mojave': 'gbmojave',
    'Vigero ZX Widebody': 'vigerozxwbc',
    'HR GT6R': 'hrgt6r',
    'GB Sultan RSX': 'gbsultanrsx',
    'Yosemite 6STR': 'yosemite6str',
    'Fcomneis GT25': 'fcomneisgt25',
    'SD Drift Vet': 'sddriftvet',
    'Remus Widebody': 'remuswb',
    'Elytron': 'elytron',
    'Hotknife Rod': 'hotkniferod',
    'Vacca3': 'vacca3',
    'GST Ghell1': 'gstghell1',
    'Jester4 Widebody': 'jester4wb',
    'RT3000 Widebody': 'rt3000wb',
    'SD Monster Slayer': 'sdmonsterslayer',
    'Audace': 'audace',
    'GST JC2': 'gstjc2',
    'Turismo2 LM': 'turismo2lm',
    'Zentorno2': 'zentorno2',
    'Zion GTC': 'ziongtc',
    'Vertice': 'vertice',
    
    // Tier 3 vehicles
    'VD Tenf Rally': 'vd_tenfrally',
    'Vanz23 M2 Widebody': 'vanz23m2wb',
    'Unio BEPDB': 'uniobepdb',
    'Thrax S': 'thraxs',
    'Sunrise1': 'sunrise1',
    'Banshee AS': 'bansheeas',
    'Jester3 C': 'jester3c',
    'GST Nio2': 'gstnio2',
    'Sentinel DM': 'sentineldm',
    'Schlagen STR': 'schlagenstr',
    'Itali GT OC': 'italigtoc',
    'Sagauntlet Street': 'sagauntletstreet',
    'SC DTM': 'scdtm',
    'Draft GPR': 'draftgpr',
    'RH82': 'rh82',
    'SC Sugoi': 'SCSugoi',
    'HYC RH7': 'hycrh7',
    'HYC RH72': 'hycrh72',
    'Tyrus GTR': 'tyrusgtr',
    'Tempesta2': 'tempesta2',
    'Tempesta ES': 'tempestaes',
    'Rea GPR': 'reagpr',
    'GB Comet S2 RC': 'gbcomets2rc',
    'GST 10F1': 'gst10f1',
    'Coquette4 C': 'coquette4c',
    'Rapid GTE': 'rapidgte',
    'Kuruma TA': 'kurumata',
    'HYC Sun': 'hycsun'
};

// Debug flag - set to true to see console logs
const DEBUG = true;

// Function to log debug messages
function debugLog(message) {
    if (DEBUG) {
        console.log('[PatreonTierDisplay]', message);
    }
}

// Function to get vehicle tier from the patreon tiers data
function getVehicleTier(vehicleModel) {
    if (!patreonTiers || !patreonTiers.ENABLE) {
        return null;
    }
    
    // First try to map the display name to spawn code
    let spawncode = vehicleNameMapping[vehicleModel];
    if (!spawncode) {
        // If no mapping found, use the original model as-is
        spawncode = vehicleModel;
    }
    
    spawncode = spawncode.toString().toUpperCase();
    let minTier = null;
    
    for (const [tier, tierData] of Object.entries(patreonTiers.tiers || {})) {
        const tierNum = parseInt(tier);
        
        // Check cars
        if (tierData.cars && Array.isArray(tierData.cars)) {
            for (const car of tierData.cars) {
                if (car.toString().toUpperCase() === spawncode) {
                    minTier = (minTier && Math.min(minTier, tierNum)) || tierNum;
                }
            }
        }
        
        // Check boats
        if (tierData.boats && Array.isArray(tierData.boats)) {
            for (const boat of tierData.boats) {
                if (boat.toString().toUpperCase() === spawncode) {
                    minTier = (minTier && Math.min(minTier, tierNum)) || tierNum;
                }
            }
        }
        
        // Check air vehicles
        if (tierData.air && Array.isArray(tierData.air)) {
            for (const air of tierData.air) {
                if (air.toString().toUpperCase() === spawncode) {
                    minTier = (minTier && Math.min(minTier, tierNum)) || tierNum;
                }
            }
        }
    }
    
    if (minTier) {
        debugLog(`Vehicle ${vehicleModel} (${spawncode}) is Patreon Tier ${minTier}`);
    }
    
    return minTier;
}

// Function to get tier display name
function getTierDisplayName(tier) {
    switch (tier) {
        case 1: return "Tier 1";
        case 2: return "Tier 2";
        case 3: return "Tier 3";
        case 4: return "Tier 4";
        default: return null;
    }
}

// Function to get tier badge CSS class
function getTierBadgeClass(tier) {
    switch (tier) {
        case 1: return "badge badge-primary"; // Blue
        case 2: return "badge badge-success"; // Green
        case 3: return "badge badge-warning"; // Orange/Yellow
        case 4: return "badge badge-danger"; // Red
        default: return "badge badge-secondary";
    }
}

// Function to add tier indicator to a vehicle element
function addTierIndicatorToVehicle(vehicleElement, vehicleModel) {
    if (!vehicleElement || !vehicleModel) {
        return;
    }
    
    // Check if we've already processed this vehicle
    const vehicleId = vehicleElement.getAttribute('data-id') || vehicleElement.id || vehicleModel;
    if (processedVehicles.has(vehicleId)) {
        return;
    }
    
    const tier = getVehicleTier(vehicleModel);
    if (!tier) {
        return; // Not a Patreon vehicle
    }
    
    debugLog(`Adding tier ${tier} indicator to vehicle ${vehicleModel}`);
    
    // Create tier badge HTML
    const tierBadge = document.createElement('span');
    tierBadge.className = getTierBadgeClass(tier);
    tierBadge.style.marginLeft = '5px';
    tierBadge.style.fontSize = '0.8em';
    tierBadge.style.verticalAlign = 'middle';
    tierBadge.title = `Patreon ${getTierDisplayName(tier)} Vehicle`;
    tierBadge.textContent = getTierDisplayName(tier);
    
    // Try to find the best place to insert the badge
    // Look for the vehicle name/plate area first
    let targetElement = vehicleElement.querySelector('.badge-light') || 
                       vehicleElement.querySelector('[id^="carM"]') ||
                       vehicleElement.querySelector('.vehicle-name') || 
                       vehicleElement.querySelector('.car-name') || 
                       vehicleElement.querySelector('h5') || 
                       vehicleElement.querySelector('h6') ||
                       vehicleElement.querySelector('.list-group-item-text') ||
                       vehicleElement.querySelector('.vehicle-info') ||
                       vehicleElement.querySelector('.vehicle-model') ||
                       vehicleElement.querySelector('.car-model') ||
                       vehicleElement.querySelector('.badge') ||
                       vehicleElement.querySelector('span') ||
                       vehicleElement.querySelector('div');
    
    if (targetElement) {
        // Add the tier badge after the vehicle name/plate
        targetElement.appendChild(tierBadge);
        debugLog(`Added tier badge to target element for vehicle ${vehicleModel}`);
    } else {
        // Fallback: add to the beginning of the vehicle element
        vehicleElement.insertBefore(tierBadge, vehicleElement.firstChild);
        debugLog(`Added tier badge to beginning of vehicle element for vehicle ${vehicleModel}`);
    }
    
    // Mark this vehicle as processed
    processedVehicles.add(vehicleId);
}

// Function to find vehicle elements using multiple strategies
function findVehicleElements(garageContainer) {
    let vehicleElements = [];
    
    // Strategy 1: Look for common vehicle list item classes
    vehicleElements = garageContainer.querySelectorAll('.list-group-item, .vehicle-item, [data-vehicle], [data-id], .garage-item, .vehicle-entry');
    
    if (vehicleElements.length > 0) {
        debugLog(`Strategy 1 found ${vehicleElements.length} vehicle elements`);
        return vehicleElements;
    }
    
    // Strategy 2: Look for any elements that might contain vehicle information
    // This is more aggressive and looks for elements with text that might be vehicle names
    const allElements = garageContainer.querySelectorAll('*');
    const potentialVehicles = [];
    
    allElements.forEach(element => {
        // Skip if element is too small or doesn't contain text
        if (element.children.length > 5 || !element.textContent || element.textContent.trim().length < 3) {
            return;
        }
        
        // Look for elements that might contain vehicle information
        const text = element.textContent.trim();
        if (text.includes('Garage') || text.includes('Car') || text.includes('Vehicle') || 
            element.querySelector('.badge') || element.querySelector('[class*="badge"]')) {
            potentialVehicles.push(element);
        }
    });
    
    if (potentialVehicles.length > 0) {
        debugLog(`Strategy 2 found ${potentialVehicles.length} potential vehicle elements`);
        return potentialVehicles;
    }
    
    // Strategy 3: Look for any div elements that might be vehicle containers
    const divElements = garageContainer.querySelectorAll('div');
    const divVehicles = Array.from(divElements).filter(div => {
        // Skip if it's the garage container itself or has too many children
        if (div === garageContainer || div.children.length > 10) {
            return false;
        }
        
        // Look for divs that might contain vehicle info
        const hasText = div.textContent && div.textContent.trim().length > 0;
        const hasBadge = div.querySelector('.badge') || div.querySelector('[class*="badge"]');
        const hasGarageText = div.textContent && div.textContent.includes('Garage');
        
        return hasText && (hasBadge || hasGarageText);
    });
    
    if (divVehicles.length > 0) {
        debugLog(`Strategy 3 found ${divVehicles.length} div vehicle elements`);
        return divVehicles;
    }
    
    // Strategy 4: Look for ANY elements with text that contains vehicle-like information
    const textElements = [];
    allElements.forEach(element => {
        if (element.textContent && element.textContent.trim().length > 0) {
            const text = element.textContent.trim();
            // Look for elements that contain vehicle names or plate numbers
            if (text.includes('Garage') || 
                text.includes('Car') || 
                text.includes('Vehicle') ||
                text.includes('Widebody') ||
                text.includes('Dominator') ||
                text.includes('Vacca') ||
                text.includes('Clubta') ||
                text.includes('Turismo') ||
                text.includes('Furia') ||
                text.includes('Sentinel') ||
                text.includes('H4rxwindsor') ||
                text.includes('GST') ||
                text.includes('GP1') ||
                text.includes('R300W') ||
                text.includes('Cypher') ||
                text.includes('GB') ||
                text.includes('Contender') ||
                text.includes('Coquette') ||
                text.includes('Hoonie') ||
                text.includes('Jester') ||
                text.includes('Komoda') ||
                text.includes('Zentorno') ||
                text.includes('Vigero') ||
                text.includes('Z190') ||
                text.includes('Comet') ||
                text.includes('SR') ||
                text.includes('Boor') ||
                text.includes('Sultan') ||
                text.includes('Sasevero') ||
                text.includes('Playboy') ||
                text.includes('Itali') ||
                text.includes('Mojave') ||
                text.includes('HR') ||
                text.includes('Yosemite') ||
                text.includes('Fcomneis') ||
                text.includes('SD') ||
                text.includes('Remus') ||
                text.includes('Elytron') ||
                text.includes('Hotknife') ||
                text.includes('Monster') ||
                text.includes('Audace') ||
                text.includes('Zion') ||
                text.includes('Vertice') ||
                text.includes('VD') ||
                text.includes('Vanz23') ||
                text.includes('Unio') ||
                text.includes('Thrax') ||
                text.includes('Sunrise') ||
                text.includes('Banshee') ||
                text.includes('Schlagen') ||
                text.includes('Sagauntlet') ||
                text.includes('SC') ||
                text.includes('Draft') ||
                text.includes('RH82') ||
                text.includes('Sugoi') ||
                text.includes('HYC') ||
                text.includes('Tyrus') ||
                text.includes('Tempesta') ||
                text.includes('Rea') ||
                text.includes('Rapid') ||
                text.includes('Kuruma') ||
                text.includes('Sun') ||
                // Look for plate number patterns (8 character alphanumeric)
                /^[A-Z0-9]{8}$/.test(text) ||
                // Look for elements with badge classes
                element.querySelector('.badge') ||
                element.querySelector('[class*="badge"]') ||
                // Look for elements with specific IDs that might be vehicles
                element.id && (element.id.includes('car') || element.id.includes('vehicle') || element.id.includes('garage'))) {
                textElements.push(element);
            }
        }
    });
    
    if (textElements.length > 0) {
        debugLog(`Strategy 4 found ${textElements.length} text-based vehicle elements`);
        return textElements;
    }
    
    // Strategy 5: Look for any elements that might be vehicle containers based on structure
    const structureElements = [];
    allElements.forEach(element => {
        // Skip if it's the garage container itself
        if (element === garageContainer) {
            return;
        }
        
        // Look for elements that have a reasonable structure for vehicles
        const hasReasonableSize = element.children.length > 0 && element.children.length < 20;
        const hasText = element.textContent && element.textContent.trim().length > 0;
        const hasReasonableTextLength = element.textContent && element.textContent.trim().length < 500;
        
        if (hasReasonableSize && hasText && hasReasonableTextLength) {
            // Check if this element might contain vehicle info
            const text = element.textContent.trim();
            if (text.length > 10 && text.length < 200) { // Reasonable text length for vehicle info
                structureElements.push(element);
            }
        }
    });
    
    if (structureElements.length > 0) {
        debugLog(`Strategy 5 found ${structureElements.length} structure-based vehicle elements`);
        return structureElements;
    }
    
    debugLog('No vehicle elements found with any strategy');
    debugLog('Garage container children count:', garageContainer.children.length);
    debugLog('Garage container innerHTML length:', garageContainer.innerHTML.length);
    
    // Show some debug info about what's actually in the container
    if (garageContainer.children.length > 0) {
        debugLog('First few children:');
        for (let i = 0; i < Math.min(5, garageContainer.children.length); i++) {
            const child = garageContainer.children[i];
            debugLog(`Child ${i}:`, child.tagName, child.className, child.textContent?.substring(0, 100));
        }
    }
    
    return [];
}

// Function to extract vehicle model from element
function extractVehicleModel(vehicleElement) {
    // Try to extract vehicle model from various possible sources
    let vehicleModel = vehicleElement.getAttribute('data-vehicle') ||
                      vehicleElement.getAttribute('data-model') ||
                      vehicleElement.querySelector('[data-vehicle]')?.getAttribute('data-vehicle') ||
                      vehicleElement.querySelector('[data-model]')?.getAttribute('data-model') ||
                      vehicleElement.querySelector('.badge-light')?.textContent ||
                      vehicleElement.querySelector('[id^="carM"]')?.textContent ||
                      vehicleElement.querySelector('.vehicle-model')?.textContent ||
                      vehicleElement.querySelector('.car-model')?.textContent ||
                      vehicleElement.querySelector('.badge')?.textContent ||
                      vehicleElement.textContent?.split(' ')[0]; // First word might be vehicle name
    
    // If we still don't have a model, try to extract from the text content
    if (!vehicleModel && vehicleElement.textContent) {
        const text = vehicleElement.textContent.trim();
        
        // Look for vehicle names in the text
        for (const [displayName, spawnCode] of Object.entries(vehicleNameMapping)) {
            if (text.includes(displayName)) {
                vehicleModel = displayName;
                break;
            }
        }
        
        // If no mapping found, try to extract the first part of the text (before "Garage")
        if (!vehicleModel) {
            const parts = text.split('Garage');
            if (parts.length > 0) {
                vehicleModel = parts[0].trim();
            }
        }
    }
    
    return vehicleModel;
}

// Function to process all vehicles in the garage list
function processGarageListForTiers() {
    if (!patreonTiers || !patreonTiers.ENABLE) {
        debugLog('Patreon tiers not enabled or not available');
        return;
    }
    
    debugLog('Processing garage list for tier indicators...');
    
    // Look for the garage container
    const garageContainer = document.getElementById('smallGarageContainer') || 
                           document.querySelector('.garage-container') ||
                           document.querySelector('[id*="garage"]') ||
                           document.querySelector('.list-group');
    
    if (!garageContainer) {
        debugLog('Garage container not found');
        return;
    }
    
    debugLog('Found garage container, looking for vehicle elements...');
    
    // Use multiple strategies to find vehicle elements
    const vehicleElements = findVehicleElements(garageContainer);
    
    debugLog(`Found ${vehicleElements.length} vehicle elements`);
    
    if (vehicleElements.length === 0) {
        debugLog('No vehicle elements found - garage list might not be populated yet');
        debugLog('Garage container HTML structure:', garageContainer.innerHTML.substring(0, 500));
        return;
    }
    
    let processedCount = 0;
    vehicleElements.forEach((vehicleElement, index) => {
        const vehicleModel = extractVehicleModel(vehicleElement);
        
        if (vehicleModel) {
            debugLog(`Processing vehicle ${index + 1}: ${vehicleModel}`);
            addTierIndicatorToVehicle(vehicleElement, vehicleModel);
            processedCount++;
        } else {
            debugLog(`Vehicle ${index + 1}: No model found - element structure:`, vehicleElement.outerHTML.substring(0, 200));
        }
    });
    
    debugLog(`Processed ${processedCount} vehicles for tier indicators`);
}

// Function to clear processed vehicles cache
function clearProcessedVehiclesCache() {
    processedVehicles.clear();
    debugLog('Cleared processed vehicles cache');
}

// Function to clear all tier indicators
function clearAllTierIndicators() {
    debugLog('Clearing all tier indicators...');
    
    // Remove all tier badges
    const tierBadges = document.querySelectorAll('.badge-primary, .badge-success, .badge-warning, .badge-danger');
    let removedCount = 0;
    
    tierBadges.forEach(badge => {
        if (badge.textContent.includes('Tier')) {
            badge.remove();
            removedCount++;
        }
    });
    
    debugLog(`Removed ${removedCount} tier badges`);
    
    // Clear the processed vehicles cache
    clearProcessedVehiclesCache();
}

// Function to check if garage content has changed
function hasGarageContentChanged() {
    const garageContainer = document.getElementById('smallGarageContainer') || 
                           document.querySelector('.garage-container') ||
                           document.querySelector('[id*="garage"]') ||
                           document.querySelector('.list-group');
    
    if (!garageContainer) {
        return false;
    }
    
    const currentContent = garageContainer.innerHTML;
    if (currentContent !== lastGarageContent) {
        lastGarageContent = currentContent;
        return true;
    }
    
    return false;
}

// Function to monitor garage content changes
function monitorGarageChanges() {
    if (hasGarageContentChanged()) {
        debugLog('Garage content changed, reprocessing tier indicators...');
        clearProcessedVehiclesCache();
        setTimeout(processGarageListForTiers, 100);
    }
}

// Function to start aggressive monitoring
function startAggressiveMonitoring() {
    if (monitoringActive) return;
    
    monitoringActive = true;
    debugLog('Starting aggressive monitoring for garage changes...');
    
    // Monitor every 500ms when we have patreon data
    const aggressiveInterval = setInterval(() => {
        if (!patreonTiers || !patreonTiers.ENABLE) {
            clearInterval(aggressiveInterval);
            monitoringActive = false;
            return;
        }
        
        // Check if garage container exists and has content
        const garageContainer = document.getElementById('smallGarageContainer') || 
                               document.querySelector('.garage-container') ||
                               document.querySelector('[id*="garage"]') ||
                               document.querySelector('.list-group');
        
        if (garageContainer && garageContainer.children.length > 0) {
            // Process the list if we haven't already
            if (processedVehicles.size === 0) {
                debugLog('Garage container found with content, processing tier indicators...');
                processGarageListForTiers();
            }
        }
    }, 500);
    
    // Also try to wait for the garage to actually load content
    waitForGarageContent();
}

// Function to wait for garage content to actually load
function waitForGarageContent() {
    debugLog('Waiting for garage content to load...');
    
    let attempts = 0;
    const maxAttempts = 60; // Wait up to 30 seconds (60 * 500ms)
    
    const waitInterval = setInterval(() => {
        attempts++;
        
        const garageContainer = document.getElementById('smallGarageContainer') || 
                               document.querySelector('.garage-container') ||
                               document.querySelector('[id*="garage"]') ||
                               document.querySelector('.list-group');
        
        if (garageContainer) {
            // Check if the garage actually has meaningful content
            const hasContent = garageContainer.innerHTML.length > 100; // More than just empty divs
            const hasChildren = garageContainer.children.length > 0;
            
            if (hasContent && hasChildren) {
                debugLog(`Garage content loaded after ${attempts * 0.5} seconds`);
                clearInterval(waitInterval);
                
                // Wait a bit more for the content to fully render
                setTimeout(() => {
                    debugLog('Processing garage list after content load...');
                    processGarageListForTiers();
                }, 1000);
                
                return;
            }
        }
        
        if (attempts >= maxAttempts) {
            debugLog('Timed out waiting for garage content to load');
            clearInterval(waitInterval);
        }
    }, 500);
}

// Event listener for when the garage list is updated
document.addEventListener('DOMContentLoaded', () => {
    debugLog('DOM loaded, initializing Patreon tier display system...');
    
    // Initial processing
    processGarageListForTiers();
    
    // Set up a mutation observer to watch for changes in the garage container
    const garageContainer = document.getElementById('smallGarageContainer') || 
                           document.querySelector('.garage-container') ||
                           document.querySelector('[id*="garage"]') ||
                           document.querySelector('.list-group');
    
    if (garageContainer) {
        debugLog('Setting up mutation observer for garage container');
        
        const observer = new MutationObserver((mutations) => {
            let shouldProcess = false;
            
            mutations.forEach((mutation) => {
                if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
                    shouldProcess = true;
                }
            });
            
            if (shouldProcess) {
                debugLog('Garage container changed, reprocessing tier indicators...');
                // Clear cache and reprocess
                clearProcessedVehiclesCache();
                setTimeout(processGarageListForTiers, 100);
            }
        });
        
        observer.observe(garageContainer, {
            childList: true,
            subtree: true
        });
    } else {
        debugLog('Garage container not found during DOM load');
    }
    
    // Set up periodic monitoring as a fallback
    setInterval(monitorGarageChanges, 1000);
});

// Listen for messages from the Lua client
window.addEventListener('message', (event) => {
    if (event.data.action === 'cd_garage:addTierIndicators') {
        debugLog('Received addTierIndicators message from Lua client');
        patreonTiers = event.data.patreonTiers;
        debugLog('Patreon tiers data:', patreonTiers);
        clearProcessedVehiclesCache();
        
        // Start aggressive monitoring when we receive patreon data
        startAggressiveMonitoring();
        
        // Process immediately
        processGarageListForTiers();
        
        // Also process after a delay to catch any late-loading content
        setTimeout(processGarageListForTiers, 1000);
        setTimeout(processGarageListForTiers, 2000);
        setTimeout(processGarageListForTiers, 5000);
    } else if (event.data.action === 'cd_garage:clearTierIndicators') {
        debugLog('Received clearTierIndicators message from Lua client');
        clearAllTierIndicators();
    }
});

// Export functions for potential external use
window.PatreonTierDisplay = {
    getVehicleTier,
    getTierDisplayName,
    getTierBadgeClass,
    processGarageListForTiers,
    clearProcessedVehiclesCache,
    clearAllTierIndicators,
    startAggressiveMonitoring
};

// Manual debug function that can be called from console
window.debugPatreonTiers = function() {
    console.log('=== PATREON TIER DEBUG ===');
    console.log('Patreon tiers data:', patreonTiers);
    console.log('Processed vehicles count:', processedVehicles.size);
    
    // Check garage container
    const garageContainer = document.getElementById('smallGarageContainer') || 
                           document.querySelector('.garage-container') ||
                           document.querySelector('[id*="garage"]') ||
                           document.querySelector('.list-group');
    
    if (garageContainer) {
        console.log('Garage container found:', garageContainer);
        console.log('Garage container children:', garageContainer.children.length);
        console.log('Garage container HTML length:', garageContainer.innerHTML.length);
        console.log('Garage container HTML preview:', garageContainer.innerHTML.substring(0, 1000));
        
        // Try to find vehicle elements with each strategy
        console.log('=== VEHICLE ELEMENT SEARCH ===');
        
        // Strategy 1
        const strategy1 = garageContainer.querySelectorAll('.list-group-item, .vehicle-item, [data-vehicle], [data-id], .garage-item, .vehicle-entry');
        console.log('Strategy 1 (common classes):', strategy1.length, 'elements');
        
        // Strategy 2
        const allElements = garageContainer.querySelectorAll('*');
        const potentialVehicles = [];
        allElements.forEach(element => {
            if (element.children.length > 5 || !element.textContent || element.textContent.trim().length < 3) {
                return;
            }
            const text = element.textContent.trim();
            if (text.includes('Garage') || text.includes('Car') || text.includes('Vehicle') || 
                element.querySelector('.badge') || element.querySelector('[class*="badge"]')) {
                potentialVehicles.push(element);
            }
        });
        console.log('Strategy 2 (text-based):', potentialVehicles.length, 'elements');
        
        // Strategy 3
        const divElements = garageContainer.querySelectorAll('div');
        const divVehicles = Array.from(divElements).filter(div => {
            if (div === garageContainer || div.children.length > 10) {
                return false;
            }
            const hasText = div.textContent && div.textContent.trim().length > 0;
            const hasBadge = div.querySelector('.badge') || div.querySelector('[class*="badge"]');
            const hasGarageText = div.textContent && div.textContent.includes('Garage');
            return hasText && (hasBadge || hasGarageText);
        });
        console.log('Strategy 3 (div-based):', divVehicles.length, 'elements');
        
        // Strategy 4 (text-based with vehicle names)
        const textElements = [];
        allElements.forEach(element => {
            if (element.textContent && element.textContent.trim().length > 0) {
                const text = element.textContent.trim();
                if (text.includes('Garage') || 
                    text.includes('Car') || 
                    text.includes('Vehicle') ||
                    text.includes('Widebody') ||
                    text.includes('Dominator') ||
                    text.includes('Vacca') ||
                    text.includes('Clubta') ||
                    text.includes('Turismo') ||
                    text.includes('Furia') ||
                    text.includes('Sentinel') ||
                    text.includes('H4rxwindsor') ||
                    text.includes('GST') ||
                    text.includes('GP1') ||
                    text.includes('R300W') ||
                    text.includes('Cypher') ||
                    text.includes('GB') ||
                    text.includes('Contender') ||
                    text.includes('Coquette') ||
                    text.includes('Hoonie') ||
                    text.includes('Jester') ||
                    text.includes('Komoda') ||
                    text.includes('Zentorno') ||
                    text.includes('Vigero') ||
                    text.includes('Z190') ||
                    text.includes('Comet') ||
                    text.includes('SR') ||
                    text.includes('Boor') ||
                    text.includes('Sultan') ||
                    text.includes('Sasevero') ||
                    text.includes('Playboy') ||
                    text.includes('Itali') ||
                    text.includes('Mojave') ||
                    text.includes('HR') ||
                    text.includes('Yosemite') ||
                    text.includes('Fcomneis') ||
                    text.includes('SD') ||
                    text.includes('Remus') ||
                    text.includes('Elytron') ||
                    text.includes('Hotknife') ||
                    text.includes('Monster') ||
                    text.includes('Audace') ||
                    text.includes('Zion') ||
                    text.includes('Vertice') ||
                    text.includes('VD') ||
                    text.includes('Vanz23') ||
                    text.includes('Unio') ||
                    text.includes('Thrax') ||
                    text.includes('Sunrise') ||
                    text.includes('Banshee') ||
                    text.includes('Schlagen') ||
                    text.includes('Sagauntlet') ||
                    text.includes('SC') ||
                    text.includes('Draft') ||
                    text.includes('RH82') ||
                    text.includes('Sugoi') ||
                    text.includes('HYC') ||
                    text.includes('Tyrus') ||
                    text.includes('Tempesta') ||
                    text.includes('Rea') ||
                    text.includes('Rapid') ||
                    text.includes('Kuruma') ||
                    text.includes('Sun') ||
                    /^[A-Z0-9]{8}$/.test(text) ||
                    element.querySelector('.badge') ||
                    element.querySelector('[class*="badge"]') ||
                    (element.id && (element.id.includes('car') || element.id.includes('vehicle') || element.id.includes('garage')))) {
                    textElements.push(element);
                }
            }
        });
        console.log('Strategy 4 (vehicle names):', textElements.length, 'elements');
        
        // Strategy 5 (structure-based)
        const structureElements = [];
        allElements.forEach(element => {
            if (element === garageContainer) {
                return;
            }
            const hasReasonableSize = element.children.length > 0 && element.children.length < 20;
            const hasText = element.textContent && element.textContent.trim().length > 0;
            const hasReasonableTextLength = element.textContent && element.textContent.trim().length < 500;
            
            if (hasReasonableSize && hasText && hasReasonableTextLength) {
                const text = element.textContent.trim();
                if (text.length > 10 && text.length < 200) {
                    structureElements.push(element);
                }
            }
        });
        console.log('Strategy 5 (structure-based):', structureElements.length, 'elements');
        
        // Show some examples
        if (potentialVehicles.length > 0) {
            console.log('Example potential vehicle element:', potentialVehicles[0]);
            console.log('Example element HTML:', potentialVehicles[0].outerHTML.substring(0, 300));
        }
        
        if (divVehicles.length > 0) {
            console.log('Example div vehicle element:', divVehicles[0]);
            console.log('Example div HTML:', divVehicles[0].outerHTML.substring(0, 300));
        }
        
        if (textElements.length > 0) {
            console.log('Example text vehicle element:', textElements[0]);
            console.log('Example text HTML:', textElements[0].outerHTML.substring(0, 300));
        }
        
        if (structureElements.length > 0) {
            console.log('Example structure vehicle element:', structureElements[0]);
            console.log('Example structure HTML:', structureElements[0].outerHTML.substring(0, 300));
        }
        
        // Show all elements with their text content for manual inspection
        console.log('=== ALL ELEMENTS WITH TEXT ===');
        const elementsWithText = [];
        allElements.forEach(element => {
            if (element.textContent && element.textContent.trim().length > 0) {
                const text = element.textContent.trim();
                if (text.length > 5 && text.length < 200) { // Reasonable length
                    elementsWithText.push({
                        element: element,
                        text: text,
                        tagName: element.tagName,
                        className: element.className,
                        id: element.id
                    });
                }
            }
        });
        
        // Sort by text length and show the most relevant ones
        elementsWithText.sort((a, b) => b.text.length - a.text.length);
        console.log('Top 20 elements with text:');
        elementsWithText.slice(0, 20).forEach((item, index) => {
            console.log(`${index + 1}. ${item.tagName}${item.className ? '.' + item.className : ''}${item.id ? '#' + item.id : ''}: "${item.text}"`);
        });
        
    } else {
        console.log('Garage container NOT found');
    }
    
    // Try to manually process
    console.log('=== MANUAL PROCESSING ===');
    processGarageListForTiers();
    
    console.log('=== END DEBUG ===');
};

// Also add a manual trigger function
window.forceProcessPatreonTiers = function() {
    console.log('Forcing patreon tier processing...');
    clearProcessedVehiclesCache();
    processGarageListForTiers();
};

// Function to manually inspect the garage structure
window.inspectGarage = function() {
    console.log('=== GARAGE INSPECTION ===');
    
    // Look for any garage-related containers
    const containers = [
        document.getElementById('smallGarageContainer'),
        document.querySelector('.garage-container'),
        document.querySelector('[id*="garage"]'),
        document.querySelector('.list-group'),
        document.querySelector('[class*="garage"]'),
        document.querySelector('[class*="vehicle"]'),
        document.querySelector('[class*="car"]')
    ].filter(Boolean);
    
    console.log('Found containers:', containers.length);
    containers.forEach((container, index) => {
        console.log(`Container ${index + 1}:`, container.tagName, container.id, container.className);
        console.log('Children:', container.children.length);
        console.log('HTML length:', container.innerHTML.length);
        console.log('HTML preview:', container.innerHTML.substring(0, 500));
        
        // Show first few children
        if (container.children.length > 0) {
            console.log('First few children:');
            for (let i = 0; i < Math.min(3, container.children.length); i++) {
                const child = container.children[i];
                console.log(`  Child ${i}:`, child.tagName, child.className, child.textContent?.substring(0, 100));
            }
        }
        console.log('---');
    });
    
    // Look for any elements with vehicle-related text
    const allElements = document.querySelectorAll('*');
    const vehicleElements = [];
    
    allElements.forEach(element => {
        if (element.textContent && element.textContent.trim().length > 0) {
            const text = element.textContent.trim();
            if (text.includes('Garage') || 
                text.includes('Car') || 
                text.includes('Vehicle') ||
                text.includes('Widebody') ||
                text.includes('Dominator') ||
                text.includes('Vacca') ||
                text.includes('Clubta') ||
                text.includes('Turismo') ||
                text.includes('Furia') ||
                text.includes('Sentinel') ||
                text.includes('H4rxwindsor') ||
                text.includes('GST') ||
                text.includes('GP1') ||
                text.includes('R300W') ||
                text.includes('Cypher') ||
                text.includes('GB') ||
                text.includes('Contender') ||
                text.includes('Coquette') ||
                text.includes('Hoonie') ||
                text.includes('Jester') ||
                text.includes('Komoda') ||
                text.includes('Zentorno') ||
                text.includes('Vigero') ||
                text.includes('Z190') ||
                text.includes('Comet') ||
                text.includes('SR') ||
                text.includes('Boor') ||
                text.includes('Sultan') ||
                text.includes('Sasevero') ||
                text.includes('Playboy') ||
                text.includes('Itali') ||
                text.includes('Mojave') ||
                text.includes('HR') ||
                text.includes('Yosemite') ||
                text.includes('Fcomneis') ||
                text.includes('SD') ||
                text.includes('Remus') ||
                text.includes('Elytron') ||
                text.includes('Hotknife') ||
                text.includes('Monster') ||
                text.includes('Audace') ||
                text.includes('Zion') ||
                text.includes('Vertice') ||
                text.includes('VD') ||
                text.includes('Vanz23') ||
                text.includes('Unio') ||
                text.includes('Thrax') ||
                text.includes('Sunrise') ||
                text.includes('Banshee') ||
                text.includes('Schlagen') ||
                text.includes('Sagauntlet') ||
                text.includes('SC') ||
                text.includes('Draft') ||
                text.includes('RH82') ||
                text.includes('Sugoi') ||
                text.includes('HYC') ||
                text.includes('Tyrus') ||
                text.includes('Tempesta') ||
                text.includes('Rea') ||
                text.includes('Rapid') ||
                text.includes('Kuruma') ||
                text.includes('Sun') ||
                /^[A-Z0-9]{8}$/.test(text) || // Plate numbers
                element.querySelector('.badge') ||
                element.querySelector('[class*="badge"]')) {
                vehicleElements.push({
                    element: element,
                    text: text,
                    tagName: element.tagName,
                    className: element.className,
                    id: element.id,
                    html: element.outerHTML.substring(0, 200)
                });
            }
        }
    });
    
    console.log('Found vehicle-related elements:', vehicleElements.length);
    vehicleElements.forEach((item, index) => {
        console.log(`${index + 1}. ${item.tagName}${item.className ? '.' + item.className : ''}${item.id ? '#' + item.id : ''}: "${item.text}"`);
        console.log(`   HTML: ${item.html}`);
    });
    
    console.log('=== END INSPECTION ===');
};

debugLog('Patreon tier display system initialized');
debugLog('Use window.debugPatreonTiers() in console to debug');
debugLog('Use window.forceProcessPatreonTiers() in console to force processing');
debugLog('Use window.inspectGarage() in console to inspect garage structure');

