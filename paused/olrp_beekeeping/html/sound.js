// Beehive custom sound system
const beeSound = document.getElementById('bee-sound');
const wildBeeSound = document.getElementById('wild-bee-sound');
const beeStingSound = document.getElementById('bee-sting-sound');

console.log('🐝 Beehive sound system loading...');
console.log('Placed hive audio:', beeSound);
console.log('Wild hive audio:', wildBeeSound);
console.log('Bee sting audio:', beeStingSound);

// Listen for messages from client script
window.addEventListener('message', (event) => {
    const data = event.data;
    
    console.log('🐝 NUI Message received:', data);
    
    if (data.action === 'playBeeSound') {
        console.log('🐝 Playing PLACED hive sound - Volume:', data.volume);
        playBeeSound(data.volume || 0.5, data.loop || false);
    } else if (data.action === 'playWildBeeSound') {
        console.log('🐝 Playing WILD hive sound - Volume:', data.volume);
        playWildBeeSound(data.volume || 0.5, data.loop || false);
    } else if (data.action === 'stopBeeSound') {
        console.log('🐝 Stopping all bee sounds');
        stopBeeSound();
    } else if (data.action === 'stopWildBeeSound') {
        console.log('🐝 Stopping WILD bee sound only');
        stopWildBeeSound();
    } else if (data.action === 'playStingSound') {
        console.log('🐝 Playing BEE STING sound - Volume:', data.volume);
        playStingSound(data.volume || 1.0);
    } else if (data.action === 'testSound') {
        console.log('🐝 TEST SOUND triggered');
        testSound();
    }
});

function playBeeSound(volume = 0.5, loop = false) {
    console.log('🐝 playBeeSound() called - Volume:', volume, 'Loop:', loop);
    
    if (beeSound) {
        console.log('🐝 Audio element found, configuring...');
        beeSound.volume = volume;
        beeSound.loop = loop;
        
        // Reset and play
        beeSound.currentTime = 0;
        console.log('🐝 Attempting to play PLACED hive audio...');
        
        beeSound.play()
            .then(() => {
                console.log('✅ PLACED hive audio playing successfully!');
            })
            .catch(err => {
                console.error('❌ PLACED hive audio play failed:', err);
            });
    } else {
        console.error('❌ Placed hive audio element not found!');
    }
}

function playWildBeeSound(volume = 0.5, loop = false) {
    console.log('🐝 playWildBeeSound() called - Volume:', volume, 'Loop:', loop);
    
    if (wildBeeSound) {
        console.log('🐝 Wild audio element found, configuring...');
        wildBeeSound.volume = volume;
        wildBeeSound.loop = loop;
        
        // Reset and play
        wildBeeSound.currentTime = 0;
        console.log('🐝 Attempting to play WILD hive audio...');
        
        wildBeeSound.play()
            .then(() => {
                console.log('✅ WILD hive audio playing successfully!');
            })
            .catch(err => {
                console.error('❌ WILD hive audio play failed:', err);
            });
    } else {
        console.error('❌ Wild hive audio element not found!');
    }
}

function stopBeeSound() {
    if (beeSound) {
        beeSound.pause();
        beeSound.currentTime = 0;
    }
    if (wildBeeSound) {
        wildBeeSound.pause();
        wildBeeSound.currentTime = 0;
    }
    console.log('🐝 All sounds stopped');
}

function stopWildBeeSound() {
    if (wildBeeSound) {
        wildBeeSound.pause();
        wildBeeSound.currentTime = 0;
        console.log('🐝 Wild bee sound stopped');
    }
}

function playStingSound(volume = 1.0) {
    console.log('🐝 playStingSound() called - Volume:', volume);
    
    if (beeStingSound) {
        console.log('🐝 Bee sting audio element found, configuring...');
        beeStingSound.volume = volume;
        beeStingSound.loop = false; // Play once only
        
        // Reset and play
        beeStingSound.currentTime = 0;
        console.log('🐝 Attempting to play BEE STING audio...');
        
        beeStingSound.play()
            .then(() => {
                console.log('✅ BEE STING audio playing successfully!');
            })
            .catch(err => {
                console.error('❌ BEE STING audio play failed:', err);
            });
    } else {
        console.error('❌ Bee sting audio element not found!');
    }
}

function testSound() {
    console.log('🐝 TEST: Playing placed hive sound at full volume');
    playBeeSound(1.0, false);
    setTimeout(() => {
        console.log('🐝 TEST: Playing wild hive sound at full volume');
        playWildBeeSound(1.0, false);
    }, 2000);
    setTimeout(() => {
        console.log('🐝 TEST: Playing bee sting sound');
        playStingSound(1.0);
    }, 4000);
}

// Initialize
console.log('✅ Beehive sound system initialized!');
console.log('Placed hive source:', beeSound ? beeSound.src : 'NOT FOUND');
console.log('Wild hive source:', wildBeeSound ? wildBeeSound.src : 'NOT FOUND');
console.log('Bee sting source:', beeStingSound ? beeStingSound.src : 'NOT FOUND');

