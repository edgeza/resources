// iPad MDT System JavaScript
let currentTab = 'dashboard';
let activeUnits = [];
let reports = [];
let bolos = [];
let officerData = null;

// FiveM NUI Callback Helper
function fetchNUI(eventName, data = {}, timeout = 5000) {
    return new Promise((resolve, reject) => {
        const timeoutId = setTimeout(() => {
            reject(new Error('NUI Callback timeout'));
        }, timeout);

        const resourceName = GetParentResourceName();
        fetch(`https://${resourceName}/${eventName}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify(data)
        })
        .then(res => res.json())
        .then(data => {
            clearTimeout(timeoutId);
            resolve(data);
        })
        .catch(err => {
            clearTimeout(timeoutId);
            reject(err);
        });
    });
}

// Get Parent Resource Name (FiveM)
function GetParentResourceName() {
    try {
        if (typeof window.GetParentResourceName === 'function') {
            return window.GetParentResourceName();
        }
    } catch (e) {
        console.error('Error getting parent resource name:', e);
    }
    return 'olrp-mdtsystem';
}

// Listen for messages from FiveM
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch(data.action) {
        case 'openMDT':
            // MDT is being opened - show the UI
            document.body.classList.add('mdt-open');
            // Request officer data when MDT opens
            fetchNUI('getOfficerData').catch(err => console.error('Failed to get officer data:', err));
            loadInitialData();
            break;
        case 'closeMDT':
            // MDT is being closed - hide the UI
            document.body.classList.remove('mdt-open');
            break;
        case 'receiveOfficerData':
            officerData = data.data;
            updateOfficerInfo();
            // Update badge from settings if available
            if (mdtSettings.badge) {
                const badgeElement = document.querySelector('.user-details .badge');
                if (badgeElement) {
                    badgeElement.textContent = `Badge: ${mdtSettings.badge}`;
                }
            }
            break;
        case 'receiveActiveUnits':
            activeUnits = data.data || [];
            console.log('Received active units:', activeUnits);
            renderActiveUnits();
            updateQuickStats();
            break;
        case 'receiveProfiles':
            isSearching = false;
            renderProfiles(data.data || []);
            break;
        case 'receiveReports':
            reports = data.data || [];
            console.log('Received reports:', reports);
            // Only render if we're on the reports tab
            if (currentTab === 'reports') {
                renderReports();
            }
            updateQuickStats();
            break;
        case 'receiveBOLOs':
            bolos = data.data || [];
            console.log('Received BOLOs:', bolos);
            // Only render if we're on the BOLOs tab
            if (currentTab === 'bolos') {
                renderBOLOs();
            }
            updateQuickStats();
            break;
        case 'receiveVehicle':
            renderVehicle(data.data || {});
            break;
        case 'receiveWeapons':
            renderWeapons(data.data || []);
            break;
        case 'receiveCameras':
            renderCameras(data.data || []);
            break;
        case 'receiveStaffLogs':
            renderStaffLogs(data.data || []);
            break;
        case 'receiveActiveCalls':
            renderActiveCalls(data.data || []);
            break;
        case 'receiveBodycamFeeds':
            renderBodycamFeeds(data.data || []);
            break;
        case 'receiveDispatchCall':
            // New dispatch call received
            showAlert(`New dispatch call: ${data.data.code || 'N/A'}`, 'info');
            loadActiveCalls();
            break;
        case 'removeDispatchCall':
            // Dispatch call removed
            loadActiveCalls();
            break;
    }
});

// Update officer info in sidebar
function updateOfficerInfo() {
    if (officerData) {
        const nameElement = document.querySelector('.user-details .name');
        const badgeElement = document.querySelector('.user-details .badge');
        if (nameElement) nameElement.textContent = officerData.name || 'Unknown';
        if (badgeElement) badgeElement.textContent = `Badge: ${officerData.badge || 'N/A'}`;
    }
}

// Initialize MDT
document.addEventListener('DOMContentLoaded', function () {
    initializeMDT();
    updateTime();
    setInterval(updateTime, 1000);
    drawMap();
    loadSettings(); // Load saved settings on startup
    setupSettingsListeners();
    
    // Don't request officer data on load - wait for MDT to be opened
    // The UI is hidden by default and will only show when /mdt command is used
});

// Draw map on canvas for crisp rendering (like cd_dispatch)
function drawMap() {
    const canvas = document.getElementById('mapCanvas');
    const img = document.getElementById('mapImage');
    
    if (!canvas || !img) {
        console.log('Canvas or image not found');
        return;
    }
    
    const ctx = canvas.getContext('2d');
    
    function renderMap() {
        // Check if image is loaded
        if (!img.complete || img.naturalWidth === 0) {
            console.log('Image not loaded yet, waiting...');
            img.onload = renderMap;
            img.onerror = function() {
                console.error('Failed to load map image');
            };
            return;
        }
        
        // Get container dimensions - try multiple methods
        const container = canvas.parentElement;
        let containerWidth = container.clientWidth;
        let containerHeight = container.clientHeight;
        
        // If container has no size, try to get from computed style or use defaults
        if (!containerWidth || containerWidth === 0) {
            const style = window.getComputedStyle(container);
            containerWidth = parseInt(style.width) || 800;
        }
        if (!containerHeight || containerHeight === 0) {
            const style = window.getComputedStyle(container);
            containerHeight = parseInt(style.height) || 600;
        }
        
        // Fallback to canvas display size
        if (!containerWidth || containerWidth === 0) {
            containerWidth = canvas.offsetWidth || 800;
        }
        if (!containerHeight || containerHeight === 0) {
            containerHeight = canvas.offsetHeight || 600;
        }
        
        // Set canvas size to match container (use actual pixel dimensions)
        canvas.width = containerWidth;
        canvas.height = containerHeight;
        
        // Calculate scale to fit image in canvas while maintaining aspect ratio
        const imgAspect = img.naturalWidth / img.naturalHeight;
        const canvasAspect = canvas.width / canvas.height;
        
        let drawWidth, drawHeight, x, y;
        
        if (imgAspect > canvasAspect) {
            // Image is wider - fit to width
            drawWidth = canvas.width;
            drawHeight = canvas.width / imgAspect;
            x = 0;
            y = (canvas.height - drawHeight) / 2;
        } else {
            // Image is taller - fit to height
            drawHeight = canvas.height;
            drawWidth = canvas.height * imgAspect;
            x = (canvas.width - drawWidth) / 2;
            y = 0;
        }
        
        // Clear canvas with background color
        ctx.fillStyle = '#1a1a1a';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        // Draw image with high quality
        ctx.imageSmoothingEnabled = true;
        ctx.imageSmoothingQuality = 'high';
        
        try {
            ctx.drawImage(img, x, y, drawWidth, drawHeight);
        } catch (e) {
            console.error('Error drawing image:', e);
        }
    }
    
    // Wait a bit for DOM to be ready, then render
    setTimeout(function() {
        renderMap();
    }, 100);
    
    // Also try when image loads
    if (img.complete && img.naturalWidth > 0) {
        renderMap();
    } else {
        img.onload = renderMap;
    }
    
    // Re-render on window resize
    let resizeTimeout;
    window.addEventListener('resize', function() {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(renderMap, 100);
    });
    
    // Re-render when map tab is shown
    const mapTab = document.querySelector('[data-tab="map"]');
    if (mapTab) {
        mapTab.addEventListener('click', function() {
            setTimeout(renderMap, 200);
        });
    }
}

function initializeMDT() {
    // Set up tab navigation
    document.querySelectorAll('.nav-item').forEach(item => {
        item.addEventListener('click', function () {
            switchTab(this.getAttribute('data-tab'));
        });
    });

    // Set up report form
    document.getElementById('incidentForm').addEventListener('submit', function (e) {
        e.preventDefault();
        submitReport();
    });

    // Add smooth transitions
    document.querySelectorAll('.ios-btn').forEach(btn => {
        btn.addEventListener('click', function (e) {
            // Add ripple effect
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.cssText = `
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.5);
                transform: scale(0);
                animation: ripple 0.6s linear;
                width: ${size}px;
                height: ${size}px;
                left: ${x}px;
                top: ${y}px;
            `;

            this.style.position = 'relative';
            this.style.overflow = 'hidden';
            this.appendChild(ripple);

            setTimeout(() => ripple.remove(), 600);
        });
    });
}

function updateTime() {
    const now = new Date();
    const timeString = now.toLocaleTimeString('en-US', {
        hour12: false,
        hour: '2-digit',
        minute: '2-digit'
    });
    document.getElementById('current-time').textContent = timeString;
}

function switchTab(tabName) {
    // Re-render map when map tab is opened
    if (tabName === 'map') {
        setTimeout(function() {
            const canvas = document.getElementById('mapCanvas');
            const img = document.getElementById('mapImage');
            if (canvas && img) {
                drawMap();
            }
        }, 100);
    }
    // Update navigation
    document.querySelectorAll('.nav-item').forEach(item => {
        item.classList.remove('active');
    });
    document.querySelector(`[data-tab="${tabName}"]`).classList.add('active');

    // Update content
    document.querySelectorAll('.tab-content').forEach(tab => {
        tab.classList.remove('active');
    });
    document.getElementById(`${tabName}-tab`).classList.add('active');

    currentTab = tabName;

    // Load tab-specific data
    loadTabData(tabName);
}

function loadTabData(tabName) {
    switch (tabName) {
        case 'dashboard':
            loadActiveUnits();
            break;
        case 'reports':
            loadReports();
            break;
        case 'bolos':
            loadBOLOs();
            break;
        case 'dispatch':
            loadActiveCalls();
            break;
        case 'map':
            renderZones();
            break;
        case 'bodycam':
            loadBodycamFeeds();
            break;
        case 'cameras':
            loadCameras();
            break;
        case 'logs':
            loadStaffLogs();
            break;
        case 'settings':
            loadSettings();
            break;
    }
}

function loadInitialData() {
    // Initialize stats to 0
    updateQuickStats();
    
    // Load all dashboard data (just fetch, don't render)
    loadActiveUnits();
    
    // Load reports data for stats
    fetchNUI('getReports')
        .then(() => {
            console.log('Reports request sent');
        })
        .catch(err => {
            console.error('Failed to load reports:', err);
            reports = [];
            updateQuickStats();
        });
    
    // Load BOLOs data for stats
    fetchNUI('getBOLOs')
        .then(() => {
            console.log('BOLOs request sent');
        })
        .catch(err => {
            console.error('Failed to load BOLOs:', err);
            bolos = [];
            updateQuickStats();
        });
}

// Dashboard Functions
function loadActiveUnits() {
    const container = document.getElementById('unitsGrid');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Loading active units...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('getActiveUnits')
        .catch(err => {
            console.error('Failed to load active units:', err);
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Error Loading Units</h3>
                    <p>Failed to connect to server</p>
                </div>
            `;
        });
}

function renderActiveUnits() {
    const container = document.getElementById('unitsGrid');

    if (!activeUnits || activeUnits.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-users"></i>
                <h3>No Active Units</h3>
                <p>There are currently no active police units</p>
            </div>
        `;
        return;
    }

    container.innerHTML = activeUnits.map(unit => {
        const statusClass = (unit.status === 'busy' || unit.status === 'BUSY') ? 'status-busy' : 'status-available';
        const statusText = (unit.status === 'busy' || unit.status === 'BUSY') ? 'BUSY' : 'AVAILABLE';
        const statusColor = (unit.status === 'busy' || unit.status === 'BUSY') ? 'var(--ipad-orange)' : 'var(--ipad-green)';
        
        return `
        <div class="unit-card">
            <div class="unit-header">
                <div class="unit-name">${unit.name || 'Unknown'}</div>
                <div class="unit-badge">${unit.badge || 'N/A'}</div>
            </div>
            <div class="unit-status ${statusClass}" style="background: ${statusColor}15; color: ${statusColor}; border: 1px solid ${statusColor}40;">
                ${statusText}
            </div>
            <div class="unit-info">
                <p><strong>Location:</strong> ${unit.location || 'Unknown'}</p>
                <p><strong>Current Call:</strong> ${unit.call || 'Available'}</p>
            </div>
        </div>
        `;
    }).join('');
}

function updateQuickStats() {
    const activeUnitsCount = activeUnits ? activeUnits.length : 0;
    const reportsCount = reports ? reports.length : 0;
    const bolosCount = bolos ? bolos.length : 0;
    const incidentsCount = activeUnits ? activeUnits.filter(u => u.status === 'busy' || u.status === 'BUSY').length : 0;
    
    const activeUnitsEl = document.getElementById('activeUnitsCount');
    const reportsEl = document.getElementById('reportsCount');
    const bolosEl = document.getElementById('bolosCount');
    const incidentsEl = document.getElementById('incidentsCount');
    
    if (activeUnitsEl) activeUnitsEl.textContent = activeUnitsCount;
    if (reportsEl) reportsEl.textContent = reportsCount;
    if (bolosEl) bolosEl.textContent = bolosCount;
    if (incidentsEl) incidentsEl.textContent = incidentsCount;
}

// Report Functions
function showReportForm() {
    document.getElementById('reportForm').style.display = 'block';
}

function hideReportForm() {
    document.getElementById('reportForm').style.display = 'none';
}

function submitReport() {
    const reportData = {
        title: document.getElementById('reportTitle').value,
        location: document.getElementById('reportLocation').value,
        summary: document.getElementById('reportSummary').value,
        suspects: document.getElementById('reportSuspects').value,
        fine: parseInt(document.getElementById('reportFine').value) || 0
    };

    // Validate required fields
    if (!reportData.title || !reportData.location || !reportData.summary) {
        showAlert('Please fill in all required fields', 'warning');
        return;
    }

    // Call FiveM NUI callback
    fetchNUI('submitReport', { report: reportData })
        .then(response => {
            if (response.success) {
                // Reset form and hide
                document.getElementById('incidentForm').reset();
                hideReportForm();
                loadReports();
                showAlert('Report submitted successfully!', 'success');
            } else {
                showAlert('Failed to submit report: ' + (response.error || 'Unknown error'), 'warning');
            }
        })
        .catch(err => {
            console.error('Failed to submit report:', err);
            showAlert('Failed to submit report. Please try again.', 'warning');
        });
}

function loadReports() {
    const container = document.getElementById('reportsList');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Loading reports...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('getReports')
        .catch(err => {
            console.error('Failed to load reports:', err);
            renderReports();
            updateQuickStats();
        });
}

function renderReports() {
    const container = document.getElementById('reportsList');

    if (reports.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-file-alt"></i>
                <h3>No Reports</h3>
                <p>No incident reports have been filed yet</p>
            </div>
        `;
        return;
    }

    container.innerHTML = reports.map(report => `
        <div class="report-item">
            <div class="report-header">
                <div class="report-title">${report.title}</div>
                <div class="report-date">${report.date} ${report.time}</div>
            </div>
            <div class="report-summary">${report.summary}</div>
            <div class="report-meta">
                <span><strong>Location:</strong> ${report.location}</span>
                <span><strong>Fine:</strong> $${report.fine}</span>
                <span><strong>Status:</strong> ${report.status}</span>
            </div>
        </div>
    `).join('');
}

// BOLO Functions
function loadBOLOs() {
    const container = document.getElementById('bolosGrid');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Loading BOLOs...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('getBOLOs')
        .catch(err => {
            console.error('Failed to load BOLOs:', err);
            renderBOLOs();
            updateQuickStats();
        });
}

function renderBOLOs() {
    const container = document.getElementById('bolosGrid');

    if (bolos.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-bullhorn"></i>
                <h3>No Active BOLOs</h3>
                <p>There are currently no active BOLO alerts</p>
            </div>
        `;
        return;
    }

    container.innerHTML = bolos.map(bolo => `
        <div class="bolo-item">
            <div class="bolo-header">
                <div class="bolo-title">${bolo.title}</div>
                <div class="bolo-date">${bolo.date}</div>
            </div>
            <div class="bolo-description">${bolo.description}</div>
        </div>
    `).join('');
}

// Search Functions
let isSearching = false;

function searchProfiles() {
    // Prevent multiple simultaneous searches
    if (isSearching) {
        console.log('Search already in progress, please wait...');
        return;
    }
    
    const query = document.getElementById('profileSearch').value.trim();
    if (!query) {
        showAlert('Please enter a search term', 'warning');
        return;
    }

    isSearching = true;
    const container = document.getElementById('profilesResults');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Searching profiles...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('searchProfiles', { query: query })
        .then(response => {
            console.log('Search request sent, waiting for results...');
            // Results will come via receiveProfiles message
            // Reset search flag after a delay to allow results to come in
            setTimeout(() => {
                isSearching = false;
            }, 2000);
        })
        .catch(err => {
            console.error('Failed to search profiles:', err);
            isSearching = false;
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Search Failed</h3>
                    <p>Failed to connect to server. Error: ${err.message || 'Unknown error'}</p>
                </div>
            `;
        });
}

function renderProfiles(profiles) {
    const container = document.getElementById('profilesResults');
    
    if (!profiles || profiles.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-search"></i>
                <h3>No Results Found</h3>
                <p>No profiles match your search criteria</p>
            </div>
        `;
        return;
    }

    container.innerHTML = profiles.map(profile => `
        <div class="report-item profile-item">
            <div class="profile-image">
                <img src="citizen.png" alt="Profile" onerror="this.style.display='none';">
            </div>
            <div class="profile-content">
                <div class="report-header">
                    <div class="report-title">${profile.name || 'Unknown'}</div>
                </div>
                <div class="report-summary">
                    ${profile.dob ? `<p><strong>DOB:</strong> ${profile.dob}</p>` : ''}
                    ${profile.address ? `<p><strong>Address:</strong> ${profile.address}</p>` : ''}
                    ${profile.convictions ? `<p><strong>Convictions:</strong> ${profile.convictions}</p>` : ''}
                    ${profile.license ? `<p><strong>License Status:</strong> ${profile.license}</p>` : ''}
                </div>
            </div>
        </div>
    `).join('');
}

function searchVehicle() {
    const plate = document.getElementById('plateSearch').value;
    if (!plate) {
        showAlert('Please enter a license plate', 'warning');
        return;
    }

    const container = document.getElementById('vehicleResults');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Searching DMV database...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('searchVehicle', { plate: plate })
        .catch(err => {
            console.error('Failed to search vehicle:', err);
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Search Failed</h3>
                    <p>Failed to connect to server</p>
                </div>
            `;
        });
}

function renderVehicle(vehicle) {
    const container = document.getElementById('vehicleResults');
    
    if (!vehicle || Object.keys(vehicle).length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-car"></i>
                <h3>No Vehicle Found</h3>
                <p>No vehicle matches this license plate</p>
            </div>
        `;
        return;
    }

    container.innerHTML = `
        <div class="report-item">
            <div class="report-header">
                <div class="report-title">Vehicle Search: ${vehicle.plate || 'N/A'}</div>
            </div>
            <div class="report-summary">
                ${vehicle.make ? `<p><strong>Make:</strong> ${vehicle.make}</p>` : ''}
                ${vehicle.model ? `<p><strong>Model:</strong> ${vehicle.model}</p>` : ''}
                ${vehicle.color ? `<p><strong>Color:</strong> ${vehicle.color}</p>` : ''}
                ${vehicle.owner ? `<p><strong>Owner:</strong> ${vehicle.owner}</p>` : ''}
                ${vehicle.registration ? `<p><strong>Registration:</strong> ${vehicle.registration}</p>` : ''}
                ${vehicle.status ? `<p><strong>Status:</strong> <span style="color: var(--ipad-red); font-weight: 600;">${vehicle.status}</span></p>` : ''}
            </div>
        </div>
    `;
}

function searchWeapons() {
    const query = document.getElementById('weaponSearch').value;
    if (!query) {
        showAlert('Please enter a search term', 'warning');
        return;
    }

    const container = document.getElementById('weaponsResults');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Searching weapons registry...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('searchWeapons', { query: query })
        .catch(err => {
            console.error('Failed to search weapons:', err);
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Search Failed</h3>
                    <p>Failed to connect to server</p>
                </div>
            `;
        });
}

function renderWeapons(weapons) {
    const container = document.getElementById('weaponsResults');
    
    if (!weapons || weapons.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-gun"></i>
                <h3>No Weapons Found</h3>
                <p>No weapons match your search criteria</p>
            </div>
        `;
        return;
    }

    container.innerHTML = weapons.map(weapon => `
        <div class="report-item">
            <div class="report-header">
                <div class="report-title">Weapon: ${weapon.serial || weapon.type || 'Unknown'}</div>
            </div>
            <div class="report-summary">
                ${weapon.serial ? `<p><strong>Serial Number:</strong> ${weapon.serial}</p>` : ''}
                ${weapon.type ? `<p><strong>Type:</strong> ${weapon.type}</p>` : ''}
                ${weapon.owner ? `<p><strong>Registered Owner:</strong> ${weapon.owner}</p>` : ''}
                ${weapon.status ? `<p><strong>Registration Status:</strong> ${weapon.status}</p>` : ''}
                ${weapon.lastChecked ? `<p><strong>Last Checked:</strong> ${weapon.lastChecked}</p>` : ''}
            </div>
        </div>
    `).join('');
}

// Camera Functions
function loadCameras() {
    const container = document.getElementById('camerasGrid');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Loading camera feeds...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('getCameras')
        .catch(err => {
            console.error('Failed to load cameras:', err);
            renderCameras([]);
        });
}

function renderCameras(cameras) {
    const container = document.getElementById('camerasGrid');
    
    if (!cameras || cameras.length === 0) {
        container.innerHTML = `
            <div class="report-item">
                <div class="report-header">
                    <div class="report-title">Surveillance Camera System</div>
                </div>
                <div class="report-summary">
                    <p>Camera system would integrate with your FiveM server's surveillance cameras.</p>
                    <p>Live feeds from security cameras around Los Santos would be displayed here.</p>
                    <div style="background: #000; color: #fff; padding: 20px; border-radius: 8px; margin-top: 15px; text-align: center;">
                        <i class="fas fa-video" style="font-size: 48px; margin-bottom: 10px;"></i>
                        <p>LIVE CAMERA FEED</p>
                        <p style="font-size: 12px; opacity: 0.7;">FiveM Camera Integration</p>
                    </div>
                </div>
            </div>
        `;
        return;
    }

    container.innerHTML = cameras.map(camera => `
        <div class="report-item">
            <div class="report-header">
                <div class="report-title">${camera.name || 'Camera ' + camera.id}</div>
            </div>
            <div class="report-summary">
                <p><strong>Location:</strong> ${camera.location || 'Unknown'}</p>
                ${camera.status ? `<p><strong>Status:</strong> ${camera.status}</p>` : ''}
            </div>
        </div>
    `).join('');
}

// Staff Logs Functions
function loadStaffLogs() {
    const container = document.getElementById('logsList');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Loading staff logs...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('getStaffLogs')
        .catch(err => {
            console.error('Failed to load staff logs:', err);
            renderStaffLogs([]);
        });
}

function renderStaffLogs(logs) {
    const container = document.getElementById('logsList');
    
    if (!logs || logs.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-clipboard-list"></i>
                <h3>No Staff Logs</h3>
                <p>No duty logs available</p>
            </div>
        `;
        return;
    }

    container.innerHTML = logs.map(log => `
        <div class="log-item">
            <div class="report-header">
                <div class="report-title">${log.officer || log.name || 'Unknown'} - ${log.badge || 'N/A'}</div>
                <div class="report-date">${log.duration || 'N/A'}</div>
            </div>
            <div class="report-summary">
                Shift: ${log.start || 'N/A'} - ${log.end || 'N/A'}
            </div>
        </div>
    `).join('');
}

// Utility Functions
function showAlert(message, type = 'info') {
    // Create iOS-style alert
    const alert = document.createElement('div');
    alert.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: var(--ipad-card);
        border: 1px solid var(--ipad-border);
        border-radius: 14px;
        padding: 16px 20px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        z-index: 1000;
        max-width: 300px;
        animation: slideIn 0.3s ease-out;
    `;

    alert.innerHTML = `
        <div style="display: flex; align-items: center; gap: 12px;">
            <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'warning' ? 'exclamation-triangle' : 'info-circle'}" 
               style="color: ${type === 'success' ? 'var(--ipad-green)' : type === 'warning' ? 'var(--ipad-orange)' : 'var(--ipad-blue)'}"></i>
            <span>${message}</span>
        </div>
    `;

    document.body.appendChild(alert);

    setTimeout(() => {
        alert.style.animation = 'slideOut 0.3s ease-in';
        setTimeout(() => alert.remove(), 300);
    }, 3000);
}

function dispatchCall() {
    showAlert('Dispatch system would open here', 'info');
}

function showBoloForm() {
    showAlert('New BOLO form would open here', 'info');
}

// Dispatch Functions
let zones = [];
let currentZoneType = null;

function loadActiveCalls() {
    const container = document.getElementById('activeCalls');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Loading active calls...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('getActiveCalls')
        .catch(err => {
            console.error('Failed to load active calls:', err);
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Error Loading Calls</h3>
                    <p>Failed to connect to server</p>
                </div>
            `;
        });
}

function renderActiveCalls(calls) {
    const container = document.getElementById('activeCalls');
    
    if (!calls || calls.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-broadcast-tower"></i>
                <h3>No Active Calls</h3>
                <p>There are currently no active dispatch calls</p>
            </div>
        `;
        return;
    }

    container.innerHTML = calls.map(call => `
        <div class="call-item">
            <div class="call-header">
                <div class="call-code">${call.code || 'N/A'}</div>
                <div class="call-priority priority-${call.priority || 'medium'}">${(call.priority || 'medium').toUpperCase()}</div>
            </div>
            <div class="call-location">${call.location || 'Unknown Location'}</div>
            <div class="call-description">${call.description || 'No description'}</div>
            ${call.units && call.units.length > 0 ? `
                <div class="call-units" style="margin-top: 8px; font-size: 12px; color: var(--ipad-gray);">
                    <strong>Units:</strong> ${call.units.join(', ')}
                </div>
            ` : ''}
        </div>
    `).join('');
}

function createNewCall() {
    showAlert('New call creation interface would open here', 'info');
}

function assignUnit() {
    const unit = document.getElementById('availableUnits').value;
    const call = document.getElementById('activeCallList').value;
    showAlert(`Assigned ${unit} to ${call}`, 'success');
}

// Map Functions
function addZone(type) {
    currentZoneType = type;
    showAlert(`Click on the map to place a ${type} zone`, 'info');

    // In a real implementation, this would set up click listeners on the map
    // For this demo, we'll automatically add a zone
    setTimeout(() => {
        createZone(type);
    }, 500);
}

function createZone(type) {
    const zoneId = zones.length + 1;
    const colors = {
        circle: '#007aff',
        square: '#34c759',
        polygon: '#ff9500'
    };

    const zone = {
        id: zoneId,
        type: type,
        name: `${type.charAt(0).toUpperCase() + type.slice(1)} Zone ${zoneId}`,
        color: colors[type],
        position: {
            x: Math.random() * 70 + 15,
            y: Math.random() * 70 + 15
        }
    };

    zones.push(zone);
    renderZones();
    showAlert(`Created ${zone.name}`, 'success');
}

function renderZones() {
    const overlay = document.getElementById('mapOverlay');
    const list = document.getElementById('zonesList');

    if (!overlay || !list) return;

    // Clear existing zones
    overlay.innerHTML = '';
    list.innerHTML = '';

    zones.forEach(zone => {
        // Create zone visual on map
        const zoneElement = document.createElement('div');
        zoneElement.className = `zone-${zone.type}`;
        zoneElement.style.cssText = `
            position: absolute;
            left: ${zone.position.x}%;
            top: ${zone.position.y}%;
            width: 80px;
            height: 80px;
            border: 2px solid ${zone.color};
            background: ${zone.color}20;
            border-radius: ${zone.type === 'circle' ? '50%' : '4px'};
            pointer-events: none;
        `;

        overlay.appendChild(zoneElement);

        // Add to legend
        const listItem = document.createElement('div');
        listItem.className = 'zone-item';
        listItem.style.cssText = 'display: flex; align-items: center; gap: 12px; padding: 8px; margin-bottom: 4px; background: var(--ipad-card); border-radius: 8px;';
        listItem.innerHTML = `
            <div style="width: 20px; height: 20px; background: ${zone.color}; border-radius: 4px;"></div>
            <div style="flex: 1;">
                <div style="font-weight: 600; font-size: 14px;">${zone.name}</div>
                <div style="font-size: 12px; color: var(--ipad-gray);">${zone.type}</div>
            </div>
            <button class="ios-btn" style="padding: 4px 8px; font-size: 12px;" onclick="removeZone(${zone.id})">
                <i class="fas fa-times"></i>
            </button>
        `;
        list.appendChild(listItem);
    });
}

function removeZone(zoneId) {
    zones = zones.filter(zone => zone.id !== zoneId);
    renderZones();
    showAlert('Zone removed', 'success');
}

function clearZones() {
    zones = [];
    renderZones();
    showAlert('All zones cleared', 'success');
}

// Bodycam Functions
function loadBodycamFeeds() {
    const feedsContainer = document.getElementById('bodycamFeeds');
    const recordingsContainer = document.getElementById('bodycamRecordings');

    if (!feedsContainer || !recordingsContainer) return;

    feedsContainer.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Loading bodycam feeds...</p>
        </div>
    `;

    recordingsContainer.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Loading recordings...</p>
        </div>
    `;

    // Call FiveM NUI callback
    fetchNUI('getBodycamFeeds')
        .catch(err => {
            console.error('Failed to load bodycam feeds:', err);
            renderBodycamFeeds([]);
            renderBodycamRecordings([]);
        });
}

function renderBodycamFeeds(feeds) {
    const container = document.getElementById('bodycamFeeds');
    if (!container) return;
    
    if (!feeds || feeds.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-camera"></i>
                <h3>No Active Feeds</h3>
                <p>No body cameras are currently streaming</p>
            </div>
        `;
        return;
    }

    container.innerHTML = feeds.map(feed => `
        <div class="feed-item">
            <div class="feed-header">
                <div class="feed-officer">${feed.officer || 'Unknown'}</div>
                <div class="feed-status" style="background: ${feed.status === 'LIVE' ? 'var(--ipad-red)' : 'var(--ipad-gray)'}">
                    ${feed.status || 'OFFLINE'}
                </div>
            </div>
            <div class="feed-placeholder">
                <div style="text-align: center;">
                    <i class="fas fa-video" style="font-size: 32px; margin-bottom: 8px;"></i>
                    <div>${feed.officer || 'Unknown'}</div>
                    <div style="font-size: 12px; opacity: 0.7;">${feed.location || 'Unknown Location'}</div>
                    <div style="font-size: 11px; opacity: 0.5; margin-top: 8px;">FiveM Bodycam Integration</div>
                </div>
            </div>
        </div>
    `).join('');
}

function renderBodycamRecordings(recordings) {
    const container = document.getElementById('bodycamRecordings');
    if (!container) return;
    
    if (!recordings || recordings.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-video"></i>
                <h3>No Recordings</h3>
                <p>No body camera recordings available</p>
            </div>
        `;
        return;
    }

    container.innerHTML = recordings.map(recording => `
        <div class="recording-item">
            <div class="recording-icon">
                <i class="fas fa-play"></i>
            </div>
            <div class="recording-info">
                <div class="recording-name">${recording.name || 'Recording'}</div>
                <div class="recording-meta">
                    ${recording.date || 'N/A'} • ${recording.duration || 'N/A'} • ${recording.officer || 'Unknown'}
                </div>
            </div>
        </div>
    `).join('');
}

function startBodycam() {
    showAlert('Body camera recording started', 'success');
}

// Close MDT callback
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape' || e.keyCode === 27) {
        // Hide UI immediately
        document.body.classList.remove('mdt-open');
        // Notify client to close MDT
        fetchNUI('close').catch(err => console.error('Failed to close MDT:', err));
    }
});

// Add CSS for animations
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    
    @keyframes slideOut {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(100%); opacity: 0; }
    }
    
    @keyframes ripple {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Settings Functions
let mdtSettings = {
    badge: '',
    theme: 'light',
    primaryColor: '#007aff',
    accentColor: '#007aff',
    backgroundColor: '#f5f5f7',
    cardColor: '#ffffff'
};

function setupSettingsListeners() {
    // Sync color pickers with text inputs
    const colorPickers = ['primaryColor', 'accentColor', 'backgroundColor', 'cardColor'];
    
    colorPickers.forEach(colorName => {
        const picker = document.getElementById(colorName);
        const textInput = document.getElementById(colorName + 'Text');
        
        if (picker && textInput) {
            // Color picker -> text input
            picker.addEventListener('input', function() {
                textInput.value = this.value.toUpperCase();
            });
            
            // Text input -> color picker
            textInput.addEventListener('input', function() {
                const color = this.value;
                if (/^#[0-9A-F]{6}$/i.test(color)) {
                    picker.value = color;
                }
            });
        }
    });
}

function loadSettings() {
    // Load from localStorage
    const saved = localStorage.getItem('mdtSettings');
    if (saved) {
        try {
            mdtSettings = JSON.parse(saved);
        } catch (e) {
            console.error('Error loading settings:', e);
        }
    }
    
    // Apply settings to UI
    if (document.getElementById('badgeNumber')) {
        document.getElementById('badgeNumber').value = mdtSettings.badge || '';
    }
    if (document.getElementById('themeSelect')) {
        document.getElementById('themeSelect').value = mdtSettings.theme || 'light';
    }
    
    // Apply color settings
    const colorPickers = ['primaryColor', 'accentColor', 'backgroundColor', 'cardColor'];
    colorPickers.forEach(colorName => {
        const picker = document.getElementById(colorName);
        const textInput = document.getElementById(colorName + 'Text');
        const value = mdtSettings[colorName] || getDefaultColor(colorName);
        
        if (picker) picker.value = value;
        if (textInput) textInput.value = value.toUpperCase();
    });
    
    // Apply theme and colors
    applySettings();
}

function saveSettings() {
    // Get values from inputs
    mdtSettings.badge = document.getElementById('badgeNumber').value.trim();
    mdtSettings.theme = document.getElementById('themeSelect').value;
    
    const colorPickers = ['primaryColor', 'accentColor', 'backgroundColor', 'cardColor'];
    colorPickers.forEach(colorName => {
        const picker = document.getElementById(colorName);
        if (picker) {
            mdtSettings[colorName] = picker.value;
        }
    });
    
    // Save to localStorage
    localStorage.setItem('mdtSettings', JSON.stringify(mdtSettings));
    
    // Apply settings
    applySettings();
    
    // Update badge in sidebar
    updateBadgeDisplay();
    
    // Show success message
    showAlert('Settings saved successfully!', 'success');
}

function resetSettings() {
    if (confirm('Are you sure you want to reset all settings to default?')) {
        // Reset to defaults
        mdtSettings = {
            badge: '',
            theme: 'light',
            primaryColor: '#007aff',
            accentColor: '#007aff',
            backgroundColor: '#f5f5f7',
            cardColor: '#ffffff'
        };
        
        // Clear localStorage
        localStorage.removeItem('mdtSettings');
        
        // Reload settings UI
        loadSettings();
        
        showAlert('Settings reset to default', 'success');
    }
}

function getDefaultColor(colorName) {
    const defaults = {
        primaryColor: '#007aff',
        accentColor: '#007aff',
        backgroundColor: '#f5f5f7',
        cardColor: '#ffffff'
    };
    return defaults[colorName] || '#007aff';
}

function applySettings() {
    const root = document.documentElement;
    
    // Apply theme
    document.body.classList.remove('theme-light', 'theme-dark');
    if (mdtSettings.theme === 'dark') {
        document.body.classList.add('theme-dark');
    } else if (mdtSettings.theme === 'auto') {
        // Auto theme based on system preference
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        document.body.classList.add(prefersDark ? 'theme-dark' : 'theme-light');
    } else {
        document.body.classList.add('theme-light');
    }
    
    // Apply colors via CSS variables
    root.style.setProperty('--ipad-blue', mdtSettings.primaryColor || '#007aff');
    root.style.setProperty('--ipad-bg', mdtSettings.backgroundColor || '#f5f5f7');
    root.style.setProperty('--ipad-card', mdtSettings.cardColor || '#ffffff');
    
    // Apply accent color to active nav items
    const style = document.createElement('style');
    style.id = 'custom-theme-style';
    style.textContent = `
        .nav-item.active {
            background: ${mdtSettings.accentColor || '#007aff'}15;
            color: ${mdtSettings.accentColor || '#007aff'};
        }
        .nav-item.active i {
            color: ${mdtSettings.accentColor || '#007aff'};
        }
        .ios-btn.primary {
            background: ${mdtSettings.primaryColor || '#007aff'};
            border-color: ${mdtSettings.primaryColor || '#007aff'};
        }
        .ios-btn.primary:hover {
            background: ${adjustBrightness(mdtSettings.primaryColor || '#007aff', -10)};
        }
    `;
    
    // Remove old style if exists
    const oldStyle = document.getElementById('custom-theme-style');
    if (oldStyle) oldStyle.remove();
    
    document.head.appendChild(style);
}

function adjustBrightness(color, percent) {
    const num = parseInt(color.replace('#', ''), 16);
    const amt = Math.round(2.55 * percent);
    const R = Math.max(0, Math.min(255, (num >> 16) + amt));
    const G = Math.max(0, Math.min(255, ((num >> 8) & 0x00FF) + amt));
    const B = Math.max(0, Math.min(255, (num & 0x0000FF) + amt));
    return '#' + (0x1000000 + R * 0x10000 + G * 0x100 + B).toString(16).slice(1);
}

function updateBadgeDisplay() {
    const badgeElement = document.querySelector('.user-details .badge');
    if (badgeElement && mdtSettings.badge) {
        badgeElement.textContent = `Badge: ${mdtSettings.badge}`;
    }
}