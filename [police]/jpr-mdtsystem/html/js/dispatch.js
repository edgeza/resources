// Dispatch integration with dusa_dispatch
let dispatchCalls = [];
let latestDispatch = null;

// Function to load dispatch calls from dusa_dispatch
function loadDispatchCalls() {
    // Use jQuery post method for NUI callbacks
    $.post('https://jpr-mdtsystem/getDispatchCalls', {}, function(data) {
        if (data && data.length > 0) {
            dispatchCalls = data;
            updateDispatchDisplay();
        } else {
            // Show no data message
            $('.mdt-content-home-dispatch-list').html('<div class="no-data">No dispatch calls available</div>');
        }
    }).fail(function(xhr, status, error) {
        $('.mdt-content-home-dispatch-list').html('<div class="no-data">Error loading dispatch calls</div>');
    });
}

// Function to load latest dispatch call
function loadLatestDispatch() {
    $.post('https://jpr-mdtsystem/getLatestDispatch', {}, function(data) {
        if (data) {
            latestDispatch = data;
            updateLatestDispatchDisplay();
        }
    }).fail(function(xhr, status, error) {
        // Silent fail for latest dispatch
    });
}

// Function to update dispatch calls display
function updateDispatchDisplay() {
    const dispatchList = $('.mdt-content-home-dispatch-list');
    dispatchList.empty();
    
    if (dispatchCalls.length === 0) {
        dispatchList.html('<div class="no-data">No dispatch calls available</div>');
        return;
    }
    
    dispatchCalls.forEach((call, index) => {
        // Validate call data before processing
        if (!call || typeof call !== 'object') {
            return;
        }
        
        const priorityClass = getPriorityClass(call.priority);
        const timeAgo = getTimeAgo(call.time);
        
        // Check if coords are valid for waypoint button
        const hasValidCoords = call.coords && typeof call.coords.x === 'number' && typeof call.coords.y === 'number';
        const waypointButton = hasValidCoords 
            ? `<button class="btn btn-sm btn-primary" onclick="setWaypoint(${call.coords.x}, ${call.coords.y})">Set Waypoint</button>`
            : `<button class="btn btn-sm btn-secondary" disabled>No Location</button>`;
        
        const dispatchItem = $(`
            <div class="dispatch-call-item ${priorityClass}" data-call-id="${call.id}">
                <div class="dispatch-call-header">
                    <h3>${call.title || 'Dispatch Call'}</h3>
                    <span class="dispatch-priority">Priority: ${call.priority || 1}</span>
                </div>
                <div class="dispatch-call-body">
                    <p>${call.description || 'No description available'}</p>
                    <div class="dispatch-call-meta">
                        <span class="dispatch-time">${timeAgo}</span>
                        <span class="dispatch-code">Code: ${call.codeName || 'Unknown'}</span>
                    </div>
                </div>
                <div class="dispatch-call-actions">
                    ${waypointButton}
                    <button class="btn btn-sm btn-success" onclick="joinDispatch(${call.id})">Join Call</button>
                </div>
            </div>
        `);
        
        dispatchList.append(dispatchItem);
    });
}

// Function to update latest dispatch display
function updateLatestDispatchDisplay() {
    if (!latestDispatch) return;
    
    // Validate latest dispatch data
    if (typeof latestDispatch !== 'object') {
        return;
    }
    
    const latestCallElement = $('.mdt-content-home-dispatch .latest-call');
    if (latestCallElement.length === 0) {
        // Check if coords are valid for waypoint button
        const hasValidCoords = latestDispatch.coords && typeof latestDispatch.coords.x === 'number' && typeof latestDispatch.coords.y === 'number';
        const waypointButton = hasValidCoords 
            ? `<button class="btn btn-sm btn-primary" onclick="setWaypoint(${latestDispatch.coords.x}, ${latestDispatch.coords.y})">Set Waypoint</button>`
            : `<button class="btn btn-sm btn-secondary" disabled>No Location</button>`;
            
        $('.mdt-content-home-dispatch-list').prepend(`
            <div class="latest-call dispatch-call-item high-priority" data-call-id="${latestDispatch.id}">
                <div class="dispatch-call-header">
                    <h3>LATEST: ${latestDispatch.title || 'Dispatch Call'}</h3>
                    <span class="dispatch-priority">Priority: ${latestDispatch.priority || 1}</span>
                </div>
                <div class="dispatch-call-body">
                    <p>${latestDispatch.description || 'No description available'}</p>
                    <div class="dispatch-call-meta">
                        <span class="dispatch-time">${getTimeAgo(latestDispatch.time)}</span>
                        <span class="dispatch-code">Code: ${latestDispatch.codeName || 'Unknown'}</span>
                    </div>
                </div>
                <div class="dispatch-call-actions">
                    ${waypointButton}
                    <button class="btn btn-sm btn-success" onclick="joinDispatch(${latestDispatch.id})">Join Call</button>
                </div>
            </div>
        `);
    }
}

// Helper function to get priority class
function getPriorityClass(priority) {
    if (priority >= 3) return 'high-priority';
    if (priority >= 2) return 'medium-priority';
    return 'low-priority';
}

// Helper function to get time ago
function getTimeAgo(timestamp) {
    const now = Date.now();
    const diff = now - timestamp;
    const minutes = Math.floor(diff / 60000);
    const hours = Math.floor(minutes / 60);
    
    if (hours > 0) {
        return `${hours}h ago`;
    } else if (minutes > 0) {
        return `${minutes}m ago`;
    } else {
        return 'Just now';
    }
}

// Function to set waypoint
function setWaypoint(x, y) {
    // Validate coordinates before sending
    if (x === 0 && y === 0) {
        return;
    }
    
    $.post('https://jpr-mdtsystem/setWaypoint', {
        x: x,
        y: y
    });
}

// Function to join dispatch call
function joinDispatch(callId) {
    $.post('https://jpr-mdtsystem/joinDispatch', {
        callId: callId
    });
}

// Function to refresh dispatch data
function refreshDispatchData() {
    loadDispatchCalls();
    loadLatestDispatch();
}

// Auto-refresh dispatch data every 30 seconds
setInterval(refreshDispatchData, 30000);

// Load dispatch data when page loads
$(document).ready(function() {
    refreshDispatchData();
});

// Listen for refresh dispatch messages from client
window.addEventListener('message', function(event) {
    if (event.data.action === 'refreshDispatch') {
        refreshDispatchData();
    }
});

// Dispatch page specific functions
function openDispatchPage() {
    refreshDispatchData();
    // Additional dispatch page logic can be added here
}

// Export functions for global access
window.loadDispatchCalls = loadDispatchCalls;
window.loadLatestDispatch = loadLatestDispatch;
window.refreshDispatchData = refreshDispatchData;
window.openDispatchPage = openDispatchPage;
window.setWaypoint = setWaypoint;
window.joinDispatch = joinDispatch;
