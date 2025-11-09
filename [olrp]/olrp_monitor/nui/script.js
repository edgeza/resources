// Global State Management
let economyData = {
    players: [],
    totalAmount: 0,
    totalCrypto: 0,
    totalVehicles: 0,
    totalTruckingMoney: 0,
    totalSavingsAccounts: 0,
    totalSocietyAccounts: 0,
    filteredPlayers: [],
    currentPage: 1,
    playersPerPage: 20,
    currentFilter: 'all',
    currentSort: 'networth',
    sortDirection: 'desc'
};

let texts = {};
let webhookUrl = '';

// Helper Functions
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    }).format(amount);
}

function formatNumber(num) {
    return new Intl.NumberFormat('en-US').format(num);
}

function showNotification(message, type = 'info') {
    const notification = document.getElementById('notification');
    notification.textContent = message;
    notification.className = `notification show ${type}`;
    
    setTimeout(() => {
        notification.classList.remove('show');
    }, 3000);
}

// Navigation
function setupNavigation() {
    const navItems = document.querySelectorAll('.nav-item[data-page]');
    navItems.forEach(item => {
        item.addEventListener('click', function() {
            const page = this.getAttribute('data-page');
            switchPage(page);
            
            navItems.forEach(nav => nav.classList.remove('active'));
            this.classList.add('active');
        });
    });

    document.getElementById('close-ui').addEventListener('click', closeNUI);
}

function switchPage(pageId) {
    document.querySelectorAll('.page').forEach(page => {
        page.classList.remove('active');
    });
    
    const targetPage = document.getElementById(`${pageId}-page`);
    if (targetPage) {
        targetPage.classList.add('active');
        
        // Refresh data when switching pages
        if (pageId === 'dashboard') {
            updateDashboard();
        } else if (pageId === 'players') {
            renderPlayersTable();
        } else if (pageId === 'moneyflow') {
            // Initialize canvas if not already done
            if (!flowCanvas || !flowCtx) {
                setupMoneyFlow();
            }
            if (flowCanvas) {
                resizeCanvas();
            }
            // Clear search when switching to page
            const searchInput = document.getElementById('moneyflow-player-search');
            if (searchInput) {
                searchInput.value = '';
            }
            const searchResults = document.getElementById('player-search-results');
            if (searchResults) {
                searchResults.classList.remove('show');
            }
        } else if (pageId === 'statistics') {
            updateStatistics();
        }
    }
}

// Data Processing
function processPlayerData(players) {
    return players.map((player, index) => ({
        ...player,
        rank: index + 1,
        displayCash: formatCurrency(player.cash || 0),
        displayBank: formatCurrency(player.bank || 0),
        displayCrypto: formatCurrency(player.crypto || 0),
        displayNetworth: formatCurrency(player.networth || 0),
        displayVehicles: formatNumber(player.vehicleCount || 0),
        displayItems: formatNumber(player.itemCount || 0),
        displayTrucking: formatCurrency(player.truckingMoney || 0),
        displaySavings: formatCurrency(player.savingsAccount || 0),
        displaySocieties: formatCurrency(player.societyAccounts || 0)
    }));
}

function filterPlayers() {
    let filtered = [...economyData.players];
    
    // Apply filter
    if (economyData.currentFilter === 'suspicious') {
        filtered = filtered.filter(p => p.isSuspicious);
    } else if (economyData.currentFilter === 'top100') {
        filtered = filtered.slice(0, 100);
    }
    
    // Apply search
    const searchTerm = document.getElementById('search-player')?.value.toLowerCase() || '';
    if (searchTerm) {
        filtered = filtered.filter(p => 
            p.name.toLowerCase().includes(searchTerm) ||
            (p.citizenid && p.citizenid.toLowerCase().includes(searchTerm))
        );
    }
    
    // Apply sort
    filtered.sort((a, b) => {
        let aVal = a[economyData.currentSort] || 0;
        let bVal = b[economyData.currentSort] || 0;
        
        if (economyData.sortDirection === 'desc') {
            return bVal - aVal;
        } else {
            return aVal - bVal;
        }
    });
    
    economyData.filteredPlayers = filtered;
    return filtered;
}

// Dashboard Updates
function updateDashboard() {
    const totalPlayers = economyData.players.length;
    const suspiciousCount = economyData.players.filter(p => p.isSuspicious).length;
    const avgNetworth = totalPlayers > 0 
        ? economyData.players.reduce((sum, p) => sum + (p.networth || 0), 0) / totalPlayers 
        : 0;
    
    document.getElementById('total-economy').textContent = formatCurrency(economyData.totalAmount);
    document.getElementById('total-crypto').textContent = `₿ ${formatNumber(economyData.totalCrypto)}`;
    document.getElementById('total-vehicles').textContent = formatNumber(economyData.totalVehicles);
    document.getElementById('total-players').textContent = formatNumber(totalPlayers);
    document.getElementById('avg-networth').textContent = formatCurrency(avgNetworth);
    document.getElementById('suspicious-count').textContent = formatNumber(suspiciousCount);
    document.getElementById('total-trucking').textContent = formatCurrency(economyData.totalTruckingMoney || 0);
    document.getElementById('total-savings').textContent = formatCurrency(economyData.totalSavingsAccounts || 0);
    document.getElementById('total-societies').textContent = formatCurrency(economyData.totalSocietyAccounts || 0);
    
    updateTopPlayers();
    updateWealthDistribution();
}

function updateTopPlayers() {
    const topPlayers = economyData.players.slice(0, 10);
    const container = document.getElementById('top-players-list');
    
    if (topPlayers.length === 0) {
        container.innerHTML = '<div class="empty-list">No player data available</div>';
        return;
    }
    
    container.innerHTML = topPlayers.map((player, index) => {
        const medal = index === 0 ? '🥇' : index === 1 ? '🥈' : index === 2 ? '🥉' : `${index + 1}.`;
        return `
            <div class="top-player-item">
                <span class="top-player-rank">${medal}</span>
                <span class="top-player-name">${player.name}</span>
                <span class="top-player-value">${formatCurrency(player.networth)}</span>
            </div>
        `;
    }).join('');
}

function updateWealthDistribution() {
    const tiers = [
        { label: 'Top 1%', count: 0 },
        { label: 'Top 5%', count: 0 },
        { label: 'Top 10%', count: 0 },
        { label: 'Top 25%', count: 0 },
        { label: 'Bottom 75%', count: 0 }
    ];
    
    const total = economyData.players.length;
    if (total > 0) {
        tiers[0].count = Math.ceil(total * 0.01);
        tiers[1].count = Math.ceil(total * 0.05);
        tiers[2].count = Math.ceil(total * 0.10);
        tiers[3].count = Math.ceil(total * 0.25);
        tiers[4].count = total - tiers[3].count;
    }
    
    const container = document.getElementById('wealth-distribution');
    container.innerHTML = tiers.map(tier => `
        <div class="wealth-tier">
            <span class="wealth-tier-label">${tier.label}</span>
            <span class="wealth-tier-value">${tier.count} players</span>
        </div>
    `).join('');
}

// Players Table
function renderPlayersTable() {
    const filtered = filterPlayers();
    const startIndex = (economyData.currentPage - 1) * economyData.playersPerPage;
    const endIndex = Math.min(startIndex + economyData.playersPerPage, filtered.length);
    const pagePlayers = filtered.slice(startIndex, endIndex);
    
    const tbody = document.getElementById('players-table');
    
    if (pagePlayers.length === 0) {
        tbody.innerHTML = '<tr><td colspan="12" class="empty-table">No players found</td></tr>';
        return;
    }
    
    tbody.innerHTML = pagePlayers.map(player => {
        const statusClass = player.isSuspicious ? 'suspicious' : 'clean';
        const statusText = player.isSuspicious ? '⚠️ Suspicious' : '✓ Clean';
        
        return `
            <tr style="cursor: pointer;" onclick="showPlayerDetails('${player.citizenid}')">
                <td>${player.rank}</td>
                <td>${player.name}</td>
                <td>${player.displayCash}</td>
                <td>${player.displayBank}</td>
                <td>${player.displayCrypto}</td>
                <td>${player.displayVehicles}</td>
                <td>${player.displayItems}</td>
                <td style="color: ${player.truckingMoney > 0 ? 'var(--warning)' : 'var(--text-muted)'};">${player.displayTrucking}</td>
                <td style="color: ${player.savingsAccount > 0 ? 'var(--warning)' : 'var(--text-muted)'};">${player.displaySavings}</td>
                <td style="color: ${player.societyAccounts > 0 ? 'var(--warning)' : 'var(--text-muted)'};">${player.displaySocieties}</td>
                <td style="color: var(--primary); font-weight: bold;">${player.displayNetworth}</td>
                <td><span class="status-badge ${statusClass}">${statusText}</span></td>
            </tr>
        `;
    }).join('');
    
    // Update pagination
    const totalPages = Math.ceil(filtered.length / economyData.playersPerPage);
    document.getElementById('page-info').textContent = `Page ${economyData.currentPage} of ${totalPages}`;
    document.getElementById('prev-page').disabled = economyData.currentPage === 1;
    document.getElementById('next-page').disabled = economyData.currentPage >= totalPages;
    document.getElementById('table-info').textContent = `Showing ${startIndex + 1}-${endIndex} of ${filtered.length}`;
    document.getElementById('players-count').textContent = `Viewing ${filtered.length} players`;
}

function setupPlayersPage() {
    // Search
    const searchInput = document.getElementById('search-player');
    if (searchInput) {
        searchInput.addEventListener('input', () => {
            economyData.currentPage = 1;
            renderPlayersTable();
        });
    }
    
    // Sort
    const sortSelect = document.getElementById('sort-by');
    if (sortSelect) {
        sortSelect.addEventListener('change', (e) => {
            economyData.currentSort = e.target.value;
            economyData.currentPage = 1;
            renderPlayersTable();
        });
    }
    
    // Sortable headers
    document.querySelectorAll('th.sortable').forEach(th => {
        th.addEventListener('click', function() {
            const sortField = this.getAttribute('data-sort');
            if (economyData.currentSort === sortField) {
                economyData.sortDirection = economyData.sortDirection === 'desc' ? 'asc' : 'desc';
            } else {
                economyData.currentSort = sortField;
                economyData.sortDirection = 'desc';
            }
            renderPlayersTable();
        });
    });
    
    // Pagination
    document.getElementById('prev-page').addEventListener('click', () => {
        if (economyData.currentPage > 1) {
            economyData.currentPage--;
            renderPlayersTable();
        }
    });
    
    document.getElementById('next-page').addEventListener('click', () => {
        const totalPages = Math.ceil(economyData.filteredPlayers.length / economyData.playersPerPage);
        if (economyData.currentPage < totalPages) {
            economyData.currentPage++;
            renderPlayersTable();
        }
    });
    
    // Tabs
    document.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', function() {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            economyData.currentFilter = this.getAttribute('data-filter');
            economyData.currentPage = 1;
            renderPlayersTable();
        });
    });
}


// Statistics
function updateStatistics() {
    const players = economyData.players;
    const total = players.length;
    
    if (total === 0) return;
    
    // Cash stats
    const totalCash = players.reduce((sum, p) => sum + (p.cash || 0), 0);
    const avgCash = totalCash / total;
    const sortedCash = [...players].sort((a, b) => (a.cash || 0) - (b.cash || 0));
    const medianCash = sortedCash[Math.floor(total / 2)]?.cash || 0;
    
    document.getElementById('stats-total-cash').textContent = formatCurrency(totalCash);
    document.getElementById('stats-avg-cash').textContent = formatCurrency(avgCash);
    document.getElementById('stats-median-cash').textContent = formatCurrency(medianCash);
    
    // Bank stats
    const totalBank = players.reduce((sum, p) => sum + (p.bank || 0), 0);
    const avgBank = totalBank / total;
    const sortedBank = [...players].sort((a, b) => (a.bank || 0) - (b.bank || 0));
    const medianBank = sortedBank[Math.floor(total / 2)]?.bank || 0;
    
    document.getElementById('stats-total-bank').textContent = formatCurrency(totalBank);
    document.getElementById('stats-avg-bank').textContent = formatCurrency(avgBank);
    document.getElementById('stats-median-bank').textContent = formatCurrency(medianBank);
    
    // Vehicle stats
    const totalVehicles = players.reduce((sum, p) => sum + (p.vehicleCount || 0), 0);
    const avgVehicles = totalVehicles / total;
    const vehicleValue = players.reduce((sum, p) => sum + (p.vehicleValue || 0), 0);
    
    document.getElementById('stats-total-vehicles').textContent = formatNumber(totalVehicles);
    document.getElementById('stats-avg-vehicles').textContent = formatNumber(Math.round(avgVehicles));
    document.getElementById('stats-vehicle-value').textContent = formatCurrency(vehicleValue);
    
    // Networth stats
    const totalNetworth = players.reduce((sum, p) => sum + (p.networth || 0), 0);
    const avgNetworth = totalNetworth / total;
    const top1Count = Math.ceil(total * 0.01);
    const top1Networth = players.slice(0, top1Count).reduce((sum, p) => sum + (p.networth || 0), 0) / top1Count;
    
    document.getElementById('stats-total-networth').textContent = formatCurrency(totalNetworth);
    document.getElementById('stats-avg-networth').textContent = formatCurrency(avgNetworth);
    document.getElementById('stats-top1-networth').textContent = formatCurrency(top1Networth);
}

// Player Details Modal
function showPlayerDetails(citizenid) {
    const player = economyData.players.find(p => p.citizenid === citizenid);
    if (!player) return;
    
    document.getElementById('detail-name').textContent = player.name;
    document.getElementById('detail-citizenid').textContent = player.citizenid;
    document.getElementById('detail-cash').textContent = player.displayCash;
    document.getElementById('detail-bank').textContent = player.displayBank;
    document.getElementById('detail-crypto').textContent = player.displayCrypto;
    document.getElementById('detail-vehicles').textContent = player.displayVehicles;
    document.getElementById('detail-items').textContent = player.displayItems;
    document.getElementById('detail-trucking').textContent = player.displayTrucking;
    document.getElementById('detail-savings').textContent = player.displaySavings;
    document.getElementById('detail-societies').textContent = player.displaySocieties;
    document.getElementById('detail-networth').textContent = player.displayNetworth;
    
    // Show society breakdown if available
    const societyContainer = document.getElementById('society-list-container');
    const societyList = document.getElementById('society-list');
    if (player.societyList && player.societyList.length > 0) {
        societyContainer.style.display = 'block';
        societyList.innerHTML = player.societyList.map(soc => 
            `<div class="society-item" style="padding: 8px; margin-bottom: 5px; background: rgba(255,255,255,0.05); border-radius: 5px;">
                <strong>${soc.id}</strong>: ${formatCurrency(soc.amount)}
            </div>`
        ).join('');
    } else {
        societyContainer.style.display = 'none';
    }
    
    const flagsContainer = document.getElementById('abuse-flags-container');
    const flagsList = document.getElementById('abuse-flags-list');
    
    if (player.isSuspicious && player.abuseFlags && player.abuseFlags.length > 0) {
        flagsContainer.style.display = 'block';
        flagsList.innerHTML = player.abuseFlags.map(flag => 
            `<div class="abuse-flag-item">${flag}</div>`
        ).join('');
    } else {
        flagsContainer.style.display = 'none';
    }
    
    document.getElementById('player-details-modal').classList.add('show');
}

function setupModals() {
    document.querySelectorAll('.modal-close, .modal-close-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.modal').forEach(modal => {
                modal.classList.remove('show');
            });
        });
    });
    
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                this.classList.remove('show');
            }
        });
    });
}

// Event Listeners
function setupEventListeners() {
    // Refresh buttons
    document.getElementById('refresh-data-btn')?.addEventListener('click', () => {
        showNotification('Refreshing data...', 'info');
        // Trigger refresh from server
        fetch(`https://${GetParentResourceName()}/refresh`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        });
    });
    
    document.getElementById('refresh-players-btn')?.addEventListener('click', () => {
        renderPlayersTable();
    });
    
    document.getElementById('refresh-stats-btn')?.addEventListener('click', () => {
        updateStatistics();
    });
    
    // Export button
    document.getElementById('export-data-btn')?.addEventListener('click', () => {
        exportData();
    });
}

function exportData() {
    const data = {
        timestamp: new Date().toISOString(),
        totalAmount: economyData.totalAmount,
        totalCrypto: economyData.totalCrypto,
        totalVehicles: economyData.totalVehicles,
        players: economyData.players
    };
    
    const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `economy-data-${Date.now()}.json`;
    a.click();
    URL.revokeObjectURL(url);
    
    showNotification('Data exported successfully', 'success');
}

// NUI Communication
function closeNUI() {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    }).then(() => {
        document.body.classList.remove('show');
        document.getElementById('container').style.display = 'none';
    });
}

window.addEventListener('message', function(event) {
    if (event.data.type === 'show') {
        economyData.players = event.data.players || [];
        economyData.totalAmount = event.data.totalAmount || 0;
        economyData.totalCrypto = event.data.totalCrypto || 0;
        economyData.totalVehicles = event.data.totalVehicles || 0;
        economyData.totalTruckingMoney = event.data.totalTruckingMoney || 0;
        economyData.totalSavingsAccounts = event.data.totalSavingsAccounts || 0;
        economyData.totalSocietyAccounts = event.data.totalSocietyAccounts || 0;
        texts = event.data.texts || {};
        webhookUrl = event.data.webhookUrl || '';
        
        economyData.players = processPlayerData(economyData.players);
        economyData.currentPage = 1;
        
        document.body.classList.add('show');
        document.getElementById('container').style.display = 'flex';
        updateDashboard();
        renderPlayersTable();
        updateStatistics();
        updatePlayerDropdown();
        
    } else if (event.data.type === 'hide') {
        document.body.classList.remove('show');
        document.getElementById('container').style.display = 'none';
    } else if (event.data.type === 'moneyFlow') {
        renderMoneyFlow(event.data.citizenid, event.data.transactions);
    }
});

// Keyboard shortcuts
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeNUI();
    }
});

// Initialize
document.addEventListener('DOMContentLoaded', function() {
    setupNavigation();
    setupPlayersPage();
    setupModals();
    setupEventListeners();
    // Initialize money flow with delay to ensure DOM is ready
    setTimeout(() => {
        setupMoneyFlow();
    }, 200);
});

// Make showPlayerDetails available globally
window.showPlayerDetails = showPlayerDetails;

// Money Flow Visualization
let flowCanvas = null;
let flowCtx = null;
let flowData = null;
let flowPlayer = null;
let canvasOffset = { x: 0, y: 0 };
let isDragging = false;
let dragStart = { x: 0, y: 0 };

function setupMoneyFlow() {
    flowCanvas = document.getElementById('flow-canvas');
    if (!flowCanvas) {
        console.warn('Flow canvas not found');
        return;
    }
    
    flowCtx = flowCanvas.getContext('2d');
    if (!flowCtx) {
        console.error('Could not get canvas context');
        return;
    }
    
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);
    
    // Canvas drag functionality
    flowCanvas.addEventListener('mousedown', (e) => {
        isDragging = true;
        dragStart.x = e.clientX - canvasOffset.x;
        dragStart.y = e.clientY - canvasOffset.y;
    });
    
    flowCanvas.addEventListener('mousemove', (e) => {
        if (isDragging) {
            canvasOffset.x = e.clientX - dragStart.x;
            canvasOffset.y = e.clientY - dragStart.y;
            drawMoneyFlow();
        }
    });
    
    flowCanvas.addEventListener('mouseup', () => {
        isDragging = false;
    });
    
    flowCanvas.addEventListener('mouseleave', () => {
        isDragging = false;
    });
    
    // Player search input
    const playerSearch = document.getElementById('moneyflow-player-search');
    const searchResults = document.getElementById('player-search-results');
    let searchTimeout = null;
    
    if (playerSearch) {
        playerSearch.addEventListener('input', (e) => {
            const query = e.target.value.toLowerCase().trim();
            
            clearTimeout(searchTimeout);
            
            if (query.length < 2) {
                searchResults.classList.remove('show');
                searchResults.innerHTML = '';
                return;
            }
            
            searchTimeout = setTimeout(() => {
                filterAndShowPlayers(query);
            }, 200);
        });
        
        playerSearch.addEventListener('focus', () => {
            if (playerSearch.value.length >= 2) {
                filterAndShowPlayers(playerSearch.value.toLowerCase().trim());
            }
        });
        
        // Close results when clicking outside
        document.addEventListener('click', (e) => {
            if (!playerSearch.contains(e.target) && !searchResults.contains(e.target)) {
                searchResults.classList.remove('show');
            }
        });
    }
    
    function filterAndShowPlayers(query) {
        if (!economyData.players || economyData.players.length === 0) {
            searchResults.innerHTML = '<div class="player-search-item">No players loaded</div>';
            searchResults.classList.add('show');
            return;
        }
        
        const filtered = economyData.players.filter(player => 
            player.name.toLowerCase().includes(query) ||
            (player.citizenid && player.citizenid.toLowerCase().includes(query))
        ).slice(0, 10); // Limit to 10 results
        
        if (filtered.length === 0) {
            searchResults.innerHTML = '<div class="player-search-item">No players found</div>';
            searchResults.classList.add('show');
            return;
        }
        
        searchResults.innerHTML = filtered.map(player => `
            <div class="player-search-item" onclick="selectPlayerForFlow('${player.citizenid}')">
                <span class="player-search-item-name">${player.name}</span>
                <span class="player-search-item-networth">${player.displayNetworth}</span>
            </div>
        `).join('');
        
        searchResults.classList.add('show');
    }
    
    // Make function available globally
    window.selectPlayerForFlow = function(citizenid) {
        const player = economyData.players.find(p => p.citizenid === citizenid);
        if (player) {
            playerSearch.value = player.name;
            searchResults.classList.remove('show');
            loadMoneyFlow(citizenid);
        }
    };
    
    // Refresh button
    document.getElementById('refresh-flow-btn')?.addEventListener('click', () => {
        if (flowPlayer) {
            loadMoneyFlow(flowPlayer.citizenid);
        }
    });
}

function resizeCanvas() {
    if (!flowCanvas) return;
    const container = flowCanvas.parentElement;
    flowCanvas.width = container.clientWidth;
    flowCanvas.height = container.clientHeight;
    if (flowData) {
        drawMoneyFlow();
    }
}

function loadMoneyFlow(citizenid) {
    if (!citizenid) {
        console.error('No citizenid provided to loadMoneyFlow');
        return;
    }
    
    flowPlayer = economyData.players.find(p => p.citizenid === citizenid);
    if (!flowPlayer) {
        console.error('Player not found in economyData:', citizenid);
        showNotification('Player data not loaded. Please refresh the monitor first.', 'error');
        return;
    }
    
    // Show loading state
    const playerNameEl = document.getElementById('flow-player-name');
    if (playerNameEl) {
        playerNameEl.textContent = 'Loading transaction data...';
    }
    
    fetch(`https://${GetParentResourceName()}/getMoneyFlow`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ citizenid: citizenid })
    }).catch(err => {
        console.error('Error fetching money flow:', err);
        showNotification('Error loading money flow data', 'error');
    });
}

function renderMoneyFlow(citizenid, transactions) {
    if (!citizenid) {
        console.error('No citizenid provided to renderMoneyFlow');
        return;
    }
    
    flowPlayer = economyData.players.find(p => p.citizenid === citizenid);
    if (!flowPlayer) {
        console.error('Player not found for citizenid:', citizenid);
        showNotification('Player data not found. Please refresh the monitor.', 'error');
        return;
    }
    
    // Update player name
    const playerNameEl = document.getElementById('flow-player-name');
    if (playerNameEl) {
        playerNameEl.textContent = flowPlayer.name;
    }
    
    // Update stats grid
    const statsGrid = document.getElementById('flow-stats-grid');
    if (!statsGrid) {
        console.error('Stats grid element not found');
        return;
    }
    
    statsGrid.innerHTML = `
        <div class="flow-stat-item">
            <span class="flow-stat-label">Cash</span>
            <span class="flow-stat-value">${flowPlayer.displayCash}</span>
        </div>
        <div class="flow-stat-item">
            <span class="flow-stat-label">Bank</span>
            <span class="flow-stat-value">${flowPlayer.displayBank}</span>
        </div>
        <div class="flow-stat-item">
            <span class="flow-stat-label">Crypto</span>
            <span class="flow-stat-value">${flowPlayer.displayCrypto}</span>
        </div>
        <div class="flow-stat-item">
            <span class="flow-stat-label">Trucking</span>
            <span class="flow-stat-value">${flowPlayer.displayTrucking}</span>
        </div>
        <div class="flow-stat-item">
            <span class="flow-stat-label">Savings</span>
            <span class="flow-stat-value">${flowPlayer.displaySavings}</span>
        </div>
        <div class="flow-stat-item">
            <span class="flow-stat-label">Societies</span>
            <span class="flow-stat-value">${flowPlayer.displaySocieties}</span>
        </div>
        <div class="flow-stat-item">
            <span class="flow-stat-label">Networth</span>
            <span class="flow-stat-value">${flowPlayer.displayNetworth}</span>
        </div>
    `;
    
    // Build flow data structure (always show player and money sources, even without transactions)
    flowData = buildFlowData(flowPlayer, transactions || []);
    
    // Draw visualization
    if (!flowCanvas || !flowCtx) {
        console.warn('Canvas not initialized, attempting to setup...');
        setupMoneyFlow();
    }
    
    // Wait a moment for canvas to be ready, then draw
    setTimeout(() => {
        if (flowCanvas && flowCtx && flowData) {
            drawMoneyFlow();
        } else {
            console.error('Failed to initialize canvas for money flow visualization');
        }
    }, 100);
    
    // Render timeline
    renderTimeline(transactions || []);
}

function buildFlowData(player, transactions) {
    const nodes = [];
    const connections = [];
    
    // Central node - Player
    nodes.push({
        id: 'player',
        label: player.name,
        type: 'player',
        x: 0,
        y: 0,
        value: player.networth,
        color: '#dc2626'
    });
    
    // Money source nodes
    const sources = [
        { id: 'cash', label: 'Cash', value: player.cash, color: '#16a34a', icon: '💵' },
        { id: 'bank', label: 'Bank', value: player.bank, color: '#3b82f6', icon: '🏦' },
        { id: 'crypto', label: 'Crypto', value: player.crypto, color: '#f59e0b', icon: '₿' },
        { id: 'trucking', label: 'Trucking', value: player.truckingMoney, color: '#ef4444', icon: '🚚' },
        { id: 'savings', label: 'Savings', value: player.savingsAccount, color: '#8b5cf6', icon: '💰' },
        { id: 'societies', label: 'Societies', value: player.societyAccounts, color: '#ec4899', icon: '🏢' }
    ];
    
    const angleStep = (2 * Math.PI) / sources.length;
    const radius = 200;
    
    sources.forEach((source, index) => {
        if (source.value > 0) {
            const angle = index * angleStep;
            const x = Math.cos(angle) * radius;
            const y = Math.sin(angle) * radius;
            
            nodes.push({
                id: source.id,
                label: source.label,
                type: 'source',
                x: x,
                y: y,
                value: source.value,
                color: source.color,
                icon: source.icon
            });
            
            connections.push({
                from: source.id,
                to: 'player',
                value: source.value,
                color: source.color
            });
        }
    });
    
    // Add transaction destinations
    if (transactions && Array.isArray(transactions) && transactions.length > 0) {
        const transactionNodes = {};
        transactions.forEach((trans) => {
            if (!trans) return;
            const destId = trans.society || trans.receiver || trans.id || 'unknown';
            if (!transactionNodes[destId]) {
                transactionNodes[destId] = {
                    id: destId,
                    label: destId,
                    type: 'destination',
                    transactions: [],
                    total: 0
                };
            }
            transactionNodes[destId].transactions.push(trans);
            transactionNodes[destId].total += (Number(trans.amount) || 0);
        });
        
        const destKeys = Object.keys(transactionNodes);
        if (destKeys.length > 0) {
            const destAngleStep = (2 * Math.PI) / destKeys.length;
            let destIndex = 0;
            Object.values(transactionNodes).forEach((dest) => {
                if (dest.total > 0) {
                    const angle = destIndex * destAngleStep + Math.PI;
                    const x = Math.cos(angle) * radius;
                    const y = Math.sin(angle) * radius;
                    
                    nodes.push({
                        id: dest.id,
                        label: dest.label,
                        type: 'destination',
                        x: x,
                        y: y,
                        value: dest.total,
                        color: '#d97706',
                        icon: '➡️'
                    });
                    
                    connections.push({
                        from: 'player',
                        to: dest.id,
                        value: dest.total,
                        color: '#d97706'
                    });
                    
                    destIndex++;
                }
            });
        }
    }
    
    return { nodes, connections };
}

function drawMoneyFlow() {
    if (!flowCtx || !flowData || !flowCanvas) {
        console.warn('Cannot draw money flow: missing context, data, or canvas');
        return;
    }
    
    const width = flowCanvas.width;
    const height = flowCanvas.height;
    
    if (width === 0 || height === 0) {
        console.warn('Canvas has zero dimensions');
        return;
    }
    
    const centerX = width / 2 + canvasOffset.x;
    const centerY = height / 2 + canvasOffset.y;
    
    // Clear canvas
    flowCtx.clearRect(0, 0, width, height);
    
    // Draw connections
    flowData.connections.forEach(conn => {
        const fromNode = flowData.nodes.find(n => n.id === conn.from);
        const toNode = flowData.nodes.find(n => n.id === conn.to);
        
        if (fromNode && toNode) {
            const fromX = centerX + fromNode.x;
            const fromY = centerY + fromNode.y;
            const toX = centerX + toNode.x;
            const toY = centerY + toNode.y;
            
            // Draw line
            flowCtx.strokeStyle = conn.color;
            flowCtx.lineWidth = Math.max(2, Math.min(10, conn.value / 100000));
            flowCtx.beginPath();
            flowCtx.moveTo(fromX, fromY);
            flowCtx.lineTo(toX, toY);
            flowCtx.stroke();
            
            // Draw arrow
            const angle = Math.atan2(toY - fromY, toX - fromX);
            const arrowLength = 10;
            const arrowAngle = Math.PI / 6;
            
            flowCtx.beginPath();
            flowCtx.moveTo(toX, toY);
            flowCtx.lineTo(
                toX - arrowLength * Math.cos(angle - arrowAngle),
                toY - arrowLength * Math.sin(angle - arrowAngle)
            );
            flowCtx.moveTo(toX, toY);
            flowCtx.lineTo(
                toX - arrowLength * Math.cos(angle + arrowAngle),
                toY - arrowLength * Math.sin(angle + arrowAngle)
            );
            flowCtx.stroke();
        }
    });
    
    // Draw nodes
    flowData.nodes.forEach(node => {
        const x = centerX + node.x;
        const y = centerY + node.y;
        const radius = Math.max(30, Math.min(60, Math.sqrt(node.value) / 100));
        
        // Draw circle
        flowCtx.fillStyle = node.color;
        flowCtx.beginPath();
        flowCtx.arc(x, y, radius, 0, 2 * Math.PI);
        flowCtx.fill();
        
        // Draw border
        flowCtx.strokeStyle = '#ffffff';
        flowCtx.lineWidth = 2;
        flowCtx.stroke();
        
        // Draw label
        flowCtx.fillStyle = '#ffffff';
        flowCtx.font = 'bold 12px Arial';
        flowCtx.textAlign = 'center';
        flowCtx.textBaseline = 'middle';
        flowCtx.fillText(node.icon || node.label.substring(0, 3), x, y - 5);
        
        // Draw value
        flowCtx.font = '10px Arial';
        flowCtx.fillText(formatCurrency(node.value), x, y + radius + 15);
    });
    
    // Update legend
    updateFlowLegend();
}

function updateFlowLegend() {
    if (!flowData) return;
    
    const legend = document.getElementById('flow-legend');
    if (!legend) return;
    
    const types = {};
    flowData.nodes.forEach(node => {
        if (!types[node.type]) {
            types[node.type] = {
                color: node.color,
                label: node.type === 'player' ? 'Player' : node.type === 'source' ? 'Money Source' : 'Destination',
                count: 0
            };
        }
        types[node.type].count++;
    });
    
    legend.innerHTML = Object.values(types).map(type => `
        <div class="flow-legend-item">
            <div class="flow-legend-color" style="background: ${type.color};"></div>
            <span>${type.label} (${type.count})</span>
        </div>
    `).join('');
}

function renderTimeline(transactions) {
    const container = document.getElementById('timeline-container');
    if (!container) {
        console.warn('Timeline container not found');
        return;
    }
    
    if (!transactions || !Array.isArray(transactions) || transactions.length === 0) {
        container.innerHTML = '<div class="empty-list">No transactions to display</div>';
        return;
    }
    
    container.innerHTML = transactions.map(trans => {
        if (!trans) return '';
        
        const type = trans.trans_type || trans.type || 'unknown';
        const amount = Number(trans.amount) || 0;
        const timestamp = trans.time || trans.timestamp || 0;
        const date = timestamp > 0 ? new Date(timestamp * 1000) : new Date();
        const dateStr = date.toLocaleDateString() + ' ' + date.toLocaleTimeString();
        
        const icon = type === 'deposit' ? '⬇️' : type === 'withdraw' ? '⬆️' : '↔️';
        const typeClass = type === 'deposit' ? 'deposit' : type === 'withdraw' ? 'withdraw' : 'transfer';
        const title = trans.title || type.toUpperCase();
        const destination = trans.society || trans.receiver || 'N/A';
        
        return `
            <div class="timeline-item ${typeClass}">
                <div class="timeline-icon">${icon}</div>
                <div class="timeline-content">
                    <div class="timeline-title">${title}</div>
                    <div class="timeline-details">${destination}</div>
                    <div class="timeline-date">${dateStr}</div>
                </div>
                <div class="timeline-amount">${formatCurrency(amount)}</div>
            </div>
        `;
    }).filter(html => html !== '').join('');
}

function updatePlayerDropdown() {
    // No longer needed - using search instead
    // This function kept for compatibility but does nothing
}

// Initialize money flow on page load (merged with main initialization)

