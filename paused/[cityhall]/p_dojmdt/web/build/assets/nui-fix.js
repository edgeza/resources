// FiveM NUI Routing Fix
// This script handles common routing issues in FiveM NUI applications

(function() {
    'use strict';
    
    // Wait for DOM to be ready
    function ready(fn) {
        if (document.readyState !== 'loading') {
            fn();
        } else {
            document.addEventListener('DOMContentLoaded', fn);
        }
    }
    
    ready(function() {
        console.log('[DOJ MDT] NUI Fix loaded');
        
        // Fix base path issues
        function fixBasePath() {
            const currentPath = window.location.pathname;
            if (currentPath !== '/' && currentPath !== '/index.html') {
                console.log('[DOJ MDT] Fixing base path from', currentPath, 'to /');
                window.history.replaceState(null, null, '/');
            }
        }
        
        // Handle React Router errors
        function handleRouterErrors() {
            const originalError = console.error;
            console.error = function(...args) {
                const message = args.join(' ');
                if (message.includes('No routes matched location')) {
                    console.log('[DOJ MDT] Router error detected, redirecting to root');
                    setTimeout(() => {
                        window.history.replaceState(null, null, '/');
                        window.location.reload();
                    }, 100);
                    return;
                }
                originalError.apply(console, args);
            };
        }
        
        // Handle navigation events
        function handleNavigation() {
            window.addEventListener('popstate', function() {
                console.log('[DOJ MDT] Navigation event detected');
                setTimeout(fixBasePath, 50);
            });
        }
        
        // Initialize fixes
        fixBasePath();
        handleRouterErrors();
        handleNavigation();
        
        // Periodic check for routing issues
        setInterval(fixBasePath, 5000);
        
        console.log('[DOJ MDT] NUI Fix initialized');
    });
})(); 