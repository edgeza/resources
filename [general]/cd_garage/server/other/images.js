const fs = require('fs');
const path = require('path');


global.exports('GetVehicleFolder', () => {
    const dir = path.join(GetResourcePath(GetCurrentResourceName()), 'html/images/vehicles');

    let files = [];
    try {
        files = fs.readdirSync(dir)
        .filter(f => /\.(png|jpe?g|gif|webp)$/i.test(f));
    } catch (e) {
        console.log('[images] Failed to read folder:', e.message);
    }

    return files;
});