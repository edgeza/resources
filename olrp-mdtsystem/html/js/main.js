// Main JavaScript file for MDT System
class MDTSystem {
    constructor() {
        this.currentPage = 'dashboard';
        this.userData = null;
        this.notifications = [];
        this.isLoading = false;
        this.charts = {};
        
        this.init();
    }

    async init() {
        try {
            // Ensure MDT is hidden on init
            this.hideMDT();
            
            // Apply saved text color (only if different from default)
            const savedTextColor = this.getTextColor();
            if (savedTextColor && savedTextColor.startsWith('#')) {
                try {
                    this.applyTextColor(savedTextColor);
                } catch (e) {
                    console.error('Error applying text color:', e);
                }
            }
            
            // Apply saved background color
            const savedBgColor = this.getBackgroundColor();
            if (savedBgColor) {
                this.applyBackgroundColor(savedBgColor);
            }
            
            // Load data in background (no need to show loading for initial load)
            await this.loadUserData();
            await this.setupEventListeners();
            await this.loadDashboardData();
            
            // Don't automatically show MDT - wait for Lua client to trigger it
        } catch (error) {
            console.error('Failed to initialize MDT:', error);
            this.showError('Failed to initialize MDT system');
        }
    }

    showLoading() {
        const loadingScreen = document.getElementById('loading-screen');
        if (loadingScreen) {
        loadingScreen.classList.remove('hidden');
        }
    }

    hideLoading() {
        const loadingScreen = document.getElementById('loading-screen');
        if (loadingScreen) {
        loadingScreen.classList.add('hidden');
        }
    }

    showMDT() {
        console.log('MDT: showMDT() called');
        
        // Apply saved text color
        const savedTextColor = this.getTextColor();
        if (savedTextColor && savedTextColor.startsWith('#')) {
            try {
                this.applyTextColor(savedTextColor);
            } catch (e) {
                console.error('Error applying text color:', e);
            }
        }
        
        // Apply saved background color
        const savedBgColor = this.getBackgroundColor();
        if (savedBgColor) {
            this.applyBackgroundColor(savedBgColor);
        }
        
        // Show loading screen first
        this.showLoading();
        
        // Hide loading and show MDT after 2 seconds
        setTimeout(() => {
            this.hideLoading();
            const mdtContainer = document.getElementById('mdt-container');
            mdtContainer.style.display = 'flex';
            mdtContainer.style.visibility = 'visible';
            mdtContainer.style.opacity = '1';
            console.log('MDT: Container shown');
        }, 2000);
    }

    hideMDT() {
        const mdtContainer = document.getElementById('mdt-container');
        mdtContainer.style.display = 'none';
        mdtContainer.style.visibility = 'hidden';
        mdtContainer.style.opacity = '0';
        
        // Release NUI focus by sending message to Lua
        try {
            fetch(`https://${GetParentResourceName()}/hide`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });
        } catch (e) {
            console.error('Error releasing NUI focus:', e);
        }
    }

    closeMDT() {
        console.log('MDT: Closing MDT via close button');
        this.hideMDT();
        
        // Send close message to Lua client
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({})
        }).catch(err => {
            console.error('Error sending close message:', err);
        });
    }

    async loadUserData() {
        return new Promise((resolve) => {
            // Simulate API call to get user data
            setTimeout(() => {
                // Check if ambulance theme
                const isAmbulance = document.body.classList.contains('ambulance-theme');
                
                this.userData = {
                    name: 'John Doe',
                    badge: isAmbulance ? 'Paramedic' : 'Officer',
                    department: isAmbulance ? 'Medical Services' : 'Police',
                    rank: isAmbulance ? 'Paramedic' : 'Officer',
                    callsign: isAmbulance ? 'EMS-12' : '1A-12'
                };
                this.updateUserInfo();
                resolve();
            }, 1000);
        });
    }

    updateUserInfo(playerData) {
        const userName = document.getElementById('user-name');
        const userBadge = document.getElementById('user-badge');
        
        // Check if ambulance theme
        const isAmbulance = document.body.classList.contains('ambulance-theme');
        const defaultBadge = isAmbulance ? 'Paramedic' : 'Officer';
        
        if (userName && userBadge) {
            if (playerData) {
                userName.textContent = playerData.name || 'Unknown';
                userBadge.textContent = playerData.badge || defaultBadge;
            } else if (this.userData) {
                userName.textContent = this.userData.name;
                userBadge.textContent = this.userData.badge;
            }
        }
    }
    
    enableAmbulanceTheme() {
        document.body.classList.add('ambulance-theme');
        const mainLogo = document.getElementById('main-logo');
        const sidebarEmblem = document.getElementById('sidebar-emblem');
        const departmentName = document.getElementById('department-name');
        
        if (mainLogo) {
            mainLogo.querySelector('i').className = 'fas fa-ambulance';
            mainLogo.querySelector('span').textContent = 'EMS MDT';
        }
        
        if (departmentName) {
            departmentName.textContent = 'MEDICAL SERVICES';
        }
        
        // Update logo icon
        const emblemImg = sidebarEmblem?.querySelector('img');
        if (emblemImg) {
            // Hide the image and use icon instead for ambulance
            emblemImg.style.display = 'none';
            if (!sidebarEmblem.querySelector('.fa-ambulance-icon')) {
                const icon = document.createElement('i');
                icon.className = 'fas fa-heartbeat emblem-icon';
                icon.id = 'ambulance-icon';
                sidebarEmblem.insertBefore(icon, sidebarEmblem.firstChild);
            }
        }
        
        // Show ambulance navigation, hide police navigation
        document.querySelectorAll('.police-nav').forEach(el => el.style.display = 'none');
        document.querySelectorAll('.ambulance-nav').forEach(el => el.style.display = 'block');
        
        // Switch to EMS dashboard
        const policeDashboard = document.getElementById('dashboard-page');
        const emsDashboard = document.getElementById('ems-dashboard-page');
        if (policeDashboard) policeDashboard.style.display = 'none';
        if (emsDashboard) emsDashboard.style.display = 'block';
        
        // Apply red background for EMS by default
        this.applyBackgroundColor('red');
    }
    
    enablePoliceTheme() {
        document.body.classList.remove('ambulance-theme');
        const mainLogo = document.getElementById('main-logo');
        const departmentName = document.getElementById('department-name');
        
        if (mainLogo) {
            mainLogo.querySelector('i').className = 'fas fa-shield-alt';
            mainLogo.querySelector('span').textContent = 'OLRP MDT';
        }
        
        if (departmentName) {
            departmentName.textContent = 'LSPD';
        }
        
        const sidebarEmblem = document.getElementById('sidebar-emblem');
        const emblemImg = sidebarEmblem?.querySelector('img');
        if (emblemImg) {
            emblemImg.style.display = 'block';
        }
        const ambulanceIcon = document.getElementById('ambulance-icon');
        if (ambulanceIcon) {
            ambulanceIcon.remove();
        }
        
        // Show police navigation, hide ambulance navigation
        document.querySelectorAll('.police-nav').forEach(el => el.style.display = 'block');
        document.querySelectorAll('.ambulance-nav').forEach(el => el.style.display = 'none');
        
        // Switch to Police dashboard
        const policeDashboard = document.getElementById('dashboard-page');
        const emsDashboard = document.getElementById('ems-dashboard-page');
        if (policeDashboard) policeDashboard.style.display = 'block';
        if (emsDashboard) emsDashboard.style.display = 'none';
        
        // Apply default dark background for police
        this.applyBackgroundColor('dark');
    }

    setupEventListeners() {
        // Navigation
        document.querySelectorAll('.nav-item').forEach(item => {
            item.addEventListener('click', (e) => {
                const page = e.currentTarget.dataset.page;
                console.log('MDT: Navigation clicked:', page);
                this.navigateToPage(page);
            });
        });

        // Search functionality
        const globalSearch = document.getElementById('global-search');
        if (globalSearch) {
            globalSearch.addEventListener('input', (e) => {
                this.handleGlobalSearch(e.target.value);
            });
        }

        // Action buttons
        document.getElementById('notifications-btn')?.addEventListener('click', () => {
            this.showNotifications();
        });

        document.getElementById('settings-btn')?.addEventListener('click', () => {
            this.showSettings();
        });

        document.getElementById('logout-btn')?.addEventListener('click', () => {
            this.logout();
        });

        document.getElementById('close-mdt-btn')?.addEventListener('click', () => {
            this.closeMDT();
        });

        // Page-specific buttons
        document.getElementById('new-incident-btn')?.addEventListener('click', () => {
            console.log('MDT: New Incident button clicked');
            this.showNewIncidentModal();
        });

        document.getElementById('add-citizen-btn')?.addEventListener('click', () => {
            this.showAddCitizenModal();
        });

        document.getElementById('add-vehicle-btn')?.addEventListener('click', () => {
            this.showAddVehicleModal();
        });

        document.getElementById('new-incident-report-btn')?.addEventListener('click', () => {
            this.showNewIncidentReportModal();
        });

        // Modal controls
        document.getElementById('modal-close')?.addEventListener('click', () => {
            this.closeModal();
        });

        document.getElementById('modal-overlay')?.addEventListener('click', (e) => {
            if (e.target.id === 'modal-overlay') {
                this.closeModal();
            }
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', (e) => {
            this.handleKeyboardShortcuts(e);
        });
    }

    navigateToPage(page) {
        // Update active nav item
        document.querySelectorAll('.nav-item').forEach(item => {
            item.classList.remove('active');
        });
        const navTarget = document.querySelector(`[data-page="${page}"]`);
        if (navTarget) {
            navTarget.classList.add('active');
        }

        // Hide all pages and remove active state
        const allPages = document.querySelectorAll('.page');
        allPages.forEach(el => {
            el.classList.remove('active');
            // Force-hide to avoid any stylesheet conflicts
            el.style.display = 'none';
        });

        // Show requested page
        const targetPage = document.getElementById(`${page}-page`);
        if (!targetPage) {
            console.warn(`MDT: Page element not found for`, page);
            return;
        }
        targetPage.classList.add('active');
        // Force-show to ensure visibility even if CSS specificity interferes
        targetPage.style.display = 'block';

        this.currentPage = page;
        // Load data safely
        try {
            this.loadPageData(page);
        } catch (e) {
            console.error('MDT: Error loading page data for', page, e);
        }
    }

    async loadPageData(page) {
        switch (page) {
            case 'dashboard':
                await this.loadDashboardData();
                break;
            case 'citizens':
                await this.loadCitizensData();
                break;
            case 'vehicles':
                await this.loadVehiclesData();
                break;
            case 'incidents':
                await this.loadIncidentsData();
                break;
            case 'map':
                await this.loadMapData();
                // Initialize 3D map after a short delay to ensure DOM is ready
                setTimeout(() => {
                    this.initMap3D();
                }, 100);
                break;
            default:
                console.log(`Loading data for page: ${page}`);
        }
    }

    // Fetch data from server
    async fetchData(dataType, query = '') {
        return new Promise((resolve, reject) => {
            fetch(`https://${GetParentResourceName()}/getData`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    type: dataType,
                    query: query
                })
            })
            .then(response => response.json())
            .then(data => resolve(data))
            .catch(error => {
                console.error('MDT: Error fetching data:', error);
                reject(error);
            });
        });
    }

    async loadDashboardData() {
        try {
            // Fetch real dashboard data from server
            const dashboardData = await this.fetchData('dashboard');
            this.updateDashboardStats(dashboardData);
            this.createDashboardCharts(dashboardData);
        } catch (error) {
            console.error('Failed to load dashboard data:', error);
        }
    }

    async fetchDashboardData() {
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve({
                    activeCalls: 3,
                    openCases: 12,
                    arrestsToday: 5,
                    activeWarrants: 8,
                    crimeStats: {
                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                        data: [12, 19, 3, 5, 2, 3]
                    },
                    responseTimes: {
                        labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
                        data: [4.2, 3.8, 4.5, 3.9]
                    }
                });
            }, 500);
        });
    }

    updateDashboardStats(data) {
        document.getElementById('active-calls').textContent = data.activeCalls;
        document.getElementById('open-cases').textContent = data.openCases;
        document.getElementById('arrests-today').textContent = data.arrestsToday;
        document.getElementById('active-warrants').textContent = data.activeWarrants;
    }

    createDashboardCharts(data) {
        this.createCrimeChart(data.crimeStats);
        this.createResponseTimeChart(data.responseTimes);
    }

    createCrimeChart(data) {
        const ctx = document.getElementById('crime-chart');
        if (!ctx) return;

        if (this.charts.crime) {
            this.charts.crime.destroy();
        }

        this.charts.crime = new Chart(ctx, {
            type: 'line',
            data: {
                labels: data.labels,
                datasets: [{
                    label: 'Crime Reports',
                    data: data.data,
                    borderColor: '#1976D2',
                    backgroundColor: 'rgba(25, 118, 210, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        labels: {
                            color: '#FFFFFF'
                        }
                    }
                },
                scales: {
                    x: {
                        ticks: {
                            color: '#B0B0B0'
                        },
                        grid: {
                            color: '#333333'
                        }
                    },
                    y: {
                        ticks: {
                            color: '#B0B0B0'
                        },
                        grid: {
                            color: '#333333'
                        }
                    }
                }
            }
        });
    }

    createResponseTimeChart(data) {
        const ctx = document.getElementById('response-chart');
        if (!ctx) return;

        if (this.charts.response) {
            this.charts.response.destroy();
        }

        this.charts.response = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: data.labels,
                datasets: [{
                    label: 'Response Time (minutes)',
                    data: data.data,
                    backgroundColor: '#42A5F5',
                    borderColor: '#1976D2',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        labels: {
                            color: '#FFFFFF'
                        }
                    }
                },
                scales: {
                    x: {
                        ticks: {
                            color: '#B0B0B0'
                        },
                        grid: {
                            color: '#333333'
                        }
                    },
                    y: {
                        ticks: {
                            color: '#B0B0B0'
                        },
                        grid: {
                            color: '#333333'
                        }
                    }
                }
            }
        });
    }

    async loadCitizensData() {
        try {
            console.log('MDT: Loading citizens data...');
            const citizens = await this.fetchData('citizens');
            console.log('MDT: Received citizens data:', citizens);
            this.populateCitizensTable(citizens);
        } catch (error) {
            console.error('Failed to load citizens data:', error);
        }
    }

    async fetchCitizensData() {
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve([
                    { id: 1, name: 'John Smith', dob: '1990-05-15', license: 'D1234567', status: 'Active' },
                    { id: 2, name: 'Jane Doe', dob: '1985-12-03', license: 'D2345678', status: 'Active' },
                    { id: 3, name: 'Bob Johnson', dob: '1992-08-22', license: 'D3456789', status: 'Suspended' }
                ]);
            }, 500);
        });
    }

    populateCitizensTable(citizens) {
        console.log('MDT: Populating citizens table with:', citizens);
        const tbody = document.getElementById('citizens-tbody');
        if (!tbody) {
            console.error('MDT: citizens-tbody element not found');
            return;
        }

        if (!citizens || citizens.length === 0) {
            console.log('MDT: No citizens data to display');
            tbody.innerHTML = '<tr><td colspan="6" class="text-center">No citizens found</td></tr>';
            return;
        }

        tbody.innerHTML = citizens.map(citizen => `
            <tr>
                <td>${citizen.citizenid || 'N/A'}</td>
                <td>${citizen.firstname || ''} ${citizen.lastname || ''}</td>
                <td>${citizen.birthdate || 'N/A'}</td>
                <td>${citizen.license || 'N/A'}</td>
                <td><span class="status-badge ${(citizen.status || 'active').toLowerCase()}">${citizen.status || 'active'}</span></td>
                <td>
                    <button class="btn btn-sm btn-primary" onclick="mdtSystem.viewCitizen('${citizen.citizenid || ''}')">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn btn-sm btn-secondary" onclick="mdtSystem.editCitizen('${citizen.citizenid || ''}')">
                        <i class="fas fa-edit"></i>
                    </button>
                </td>
            </tr>
        `).join('');
    }

    async loadVehiclesData() {
        try {
            const vehicles = await this.fetchData('vehicles');
            this.populateVehiclesTable(vehicles);
        } catch (error) {
            console.error('Failed to load vehicles data:', error);
        }
    }

    async fetchVehiclesData() {
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve([
                    { plate: 'ABC123', model: 'Sedan', owner: 'John Smith', status: 'Valid', insurance: 'Active' },
                    { plate: 'XYZ789', model: 'SUV', owner: 'Jane Doe', status: 'Valid', insurance: 'Active' },
                    { plate: 'DEF456', model: 'Truck', owner: 'Bob Johnson', status: 'Expired', insurance: 'Expired' }
                ]);
            }, 500);
        });
    }

    populateVehiclesTable(vehicles) {
        const tbody = document.getElementById('vehicles-tbody');
        if (!tbody) return;

        tbody.innerHTML = vehicles.map(vehicle => `
            <tr>
                <td>${vehicle.plate}</td>
                <td>${vehicle.model}</td>
                <td>${vehicle.owner}</td>
                <td><span class="status-badge ${vehicle.status.toLowerCase()}">${vehicle.status}</span></td>
                <td><span class="status-badge ${vehicle.insurance.toLowerCase()}">${vehicle.insurance}</span></td>
                <td>
                    <button class="btn btn-sm btn-primary" onclick="mdtSystem.viewVehicle('${vehicle.plate}')">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn btn-sm btn-secondary" onclick="mdtSystem.editVehicle('${vehicle.plate}')">
                        <i class="fas fa-edit"></i>
                    </button>
                </td>
            </tr>
        `).join('');
    }

    async loadIncidentsData() {
        try {
            const incidents = await this.fetchData('incidents');
            this.populateIncidentsTable(incidents);
        } catch (error) {
            console.error('Failed to load incidents data:', error);
        }
    }

    async fetchIncidentsData() {
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve([
                    { id: 1, type: 'Traffic Violation', location: 'Main St', officer: 'John Doe', date: '2024-01-15', status: 'Open' },
                    { id: 2, type: 'Theft', location: 'Downtown', officer: 'Jane Smith', date: '2024-01-14', status: 'Closed' },
                    { id: 3, type: 'Assault', location: 'Park Ave', officer: 'Bob Wilson', date: '2024-01-13', status: 'Pending' }
                ]);
            }, 500);
        });
    }

    populateIncidentsTable(incidents) {
        const tbody = document.getElementById('incidents-tbody');
        if (!tbody) return;

        tbody.innerHTML = incidents.map(incident => `
            <tr>
                <td>${incident.id}</td>
                <td>${incident.type}</td>
                <td>${incident.location}</td>
                <td>${incident.officer}</td>
                <td>${incident.date}</td>
                <td><span class="status-badge ${incident.status.toLowerCase()}">${incident.status}</span></td>
                <td>
                    <button class="btn btn-sm btn-primary" onclick="mdtSystem.viewIncident(${incident.id})">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn btn-sm btn-secondary" onclick="mdtSystem.editIncident(${incident.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                </td>
            </tr>
        `).join('');
    }

    handleGlobalSearch(query) {
        if (query.length < 2) return;
        
        console.log('Global search:', query);
        // Implement global search functionality
    }

    handleKeyboardShortcuts(e) {
        if (e.key === 'Escape') {
            e.preventDefault();
            this.closeMDT();
            return;
        }
        
        if (e.ctrlKey || e.metaKey) {
            switch (e.key) {
                case 'k':
                    e.preventDefault();
                    document.getElementById('global-search')?.focus();
                    break;
                case 'n':
                    e.preventDefault();
                    this.showNewIncidentModal();
                    break;
            }
        }
    }

    showModal(title, content) {
        const modal = document.getElementById('modal-overlay');
        const modalTitle = document.getElementById('modal-title');
        const modalContent = document.getElementById('modal-content');
        
        if (modalTitle) modalTitle.textContent = title;
        if (modalContent) modalContent.innerHTML = content;
        
        modal?.classList.remove('hidden');
    }

    closeModal() {
        const modal = document.getElementById('modal-overlay');
        modal?.classList.add('hidden');
    }

    showNewIncidentModal() {
        const content = `
            <form id="new-incident-form">
                <div class="form-group">
                    <label for="incident-type">Incident Type</label>
                    <select id="incident-type" required>
                        <option value="">Select Type</option>
                        <option value="traffic">Traffic Violation</option>
                        <option value="theft">Theft</option>
                        <option value="assault">Assault</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="incident-location">Location</label>
                    <input type="text" id="incident-location" required>
                </div>
                <div class="form-group">
                    <label for="incident-description">Description</label>
                    <textarea id="incident-description" rows="4" required></textarea>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="mdtSystem.closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Create Incident</button>
                </div>
            </form>
        `;
        
        this.showModal('New Incident Report', content);
        
        // Add form submission handler
        document.getElementById('new-incident-form')?.addEventListener('submit', (e) => {
            e.preventDefault();
            this.createIncident();
        });
    }

    showAddCitizenModal() {
        const content = `
            <form id="add-citizen-form">
                <div class="form-group">
                    <label for="citizen-name">Full Name</label>
                    <input type="text" id="citizen-name" required>
                </div>
                <div class="form-group">
                    <label for="citizen-dob">Date of Birth</label>
                    <input type="date" id="citizen-dob" required>
                </div>
                <div class="form-group">
                    <label for="citizen-license">License Number</label>
                    <input type="text" id="citizen-license" required>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="mdtSystem.closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Citizen</button>
                </div>
            </form>
        `;
        
        this.showModal('Add New Citizen', content);
    }

    showAddVehicleModal() {
        const content = `
            <form id="add-vehicle-form">
                <div class="form-group">
                    <label for="vehicle-plate">License Plate</label>
                    <input type="text" id="vehicle-plate" required>
                </div>
                <div class="form-group">
                    <label for="vehicle-model">Vehicle Model</label>
                    <input type="text" id="vehicle-model" required>
                </div>
                <div class="form-group">
                    <label for="vehicle-owner">Owner</label>
                    <input type="text" id="vehicle-owner" required>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="mdtSystem.closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Vehicle</button>
                </div>
            </form>
        `;
        
        this.showModal('Add New Vehicle', content);
    }

    showNewIncidentReportModal() {
        const content = `
            <form id="new-incident-report-form">
                <div class="form-group">
                    <label for="report-type">Report Type</label>
                    <select id="report-type" required>
                        <option value="">Select Type</option>
                        <option value="arrest">Arrest Report</option>
                        <option value="incident">Incident Report</option>
                        <option value="traffic">Traffic Report</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="report-subject">Subject</label>
                    <input type="text" id="report-subject" required>
                </div>
                <div class="form-group">
                    <label for="report-details">Report Details</label>
                    <textarea id="report-details" rows="6" required></textarea>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="mdtSystem.closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Create Report</button>
                </div>
            </form>
        `;
        
        this.showModal('New Incident Report', content);
    }

    async createIncident() {
        // Implement incident creation
        this.closeModal();
        this.showNotification('Incident created successfully', 'success');
    }

    showNotifications() {
        // Implement notifications panel
        console.log('Show notifications');
    }

    showSettings() {
        const content = `
            <div class="settings-modal">
                <div class="settings-section">
                    <h3 class="settings-section-title">Text Color</h3>
                    <p style="color: var(--text-secondary); font-size: var(--font-size-sm); margin-bottom: var(--spacing-md);">
                        Choose the color for all text in the interface
                    </p>
                    
                    <div class="color-picker-container">
                        <div class="color-options">
                            <div class="color-option active" data-color="#FFFFFF" style="background: linear-gradient(135deg, #FFFFFF 0%, #E0E0E0 100%);" title="White">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="color-option" data-color="#E0E0E0" style="background: linear-gradient(135deg, #E0E0E0 0%, #BDBDBD 100%);" title="Light Gray">
                            </div>
                            <div class="color-option" data-color="#FFD700" style="background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);" title="Gold">
                            </div>
                            <div class="color-option" data-color="#87CEEB" style="background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);" title="Sky Blue">
                            </div>
                            <div class="color-option" data-color="#90EE90" style="background: linear-gradient(135deg, #90EE90 0%, #32CD32 100%);" title="Light Green">
                            </div>
                            <div class="color-option" data-color="#FFB6C1" style="background: linear-gradient(135deg, #FFB6C1 0%, #FF69B4 100%);" title="Pink">
                            </div>
                            <div class="color-option" data-color="#DDA0DD" style="background: linear-gradient(135deg, #DDA0DD 0%, #9370DB 100%);" title="Plum">
                            </div>
                            <div class="color-option" data-color="#F0E68C" style="background: linear-gradient(135deg, #F0E68C 0%, #BDB76B 100%);" title="Khaki">
                            </div>
                        </div>
                        
                        <div class="color-picker-input">
                            <label class="color-picker-label">Or choose a custom text color:</label>
                            <input type="color" id="custom-text-color-picker" value="${this.getTextColor() || '#FFFFFF'}" />
                            <input type="text" id="custom-text-color-hex" placeholder="#FFFFFF" value="${this.getTextColor() || '#FFFFFF'}" />
                        </div>
                        
                        <div class="color-preview">
                            <div class="color-preview-box" id="text-preview" style="background-color: ${this.getTextColor() || '#FFFFFF'};"></div>
                            <div class="color-preview-text" id="text-preview-text">${this.getTextColor() || '#FFFFFF'}</div>
                        </div>
                    </div>
                </div>
                
                <div class="settings-section">
                    <h3 class="settings-section-title">Background Theme</h3>
                    <p style="color: var(--text-secondary); font-size: var(--font-size-sm); margin-bottom: var(--spacing-md);">
                        Choose between Dark, Light${document.body.classList.contains('ambulance-theme') ? ', and Red theme' : ' theme'}
                    </p>
                    
                    <div class="color-picker-container">
                        <div class="color-options">
                            <div class="color-option ${this.getBackgroundColor() === 'dark' ? 'active' : ''}" data-bg-mode="dark" style="background: linear-gradient(135deg, #121212 0%, #2A2A2A 100%); border: ${this.getBackgroundColor() === 'dark' ? '3px solid #1976D2' : '3px solid transparent'};" title="Dark Mode">
                                <i class="${this.getBackgroundColor() === 'dark' ? 'fas fa-check' : ''}"></i>
                                <div style="position: absolute; bottom: -25px; left: 50%; transform: translateX(-50%); font-size: 10px; color: white; white-space: nowrap;">Dark</div>
                            </div>
                            <div class="color-option ${this.getBackgroundColor() === 'light' ? 'active' : ''}" data-bg-mode="light" style="background: linear-gradient(135deg, #FFFFFF 0%, #E0E0E0 100%); border: ${this.getBackgroundColor() === 'light' ? '3px solid #1976D2' : '3px solid #ccc'};" title="Light Mode">
                                <i class="${this.getBackgroundColor() === 'light' ? 'fas fa-check' : ''}"></i>
                                <div style="position: absolute; bottom: -25px; left: 50%; transform: translateX(-50%); font-size: 10px; color: black; white-space: nowrap;">Light</div>
                            </div>
                            ${document.body.classList.contains('ambulance-theme') ? `
                            <div class="color-option ${this.getBackgroundColor() === 'red' ? 'active' : ''}" data-bg-mode="red" style="background: linear-gradient(135deg, #1F0A0A 0%, #5A0000 100%); border: ${this.getBackgroundColor() === 'red' ? '3px solid #CC0000' : '3px solid transparent'};" title="Blood Red Mode (EMS)">
                                <i class="${this.getBackgroundColor() === 'red' ? 'fas fa-check' : ''}"></i>
                                <div style="position: absolute; bottom: -25px; left: 50%; transform: translateX(-50%); font-size: 10px; color: white; white-space: nowrap;">Blood Red</div>
                            </div>
                            ` : ''}
                        </div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="mdtSystem.closeModal()">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="mdtSystem.saveAllSettings()">Save Settings</button>
                    <button type="button" class="btn btn-secondary" onclick="mdtSystem.resetAllSettings()">Reset to Default</button>
                </div>
            </div>
        `;
        
        this.showModal('Settings', content);
        
        // Set up event listeners
        setTimeout(() => {
            this.setupTextColorPicker();
            this.setupBackgroundColorPicker();
        }, 100);
    }

    setupThemePicker() {
        // Get current theme color
        const currentColor = this.getThemeColor() || '#1976D2';
        
        // Set active color option
        document.querySelectorAll('.color-option').forEach(option => {
            option.classList.remove('active');
            if (option.dataset.color === currentColor) {
                option.classList.add('active');
            }
        });
        
        // Setup click handlers for color options
        document.querySelectorAll('.color-option').forEach(option => {
            option.addEventListener('click', () => {
                document.querySelectorAll('.color-option').forEach(opt => opt.classList.remove('active'));
                option.classList.add('active');
                
                const color = option.dataset.color;
                const customColorPicker = document.getElementById('custom-color-picker');
                const customColorHex = document.getElementById('custom-color-hex');
                const colorPreview = document.getElementById('color-preview');
                const colorPreviewText = document.getElementById('color-preview-text');
                
                if (customColorPicker) customColorPicker.value = color;
                if (customColorHex) customColorHex.value = color;
                if (colorPreview) colorPreview.style.backgroundColor = color;
                if (colorPreviewText) colorPreviewText.textContent = color;
            });
        });
        
        // Setup custom color picker
        const customColorPicker = document.getElementById('custom-color-picker');
        if (customColorPicker) {
            customColorPicker.addEventListener('input', (e) => {
                const color = e.target.value;
                const customColorHex = document.getElementById('custom-color-hex');
                const colorPreview = document.getElementById('color-preview');
                const colorPreviewText = document.getElementById('color-preview-text');
                
                if (customColorHex) customColorHex.value = color;
                if (colorPreview) colorPreview.style.backgroundColor = color;
                if (colorPreviewText) colorPreviewText.textContent = color;
                
                // Remove active class from preset options
                document.querySelectorAll('.color-option').forEach(opt => opt.classList.remove('active'));
            });
        }
        
        // Setup hex input
        const customColorHex = document.getElementById('custom-color-hex');
        if (customColorHex) {
            customColorHex.addEventListener('input', (e) => {
                const color = e.target.value;
                if (/^#[0-9A-F]{6}$/i.test(color)) {
                    const customColorPicker = document.getElementById('custom-color-picker');
                    const colorPreview = document.getElementById('color-preview');
                    const colorPreviewText = document.getElementById('color-preview-text');
                    
                    if (customColorPicker) customColorPicker.value = color;
                    if (colorPreview) colorPreview.style.backgroundColor = color;
                    if (colorPreviewText) colorPreviewText.textContent = color;
                    
                    // Check if it matches a preset
                    document.querySelectorAll('.color-option').forEach(opt => {
                        opt.classList.remove('active');
                        if (opt.dataset.color === color) {
                            opt.classList.add('active');
                        }
                    });
                }
            });
        }
    }

    saveThemeSettings() {
        const customColorHex = document.getElementById('custom-color-hex');
        const color = customColorHex?.value || this.getThemeColor() || '#1976D2';
        
        // Save to localStorage
        localStorage.setItem('mdt-theme-color', color);
        
        // Apply theme
        this.applyThemeColor(color);
        
        // Show confirmation
        this.showNotification('Theme color saved successfully', 'success');
        
        // Close modal
        this.closeModal();
    }

    resetThemeSettings() {
        // Remove from localStorage
        localStorage.removeItem('mdt-theme-color');
        
        // Apply default theme
        this.applyThemeColor('#1976D2');
        
        // Show confirmation
        this.showNotification('Theme color reset to default', 'info');
        
        // Close modal
        this.closeModal();
    }

    // New functions for text and background colors
    getTextColor() {
        return localStorage.getItem('mdt-text-color') || '#FFFFFF';
    }

    getBackgroundColor() {
        return localStorage.getItem('mdt-bg-mode') || 'dark';
    }

    setupTextColorPicker() {
        const currentColor = this.getTextColor() || '#FFFFFF';
        
        // Set initial active state for text color options only
        document.querySelectorAll('.color-option[data-color]').forEach(option => {
            if (option.dataset.color === currentColor) {
                option.classList.add('active');
                // Make sure check icon is there
                let icon = option.querySelector('i');
                if (!icon) {
                    icon = document.createElement('i');
                    icon.className = 'fas fa-check';
                    option.appendChild(icon);
                }
            } else {
                option.classList.remove('active');
            }
        });
        
        // Add click handlers for color option blocks (only text color options, not background mode)
        document.querySelectorAll('.color-option[data-color]').forEach(option => {
            option.addEventListener('click', (e) => {
                e.stopPropagation(); // Prevent event bubbling
                
                // Remove active class from all text color options
                document.querySelectorAll('.color-option[data-color]').forEach(opt => {
                    opt.classList.remove('active');
                    const icon = opt.querySelector('i');
                    if (icon) icon.className = '';
                });
                
                // Add active class to clicked option
                option.classList.add('active');
                let icon = option.querySelector('i');
                if (!icon) {
                    icon = document.createElement('i');
                    icon.className = 'fas fa-check';
                    option.appendChild(icon);
                } else {
                    icon.className = 'fas fa-check';
                }
                
                // Update color pickers with selected color
                const color = option.dataset.color;
                const textColorPicker = document.getElementById('custom-text-color-picker');
                const textColorHex = document.getElementById('custom-text-color-hex');
                const textPreview = document.getElementById('text-preview');
                const textPreviewText = document.getElementById('text-preview-text');
                
                if (textColorPicker) textColorPicker.value = color;
                if (textColorHex) textColorHex.value = color;
                if (textPreview) textPreview.style.backgroundColor = color;
                if (textPreviewText) textPreviewText.textContent = color;
            });
        });
        
        const textColorPicker = document.getElementById('custom-text-color-picker');
        const textColorHex = document.getElementById('custom-text-color-hex');
        
        if (textColorPicker) {
            textColorPicker.addEventListener('input', (e) => {
                const color = e.target.value;
                if (textColorHex) textColorHex.value = color;
                const textPreview = document.getElementById('text-preview');
                const textPreviewText = document.getElementById('text-preview-text');
                if (textPreview) textPreview.style.backgroundColor = color;
                if (textPreviewText) textPreviewText.textContent = color;
                
                // Remove active from preset text color options when using custom picker
                document.querySelectorAll('.color-option[data-color]').forEach(opt => {
                    opt.classList.remove('active');
                    const icon = opt.querySelector('i');
                    if (icon) icon.className = '';
                });
            });
        }
        
        if (textColorHex) {
            textColorHex.addEventListener('input', (e) => {
                const color = e.target.value;
                if (/^#[0-9A-F]{6}$/i.test(color)) {
                    const textColorPicker = document.getElementById('custom-text-color-picker');
                    const textPreview = document.getElementById('text-preview');
                    const textPreviewText = document.getElementById('text-preview-text');
                    if (textColorPicker) textColorPicker.value = color;
                    if (textPreview) textPreview.style.backgroundColor = color;
                    if (textPreviewText) textPreviewText.textContent = color;
                    
                    // Check if it matches a preset text color option and activate it
                    document.querySelectorAll('.color-option[data-color]').forEach(opt => {
                        opt.classList.remove('active');
                        const icon = opt.querySelector('i');
                        if (icon) icon.className = '';
                        if (opt.dataset.color === color) {
                            opt.classList.add('active');
                            let currentIcon = opt.querySelector('i');
                            if (!currentIcon) {
                                currentIcon = document.createElement('i');
                                currentIcon.className = 'fas fa-check';
                                opt.appendChild(currentIcon);
                            } else {
                                currentIcon.className = 'fas fa-check';
                            }
                        }
                    });
                }
            });
        }
    }

    setupBackgroundColorPicker() {
        const currentMode = this.getBackgroundColor() || 'dark';
        
        // Set up click handlers for dark/light mode buttons
        document.querySelectorAll('[data-bg-mode]').forEach(option => {
            option.addEventListener('click', () => {
                // Remove active class from all
                document.querySelectorAll('[data-bg-mode]').forEach(opt => {
                    opt.classList.remove('active');
                    opt.style.border = '3px solid transparent';
                    const icon = opt.querySelector('i');
                    if (icon) icon.className = '';
                });
                
                // Add active class to clicked
                option.classList.add('active');
                const mode = option.dataset.bgMode;
                
                // Update border
                option.style.border = mode === 'light' ? '3px solid #1976D2' : '3px solid #1976D2';
                
                // Update icon
                const icon = option.querySelector('i');
                if (icon) icon.className = 'fas fa-check';
                
                // Update the styling
                if (mode === 'dark') {
                    document.querySelectorAll('[data-bg-mode="light"]').forEach(opt => {
                        opt.style.border = '3px solid #ccc';
                    });
                } else {
                    document.querySelectorAll('[data-bg-mode="dark"]').forEach(opt => {
                        opt.style.border = '3px solid transparent';
                    });
                }
            });
        });
    }

    applyTextColor(color) {
        if (!color || typeof color !== 'string' || !color.startsWith('#')) {
            return; // Don't apply if color is invalid
        }
        
        // Use !important to override background mode text colors
        document.documentElement.style.setProperty('--text-primary', color, 'important');
        
        try {
            document.documentElement.style.setProperty('--text-secondary', this.shadeColor(color, 30), 'important');
            document.documentElement.style.setProperty('--text-tertiary', this.shadeColor(color, 50), 'important');
        } catch (e) {
            console.error('Error applying text color shades:', e);
        }
        
        // Don't change background mode when text color changes
        // The background mode should stay independent
    }

    applyBackgroundColor(mode) {
        // Check if ambulance theme is active
        const isAmbulance = document.body.classList.contains('ambulance-theme');
        
        if (mode === 'light') {
            // Light theme colors
            document.documentElement.style.setProperty('--bg-primary', '#F5F5F5', 'important');
            document.documentElement.style.setProperty('--bg-secondary', '#EEEEEE', 'important');
            document.documentElement.style.setProperty('--bg-tertiary', '#E0E0E0', 'important');
            document.documentElement.style.setProperty('--bg-surface', '#FFFFFF', 'important');
            document.documentElement.style.setProperty('--border-primary', '#BDBDBD', 'important');
            
            // Switch to light watermark for light backgrounds
            const watermark = document.querySelector('.dashboard-watermark');
            if (watermark) {
                if (isAmbulance) {
                    watermark.src = 'img/ems.png';
                } else {
                    watermark.src = 'img/LSPD-light.png';
                }
                watermark.style.opacity = '0.6';
            }
        } else if (mode === 'red' || (mode === 'dark' && isAmbulance)) {
            // Red theme for ambulance (or explicit red mode)
            if (isAmbulance || mode === 'red') {
                document.documentElement.style.setProperty('--bg-primary', '#1F0A0A', 'important');
                document.documentElement.style.setProperty('--bg-secondary', '#2F1414', 'important');
                document.documentElement.style.setProperty('--bg-tertiary', '#3F1F1F', 'important');
                document.documentElement.style.setProperty('--bg-surface', '#1F0A0A', 'important');
                document.documentElement.style.setProperty('--border-primary', '#CC0000', 'important');
            } else {
                // Default dark theme
                document.documentElement.style.setProperty('--bg-primary', '#121212', 'important');
                document.documentElement.style.setProperty('--bg-secondary', '#1E1E1E', 'important');
                document.documentElement.style.setProperty('--bg-tertiary', '#2A2A2A', 'important');
                document.documentElement.style.setProperty('--bg-surface', '#1E1E1E', 'important');
                document.documentElement.style.setProperty('--border-primary', '#333333', 'important');
            }
            
            // Switch to dark watermark for dark backgrounds
            const watermark = document.querySelector('.dashboard-watermark');
            if (watermark) {
                if (isAmbulance) {
                    watermark.src = 'img/ems.png';
                } else {
                    watermark.src = 'img/LSPD-dark.png';
                }
                watermark.style.opacity = '1.0';
            }
        } else {
            // Dark theme colors (default)
            document.documentElement.style.setProperty('--bg-primary', '#121212', 'important');
            document.documentElement.style.setProperty('--bg-secondary', '#1E1E1E', 'important');
            document.documentElement.style.setProperty('--bg-tertiary', '#2A2A2A', 'important');
            document.documentElement.style.setProperty('--bg-surface', '#1E1E1E', 'important');
            document.documentElement.style.setProperty('--border-primary', '#333333', 'important');
            
            // Switch to dark watermark for dark backgrounds
            const watermark = document.querySelector('.dashboard-watermark');
            if (watermark) {
                if (isAmbulance) {
                    watermark.src = 'img/ems.png';
                } else {
                    watermark.src = 'img/LSPD-dark.png';
                }
                watermark.style.opacity = '1.0';
            }
        }
        
        // After applying background, check if user has custom text color
        const savedTextColor = localStorage.getItem('mdt-text-color');
        if (savedTextColor && savedTextColor.startsWith('#') && savedTextColor !== '#FFFFFF') {
            // Re-apply the custom text color with !important to ensure it overrides
            try {
                this.applyTextColor(savedTextColor);
            } catch (e) {
                console.error('Error re-applying custom text color:', e);
            }
        }
    }

    saveAllSettings() {
        // Get background mode from active option FIRST (before applying anything)
        const activeBgOption = document.querySelector('[data-bg-mode].active');
        const bgMode = activeBgOption ? activeBgOption.dataset.bgMode : 'dark';
        
        // Save and apply background mode FIRST
        localStorage.setItem('mdt-bg-mode', bgMode);
        this.applyBackgroundColor(bgMode);
        
        // Save and apply text color LAST (so it overrides background mode defaults)
        const textHex = document.getElementById('custom-text-color-hex');
        if (textHex) {
            const textColor = textHex.value || this.getTextColor() || '#FFFFFF';
            localStorage.setItem('mdt-text-color', textColor);
            this.applyTextColor(textColor);
        }
        
        // Show confirmation
        this.showNotification('All settings saved successfully', 'success');
        
        // Close modal
        this.closeModal();
    }

    resetAllSettings() {
        // Remove all custom settings
        localStorage.removeItem('mdt-text-color');
        localStorage.removeItem('mdt-bg-mode');
        
        // Apply defaults
        document.documentElement.style.setProperty('--text-primary', '#FFFFFF');
        document.documentElement.style.setProperty('--text-secondary', '#B0B0B0');
        document.documentElement.style.setProperty('--text-tertiary', '#808080');
        
        // Check if ambulance theme and use red background
        const isAmbulance = document.body.classList.contains('ambulance-theme');
        this.applyBackgroundColor(isAmbulance ? 'red' : 'dark');
        
        // Show confirmation
        this.showNotification('All settings reset to default', 'info');
        
        // Close modal
        this.closeModal();
    }

    getThemeColor() {
        return localStorage.getItem('mdt-theme-color') || '#1976D2';
    }

    applyThemeColor(color) {
        // Calculate darker and lighter shades
        const darker = this.shadeColor(color, -20);
        const lighter = this.shadeColor(color, 20);
        
        // Apply CSS variables - this affects buttons, active states, icons, etc.
        document.documentElement.style.setProperty('--primary-color', color);
        document.documentElement.style.setProperty('--primary-dark', darker);
        document.documentElement.style.setProperty('--primary-light', lighter);
        
        // Also update accent color to match (this is what makes the icons and highlights colorful)
        document.documentElement.style.setProperty('--accent-color', color);
        
        // Update border focus color
        document.documentElement.style.setProperty('--border-focus', color);
        
        // Update charts if they exist
        if (this.charts.crime) {
            this.charts.crime.data.datasets[0].borderColor = color;
            this.charts.crime.data.datasets[0].backgroundColor = color + '1A'; // Add opacity
            this.charts.crime.update();
        }
        
        if (this.charts.response) {
            this.charts.response.data.datasets[0].backgroundColor = color;
            this.charts.response.data.datasets[0].borderColor = darker;
            this.charts.response.update();
        }
    }

    // Helper function to lighten/darken color
    shadeColor(color, percent) {
        const num = parseInt(color.replace("#",""), 16);
        const amt = Math.round(2.55 * percent);
        const R = (num >> 16) + amt;
        const G = (num >> 8 & 0x00FF) + amt;
        const B = (num & 0x0000FF) + amt;
        return "#" + (0x1000000 + (R < 255 ? R < 1 ? 0 : R : 255) * 0x10000 +
            (G < 255 ? G < 1 ? 0 : G : 255) * 0x100 +
            (B < 255 ? B < 1 ? 0 : B : 255)).toString(16).slice(1);
    }

    logout() {
        if (confirm('Are you sure you want to logout?')) {
            // Implement logout
            console.log('Logging out...');
        }
    }

    showNotification(message, type = 'info') {
        const container = document.getElementById('notifications-container');
        if (!container) return;

        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <i class="fas fa-${this.getNotificationIcon(type)}"></i>
                <span>${message}</span>
            </div>
            <button class="notification-close" onclick="this.parentElement.remove()">
                <i class="fas fa-times"></i>
            </button>
        `;

        container.appendChild(notification);

        // Auto remove after 5 seconds
        setTimeout(() => {
            if (notification.parentElement) {
                notification.remove();
            }
        }, 5000);
    }

    getNotificationIcon(type) {
        const icons = {
            success: 'check-circle',
            error: 'times-circle',
            warning: 'exclamation-triangle',
            info: 'info-circle'
        };
        return icons[type] || 'info-circle';
    }

    showError(message) {
        this.showNotification(message, 'error');
    }

    // Placeholder methods for future implementation
    viewCitizen(id) { console.log('View citizen:', id); }
    editCitizen(id) { console.log('Edit citizen:', id); }
    viewVehicle(plate) { console.log('View vehicle:', plate); }
    editVehicle(plate) { console.log('Edit vehicle:', plate); }
    viewIncident(id) { console.log('View incident:', id); }
    editIncident(id) { console.log('Edit incident:', id); }

    // Map functionality using Leaflet with single image
    initMap3D() {
        const viewer = document.getElementById('map-viewer');
        const loading = document.getElementById('map-loading');
        
        if (!viewer) {
            console.error('Map viewer not found');
            return;
        }
        
        if (typeof L === 'undefined') {
            console.error('Leaflet not loaded');
            setTimeout(() => this.initMap3D(), 100);
            return;
        }
        
        console.log('Initializing map with Leaflet...');
        
        try {
            // GTA 5 map transformation constants (from web dispatch)
            const center_x = 117.3;
            const center_y = 172.8;
            const scale_x = 0.02072;
            const scale_y = 0.0205;
            
            // Create custom CRS
            const CUSTOM_CRS = L.extend({}, L.CRS.Simple, {
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
                transformation: new L.Transformation(scale_x, center_x, -scale_y, center_y),
                infinite: true,
            });
            
            // Initialize map with proper zoom
            const map = L.map('map-viewer', {
                crs: CUSTOM_CRS,
                center: [0, 0],
                zoom: 3.4,
                zoomControl: false,
                scrollWheelZoom: false,
                preferCanvas: false,
                attributionControl: false,
                dragging: false,
                touchZoom: false,
                doubleClickZoom: false,
                boxZoom: false,
                keyboard: false,
                minZoom: 1,
                maxZoom: 5
            });
            
            // Don't set max bounds - allow full view of map
            
            // Load map image
            const img = new Image();
            const imagePaths = [
                'nui://olrp-mdtsystem/html/img/gtamap.png',
                'nui://olrp-mdtsystem/html/img/gtamap.webp',
                'nui://olrp-mdtsystem/img/gtamap.png',
                'nui://olrp-mdtsystem/img/gtamap.webp',
                'img/gtamap.png',
                'img/gtamap.webp',
                './img/gtamap.png',
                './img/gtamap.webp'
            ];
            
            let currentPathIndex = 0;
            let loadedImagePath = null;
            let imageDimensions = { width: 0, height: 0 };
            
            const tryLoadImage = (path) => {
                console.log('Trying to load map image from:', path);
                img.src = path;
            };
            
            img.onload = () => {
                console.log('Map image loaded successfully from:', img.src);
                console.log('Image dimensions:', img.naturalWidth, 'x', img.naturalHeight);
                loadedImagePath = img.src;
                
                // Get actual image dimensions
                imageDimensions.width = img.naturalWidth || img.width || 4096;
                imageDimensions.height = img.naturalHeight || img.height || 4096;
                
                console.log('Using image size:', imageDimensions.width, 'x', imageDimensions.height);
                console.log('Recommended image size: 2048x2048 or 4096x4096 pixels');
                
                // Calculate bounds to fill the entire container without white spaces
                // Use the actual image dimensions and center them properly
                const bounds = [[-imageDimensions.height/2, -imageDimensions.width/2], 
                               [imageDimensions.height/2, imageDimensions.width/2]];
                
                console.log('Setting bounds to:', bounds);
                console.log('Image dimensions:', imageDimensions.width, 'x', imageDimensions.height);
                
                // Add image overlay with no padding, ensuring it fills the entire map
                L.imageOverlay(loadedImagePath, bounds, {
                    className: 'leaflet-image-layer-crisp',
                    interactive: false,
                    opacity: 1.0
                }).addTo(map);
                
                // Use setTimeout to ensure map container is fully rendered
                setTimeout(() => {
                    // Set zoom to 3.4 and center the map
                    map.setView([0, 0], 3.4);
                    map.invalidateSize();
                    
                    // Force the map to fill the entire container with no white spaces
                    const mapContainer = map.getContainer();
                    if (mapContainer) {
                        mapContainer.style.width = '100%';
                        mapContainer.style.height = '100%';
                        mapContainer.style.margin = '0';
                        mapContainer.style.padding = '0';
                        mapContainer.style.border = 'none';
                        mapContainer.style.outline = 'none';
                    }
                    
                    // Ensure all Leaflet panes fill the container
                    const mapPane = map.getPane('mapPane');
                    if (mapPane) {
                        mapPane.style.width = '100%';
                        mapPane.style.height = '100%';
                        mapPane.style.margin = '0';
                        mapPane.style.padding = '0';
                    }
                    
                    // Force a second invalidateSize to ensure proper rendering
                    setTimeout(() => {
                        map.invalidateSize();
                    }, 50);
                    
                    if (loading) loading.classList.add('hidden');
                }, 100);
            };
            
            img.onerror = () => {
                console.error(`Failed to load image from: ${imagePaths[currentPathIndex]}`);
                currentPathIndex++;
                if (currentPathIndex < imagePaths.length) {
                    tryLoadImage(imagePaths[currentPathIndex]);
                } else {
                    console.error('All image paths failed');
                    if (loading) {
                        loading.innerHTML = '<div style="color: red; padding: 20px;">Failed to load map image. Check console for details.</div>';
                    }
                }
            };
            
            tryLoadImage(imagePaths[0]);
            
            // Reset button
            const resetBtn = document.getElementById('reset-map-btn');
            if (resetBtn) {
                resetBtn.addEventListener('click', () => {
                    if (loadedImagePath && imageDimensions.width > 0 && imageDimensions.height > 0) {
                        map.setView([0, 0], 3.4);
                        map.invalidateSize();
                        
                        // Ensure the map still fills the container after reset with no white spaces
                        const mapContainer = map.getContainer();
                        if (mapContainer) {
                            mapContainer.style.width = '100%';
                            mapContainer.style.height = '100%';
                            mapContainer.style.margin = '0';
                            mapContainer.style.padding = '0';
                            mapContainer.style.border = 'none';
                            mapContainer.style.outline = 'none';
                        }
                        
                        // Ensure all Leaflet panes fill the container
                        const mapPane = map.getPane('mapPane');
                        if (mapPane) {
                            mapPane.style.width = '100%';
                            mapPane.style.height = '100%';
                            mapPane.style.margin = '0';
                            mapPane.style.padding = '0';
                        }
                        
                        // Force a second invalidateSize to ensure proper rendering
                        setTimeout(() => {
                            map.invalidateSize();
                        }, 50);
                    }
                });
            }
            
        } catch (error) {
            console.error('Error initializing map:', error);
            if (loading) {
                loading.innerHTML = '<div style="color: red; padding: 20px;">Map initialization failed. Check console.</div>';
            }
        }
    }

    project3D(x, y, rotX, rotY) {
        // Simple 3D projection
        const cosX = Math.cos(rotX);
        const sinX = Math.sin(rotX);
        const cosY = Math.cos(rotY);
        const sinY = Math.sin(rotY);
        
        const rotatedY = y * cosX;
        const rotatedZ = -y * sinX;
        const rotatedX = x * cosY + rotatedZ * sinY;
        
        return {
            x: rotatedX,
            y: rotatedY,
            z: -x * sinY + rotatedZ * cosY
        };
    }

    async loadMapData() {
        try {
            const canvas = document.getElementById('map-canvas');
            const loading = document.getElementById('map-loading');
            const viewer = document.getElementById('map-3d-viewer');
            
            if (!canvas || !loading || !viewer) return;
            
            // Set canvas size immediately
            canvas.width = viewer.clientWidth;
            canvas.height = viewer.clientHeight;
            
            // Wait a bit for the image to load
            setTimeout(() => {
                if (loading) loading.classList.add('hidden');
            }, 800);
        } catch (error) {
            console.error('Failed to load map data:', error);
        }
    }
}

// Initialize MDT System when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    console.log('MDT: DOM loaded, initializing...');
    window.mdtSystem = new MDTSystem();
    
    // Add a test to see if MDT is being shown automatically
    setTimeout(() => {
        const mdtContainer = document.getElementById('mdt-container');
        if (mdtContainer.style.display !== 'none' || mdtContainer.style.visibility !== 'hidden' || mdtContainer.style.opacity !== '0') {
            console.log('MDT: WARNING - MDT is visible without being opened!');
            console.log('MDT: Current styles - display:', mdtContainer.style.display, 'visibility:', mdtContainer.style.visibility, 'opacity:', mdtContainer.style.opacity);
            mdtContainer.style.display = 'none';
            mdtContainer.style.visibility = 'hidden';
            mdtContainer.style.opacity = '0';
        } else {
            console.log('MDT: MDT is properly hidden');
        }
    }, 2000);
});

// Listen for messages from Lua client
window.addEventListener('message', (event) => {
    const data = event.data;
    console.log('MDT: Received message:', data);
    
    if (data.type === 'open') {
        console.log('MDT: Opening MDT via message');
        window.mdtSystem.showMDT();
        
        // Check if ambulance MDT
        if (data.mdtType === 'ambulance') {
            window.mdtSystem.enableAmbulanceTheme();
        } else {
            window.mdtSystem.enablePoliceTheme();
        }
        
        if (data.data && data.data.player) {
            window.mdtSystem.updateUserInfo(data.data.player);
        }
    } else if (data.type === 'close') {
        console.log('MDT: Closing MDT via message');
        window.mdtSystem.hideMDT();
    } else if (data.type === 'playerData') {
        window.mdtSystem.updateUserInfo(data.data);
    } else if (data.type === 'updateData') {
        // Handle data updates
        console.log('Updating data:', data.data);
    } else if (data.type === 'notification') {
        window.mdtSystem.showNotification(data.data.message, data.data.type);
    }
});
