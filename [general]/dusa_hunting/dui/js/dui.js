// Get map container
const mapContainer = document.getElementById('map-item');
const rootContainer = document.getElementById('root');

// FiveM'e hazır olduğumuzu bildir
window.addEventListener('load', () => {
    fetch(`https://dusa_hunting/duiReady`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
});

window.addEventListener('message', (event) => {
    const data = event.data;

    switch (data.action) {
        case 'show':
            
            // Container'ı göster
            if (rootContainer) {
                rootContainer.style.display = 'block';
                rootContainer.classList.add('visible');
            }
            
            // Map'i sadece ilk kez initialize et
            if (!window.map && typeof window.initializeMap === 'function') {
                window.initializeMap();
            }
            
            // Animal data'yı güncelle
            if (typeof window.fetchAnimalData === 'function') {
                window.fetchAnimalData();
            }
            break;
            
        case 'hide':
            
            // Container'ı gizle
            if (rootContainer) {
                rootContainer.style.display = 'none';
                rootContainer.classList.remove('visible');
            }
            
            // Map'i temizleme, sadece gizle
            break;
            
        case 'updateAnimals':
            if (typeof window.fetchAnimalData === 'function') {
                window.fetchAnimalData();
            }
            break;
            
        default:
            console.log('Unknown action:', data.action);
            break;
    }
});