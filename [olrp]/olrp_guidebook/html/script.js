// OLRP Guidebook - Modern JavaScript with Enhanced Features
class OLRPGuidebook {
    constructor() {
        this.isInitialized = false;
        this.currentCategory = null;
        this.searchTimeout = null;
        this.animationFrame = null;
        this.settings = {
            searchBar: true,
            fontSize: 16,
            font: 'Inter'
        };
        
        this.init();
    }

    init() {
        if (this.isInitialized) return;
        
        this.loadSettings();
        this.setupEventListeners();
        this.loadCategories();
        this.setupInitialState();
        this.setupTextContent();
        this.hideUI();
        
        this.isInitialized = true;
    }

    loadSettings() {
        const savedSettings = localStorage.getItem('olrpGuidebookSettings');
        if (savedSettings) {
            this.settings = { ...this.settings, ...JSON.parse(savedSettings) };
        }
    }

    saveSettings() {
        localStorage.setItem('olrpGuidebookSettings', JSON.stringify(this.settings));
    }

    setupEventListeners() {
        // Close button
        document.getElementById('close-btn').addEventListener('click', () => this.closeUI());
        
        // Search input with debouncing
        const searchInput = document.getElementById('search-input');
        searchInput.addEventListener('input', (e) => this.handleSearch(e.target.value));
        
        // Keyboard shortcuts
        document.addEventListener('keydown', (e) => this.handleKeydown(e));
        
        // Window messages
        window.addEventListener('message', (e) => this.handleMessage(e));
        
        // Settings modal
        document.getElementById('search-toggle').addEventListener('change', (e) => this.toggleSearchBar(e.target.checked));
        document.getElementById('font-selector').addEventListener('change', (e) => this.changeFont(e.target.value));
        
        // Text size controls
        document.addEventListener('click', (e) => {
            if (e.target.matches('[data-action="increase-text"]')) {
                this.changeTextSize('increase');
            } else if (e.target.matches('[data-action="decrease-text"]')) {
                this.changeTextSize('decrease');
            }
        });
    }

    handleKeydown(e) {
        if (e.key === 'Escape') {
            this.closeUI();
        } else if (e.ctrlKey && e.key === 'f') {
            e.preventDefault();
            document.getElementById('search-input').focus();
        } else if (e.ctrlKey && e.key === 'k') {
            e.preventDefault();
            this.openSettings();
        }
    }

    handleMessage(event) {
        const { action } = event.data;
        if (action === 'SHOW_UI') {
            this.showUI();
        }
    }

    handleSearch(query) {
        clearTimeout(this.searchTimeout);
        this.searchTimeout = setTimeout(() => {
            // Use requestAnimationFrame for smooth filtering
            requestAnimationFrame(() => {
                this.filterCategories(query);
            });
        }, 150);
    }

    closeUI() {
        $.post(`https://${GetParentResourceName()}/CLOSE_UI`);
        const container = document.querySelector('.container');
        container.classList.add('closing');
        
        this.animateOut(() => {
            document.querySelector('body').style.display = 'none';
            container.classList.remove('closing');
        });
    }

    showUI() {
        const body = document.querySelector('body');
        body.style.display = 'flex';
        
        const container = document.querySelector('.container');
        container.style.display = 'flex';
        container.classList.add('opening');
        
        this.animateIn(() => {
            container.classList.remove('opening');
        });
    }

    animateIn(callback) {
        if (this.animationFrame) {
            cancelAnimationFrame(this.animationFrame);
        }
        
        this.animationFrame = requestAnimationFrame(() => {
            if (callback) callback();
        });
    }

    animateOut(callback) {
        if (this.animationFrame) {
            cancelAnimationFrame(this.animationFrame);
        }
        
        this.animationFrame = requestAnimationFrame(() => {
            setTimeout(callback, 500);
        });
    }

    loadCategories() {
        const sidebarContent = document.querySelector('.sidebar-content');
        sidebarContent.innerHTML = '';
        
        Object.entries(guidebookConfig.categories).forEach(([key, category]) => {
            if (category.subcategories) {
                sidebarContent.appendChild(this.createCategoryElement(key, category));
            } else {
                sidebarContent.appendChild(this.createButtonElement(key, category.title, category.icon, () => {
                    this.loadContent(key);
                    this.setActiveCategory(key);
                }));
            }
        });
    }

    createCategoryElement(key, category) {
        const categoryDiv = document.createElement('div');
        categoryDiv.classList.add('category');
        categoryDiv.setAttribute('data-category', key);

        const categoryTitle = this.createButtonElement(
            key, 
            category.title, 
            category.icon, 
            () => {
                this.toggleSubcategories(key);
                this.setActiveCategory(key);
            }, 
            '<span class="icon"><i class="fas fa-chevron-right"></i></span>'
        );
        categoryDiv.appendChild(categoryTitle);

        const subcategoryContainer = document.createElement('div');
        subcategoryContainer.classList.add('subcategory-container');
        
        if (category.initiallyExpanded) {
            subcategoryContainer.classList.add('open');
            const icon = categoryTitle.querySelector('.icon i');
            if (icon) {
                icon.classList.replace('fa-chevron-right', 'fa-chevron-down');
            }
        }

        Object.entries(category.subcategories).forEach(([subkey, subcategory]) => {
            const subcategoryButton = this.createButtonElement(
                subkey, 
                subcategory.title, 
                subcategory.icon, 
                () => {
                    this.loadContent(key, subkey);
                    this.setActiveCategory(subkey);
                }
            );
            subcategoryButton.classList.add('subcategory-button');
            subcategoryContainer.appendChild(subcategoryButton);
        });

        categoryDiv.appendChild(subcategoryContainer);
        return categoryDiv;
    }

    createButtonElement(key, title, iconClass, onClick, additionalHTML = '') {
        const button = document.createElement('button');
        button.innerHTML = `${iconClass !== false ? `<i class="${iconClass} category-icon"></i>` : ''}<span>${title}</span>${additionalHTML}`;
        button.classList.add('category-title');
        
        if (iconClass === false) {
            button.classList.add('no-icon');
        }
        
        button.setAttribute('data-category', key);
        button.addEventListener('click', onClick);
        
        // Add smooth hover effects
        button.addEventListener('mouseenter', () => {
            button.style.transform = 'translateX(4px)';
        });
        
        button.addEventListener('mouseleave', () => {
            if (!button.classList.contains('active')) {
                button.style.transform = 'translateX(0)';
            }
        });
        
        return button;
    }

    filterCategories(query) {
        const filter = query.toLowerCase();
        
        if (filter === '') {
            this.resetCategories();
        } else {
            this.expandAllCategories();
            this.filterButtons(filter);
            this.hideEmptyCategories();
            this.collapseEmptyCategories();
        }
    }

    resetCategories() {
        document.querySelectorAll('.subcategory-container').forEach(container => {
            container.classList.remove('open');
            container.style.maxHeight = null;
            const icon = container.previousElementSibling.querySelector('.icon i');
            if (icon) {
                icon.classList.replace('fa-chevron-down', 'fa-chevron-right');
                icon.style.transform = 'rotate(0deg)';
            }
        });
        
        document.querySelectorAll('.sidebar button').forEach(button => {
            button.style.display = '';
            const parentCategory = button.closest('.category');
            if (parentCategory) {
                parentCategory.style.display = '';
            }
        });
    }

    expandAllCategories() {
        document.querySelectorAll('.subcategory-container').forEach(container => {
            container.classList.add('open');
            container.style.maxHeight = container.scrollHeight + "px";
            const icon = container.previousElementSibling.querySelector('.icon i');
            if (icon) {
                icon.classList.replace('fa-chevron-right', 'fa-chevron-down');
                icon.style.transform = 'rotate(360deg)';
            }
        });
    }

    filterButtons(filter) {
        document.querySelectorAll('.sidebar button').forEach(button => {
            const parentCategory = button.closest('.category');
            if (button.textContent.toLowerCase().includes(filter)) {
                button.style.display = '';
                if (parentCategory) {
                    parentCategory.style.display = '';
                }
            } else {
                button.style.display = 'none';
            }
        });
    }

    hideEmptyCategories() {
        document.querySelectorAll('.category').forEach(category => {
            const hasVisibleSubcategories = Array.from(category.querySelectorAll('.subcategory-container button')).some(button => button.style.display !== 'none');
            const categoryButton = category.querySelector('.category-title');
            if (!hasVisibleSubcategories && categoryButton.style.display === 'none') {
                category.style.display = 'none';
            }
        });
    }

    collapseEmptyCategories() {
        document.querySelectorAll('.subcategory-container').forEach(container => {
            const hasVisibleSubcategories = Array.from(container.querySelectorAll('button')).some(button => button.style.display !== 'none');
            if (!hasVisibleSubcategories) {
                container.classList.remove('open');
                container.style.maxHeight = null;
                const icon = container.previousElementSibling.querySelector('.icon i');
                if (icon) {
                    icon.classList.replace('fa-chevron-down', 'fa-chevron-right');
                    icon.style.transform = 'rotate(0deg)';
                }
            }
        });
    }

    loadContent(category, subcategory = null) {
        const contentData = subcategory ? 
            guidebookConfig.categories[category].subcategories[subcategory] : 
            guidebookConfig.categories[category];

        if (contentData) {
            const content = `<h1>${contentData.title}</h1>${contentData.content}`;
            const contentArea = document.getElementById('content-area');
            const defaultTitle = document.getElementById('default-title');
            
            contentArea.classList.remove('visible');

            setTimeout(() => {
                contentArea.innerHTML = content;
                this.setupContentInteractions();
                
                if (defaultTitle) defaultTitle.style.display = 'none';

                requestAnimationFrame(() => {
                    contentArea.classList.add('visible');
                });
            }, 200);
        }
    }

    setupContentInteractions() {
        // Setup image zoom functionality with performance optimization
        const images = document.querySelectorAll('.content img');
        images.forEach(img => {
            img.style.cursor = 'zoom-in';
            
            // Use passive event listeners for better performance
            img.addEventListener('click', () => this.openFullScreenImg(img.src), { passive: true });
            
            // Add loading animation with requestAnimationFrame
            img.addEventListener('load', () => {
                requestAnimationFrame(() => {
                    img.style.opacity = '1';
                });
            });
            
            img.style.opacity = '0';
            img.style.transition = 'opacity 0.3s ease';
        });

        // Setup external links with performance optimization
        const externalLinks = document.querySelectorAll('.content a[href^="javascript:openExternalLink"]');
        externalLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const url = link.getAttribute('href').replace('javascript:openExternalLink(\'', '').replace('\')', '');
                this.openExternalLink(url);
            }, { passive: false });
        });
    }

    toggleSubcategories(category) {
        const subcategoryContainer = document.querySelector(`.category[data-category="${category}"] .subcategory-container`);
        const icon = document.querySelector(`.category[data-category="${category}"] .category-title .icon i`);
        
        if (subcategoryContainer) {
            // Close other open categories
            document.querySelectorAll('.subcategory-container.open').forEach(container => {
                if (container !== subcategoryContainer) {
                    container.classList.remove('open');
                    container.style.maxHeight = null;
                    const otherIcon = container.previousElementSibling.querySelector('.icon i');
                    if (otherIcon) {
                        otherIcon.classList.replace('fa-chevron-down', 'fa-chevron-right');
                        otherIcon.style.transform = 'rotate(0deg)';
                    }
                }
            });
            
            const isOpen = subcategoryContainer.classList.toggle('open');
            subcategoryContainer.style.maxHeight = isOpen ? subcategoryContainer.scrollHeight + "px" : null;
            
            if (icon) {
                icon.classList.replace(isOpen ? 'fa-chevron-right' : 'fa-chevron-down', isOpen ? 'fa-chevron-down' : 'fa-chevron-right');
                icon.style.transform = isOpen ? 'rotate(360deg)' : 'rotate(0deg)';
            }
        }
    }

    setActiveCategory(category) {
        document.querySelectorAll('.category-title').forEach(button => {
            button.classList.remove('active');
            button.style.transform = 'translateX(0)';
        });
        
        const activeButton = document.querySelector(`.category-title[data-category="${category}"]`);
        if (activeButton) {
            activeButton.classList.add('active');
            activeButton.style.transform = 'translateX(4px)';
        }
        
        this.currentCategory = category;
    }

    openFullScreenImg(src) {
        const fullScreenImg = document.getElementById('fullScreenImg');
        const img = fullScreenImg.querySelector('img');
        img.src = src;
        fullScreenImg.style.display = 'flex';
        
        // Add smooth fade in
        requestAnimationFrame(() => {
            fullScreenImg.style.opacity = '1';
        });
    }

    closeFullScreenImg() {
        const fullScreenImg = document.getElementById('fullScreenImg');
        fullScreenImg.style.opacity = '0';
        
        setTimeout(() => {
            fullScreenImg.style.display = 'none';
        }, 300);
    }

    openSettings() {
        const modal = document.getElementById('settings-modal');
        modal.style.display = 'block';
        
        // Add smooth animation
        requestAnimationFrame(() => {
            modal.style.opacity = '1';
        });
    }

    closeSettings() {
        const modal = document.getElementById('settings-modal');
        modal.style.opacity = '0';
        
        setTimeout(() => {
            modal.style.display = 'none';
        }, 300);
    }

    changeFont(font) {
        document.body.style.fontFamily = font;
        this.settings.font = font;
        this.saveSettings();
    }

    changeTextSize(action) {
        const contentArea = document.getElementById('content-area');
        const allTextElements = contentArea.querySelectorAll('h1, h2, h3, p, ul, ol, li, strong, em');
        
        allTextElements.forEach(element => {
            const currentSize = parseInt(window.getComputedStyle(element).fontSize);
            const newSize = currentSize + (action === 'increase' ? 2 : -2);
            element.style.fontSize = `${Math.max(10, Math.min(24, newSize))}px`;
        });
        
        this.settings.fontSize = parseInt(window.getComputedStyle(contentArea.querySelector('p')).fontSize);
        this.saveSettings();
    }

    toggleSearchBar(visible) {
        const searchBar = document.querySelector('.search-bar');
        searchBar.style.display = visible ? 'block' : 'none';
        this.settings.searchBar = visible;
        this.saveSettings();
    }

    openExternalLinkModal(url) {
        const modal = document.getElementById('externalLinkModal');
        const iframe = document.getElementById('externalLinkIframe');
        iframe.src = url;
        modal.style.display = 'block';
        
        requestAnimationFrame(() => {
            modal.style.opacity = '1';
        });
    }

    closeExternalLinkModal() {
        const modal = document.getElementById('externalLinkModal');
        modal.style.opacity = '0';
        
        setTimeout(() => {
            modal.style.display = 'none';
            const iframe = document.getElementById('externalLinkIframe');
            iframe.src = '';
        }, 300);
    }

    openExternalLink(url) {
        this.openExternalLinkModal(url);
    }

    setupInitialState() {
        // Set search bar visibility
        const searchBar = document.querySelector('.search-bar');
        searchBar.style.display = this.settings.searchBar ? 'block' : 'none';
        document.getElementById('search-toggle').checked = this.settings.searchBar;
        
        // Set font
        this.changeFont(this.settings.font);
        document.getElementById('font-selector').value = this.settings.font;
        
        // Load default category
        this.loadDefaultCategory();
    }

    loadDefaultCategory() {
        const defaultCategory = guidebookConfig.defaultCategory;
        if (defaultCategory) {
            const [mainCategory, subCategory] = defaultCategory.split('.');
            if (subCategory && guidebookConfig.categories[mainCategory].subcategories[subCategory]) {
                this.loadContent(mainCategory, subCategory);
                this.setActiveCategory(subCategory);
                this.toggleSubcategories(mainCategory);
            } else {
                this.loadContent(mainCategory);
                this.setActiveCategory(mainCategory);
            }
        }
    }

    populateFontSelector() {
        const fontSelector = document.getElementById('font-selector');
        fontSelector.innerHTML = '';
        
        guidebookConfig.texts.availableFonts.forEach(font => {
            const option = document.createElement('option');
            option.value = font;
            option.textContent = font;
            fontSelector.appendChild(option);
        });
    }

    setupTextContent() {
        document.getElementById('sidebar-header').textContent = guidebookConfig.texts.sidebarHeader;
        document.getElementById('search-input').placeholder = guidebookConfig.texts.searchPlaceholder;
        document.getElementById('settings-header').textContent = guidebookConfig.texts.uiSettings;
        document.getElementById('settings-description').textContent = guidebookConfig.texts.uiSettingsDescription;
        document.getElementById('text-size-label').textContent = guidebookConfig.texts.changeTextSize;
        document.getElementById('search-bar-label').textContent = guidebookConfig.texts.searchBar;
        document.getElementById('select-font-label').textContent = guidebookConfig.texts.selectFont;
        
        this.populateFontSelector();
    }

    hideUI() {
        document.querySelector('body').style.display = 'none';
    }
}

// Initialize the guidebook when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.olrpGuidebook = new OLRPGuidebook();
});

// Legacy function support for backward compatibility
function closeUI() {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.closeUI();
    }
}

function showUI() {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.showUI();
    }
}

function handleMessage(event) {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.handleMessage(event);
    }
}

function openFullScreenImg(src) {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.openFullScreenImg(src);
    }
}

function closeFullScreenImg() {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.closeFullScreenImg();
    }
}

function openSettings() {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.openSettings();
    }
}

function closeSettings() {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.closeSettings();
    }
}

function changeFont(font) {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.changeFont(font);
    }
}

function changeTextSize(action) {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.changeTextSize(action);
    }
}

function toggleSearchBar() {
    if (window.olrpGuidebook) {
        const searchToggle = document.getElementById('search-toggle');
        window.olrpGuidebook.toggleSearchBar(searchToggle.checked);
    }
}

function openExternalLinkModal(url) {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.openExternalLinkModal(url);
    }
}

function closeExternalLinkModal() {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.closeExternalLinkModal();
    }
}

function openExternalLink(url) {
    if (window.olrpGuidebook) {
        window.olrpGuidebook.openExternalLink(url);
    }
}