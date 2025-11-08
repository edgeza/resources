var audioPlayer = null;
let ListenersAdded = false;
let setColours = false;
let audioPlayerId = 0;
let soundList = []

window.addEventListener('message', (event) => {
    const data = event.data;
    const root = document.querySelector(':root');

    if (event.data.submissionType == "ARS") {
        if (audioPlayer != null) {
            audioPlayer.pause();
        }
        audioPlayer = new Howl({
            src: ["./NUI/sounds/" + event.data.submissionFile + ".ogg"],
            loop: true,
            html5: true,
            autoplay: false,
            volume: event.data.submissionVolume,
            // onend: function(event){
            //     ended(null);
            // },
        });
        if (audioPlayer.playing()) {
            audioPlayer.stop();
        }
        audioPlayer.play();
        // audioPlayer.setLocation(event.data.submissionPos.x, event.data.submissionPos.y, event.data.submissionPos.z)
    }

    if (event.data.submissionType == "STOPARS") {
        if (audioPlayer != null) {
            audioPlayer.fade(event.data.submissionVolume, 0.0, 2500)
            setTimeout(function () {
                audioPlayer.stop();
            }, 2500);
        }
    }

    if (data.type === 'arsmenu') {
        const resName = data.resname
        const toggle = data.openmenu
        const ARSTitle = data.arstitle
        const sirensOn = data.sirenson
        const soundFileName = data.soundfilename
        const soundFileDisplayName = data.soundfiledisplayname

        toggleARSMenu(toggle)

        if (ListenersAdded === false) { 

            document.getElementById('exitbutton').addEventListener('click', function(){
                $.post(`https://`+resName+`/exit`, JSON.stringify({}))
            });

            document.getElementById("leftbutton").addEventListener('click', function(){
                $.post(`https://`+resName+`/soundFileLeft`, JSON.stringify({}))
            }); 
            addButtonSound('[data-btn-name="left-btn"]')
    
            document.getElementById("rightbutton").addEventListener('click', function(){
                $.post(`https://`+resName+`/soundFileRight`, JSON.stringify({}))
            }); 
            addButtonSound('[data-btn-name="right-btn"]')

            document.addEventListener('keyup', function(e) {
                if ('Escape' === e.key || 'Backspace' === e.key) {
                    $.post(`https://`+resName+`/exit`, JSON.stringify({}))
                }
            });
            addButtonSound('[data-btn-name="exit-btn"]')

            ListenersAdded = true;
        }

        // Build buttons to turn on and off. (continue here with sliders)
        if (sirensOn === true) {
            // console.log("building with sirens on")
            $("#menuwrappers").html("")
            $("#menuwrappers").append(
                `<div class="menucontainer_header">` +
                    ARSTitle +
                `</div>` +
                `<div class="menucontainer_contentwrapper">` +
                    `<div class="button" id="button" data-btn-name="power-btn">`+
                        `<div class="light" id="light"></div>`+
                    `</div>`+
                `</div>`+
                `<div class="menucontainer_footer">` +
                    soundFileDisplayName +
                `</div>`
            );
            toggleLightColour(root, sirensOn)

        } else {
            // console.log("building with sirens off")
            $("#menuwrappers").html("")
            $("#menuwrappers").append(
                `<div class="menucontainer_header">` +
                    ARSTitle +
                `</div>` +
                `<div class="menucontainer_contentwrapper">` +
                    `<div class="button" id="button" data-btn-name="power-btn">`+
                        `<div class="light" id="light"></div>`+
                    `</div>`+
                `</div>`+
                `<div class="menucontainer_footer">` +
                        soundFileDisplayName +
                `</div>`
            );
            toggleLightColour(root, sirensOn)
        }
        toggleActivateSirenDisplay(sirensOn)

        addButtonSound('[data-btn-name="power-btn"]')

        document.getElementById("button").addEventListener('click', function(){
            $.post(`https://`+resName+`/toggleARS`, JSON.stringify({}))
        }); 
    }
});

function toggleARSMenu(toggle) {
    let menu = document.getElementById('menucontainer');
    menu.style.display = toggle ? 'flex' : 'none';
}

function toggleLightColour(root, toggle) {
    let el = document.getElementById('light');
    el.style.background = toggle ? '#00e700' : '#e40808';

    if (toggle) {
        root.style.setProperty('--power_btn_sirens_on', '#e40808');
    } else {
        root.style.setProperty('--power_btn_sirens_on', '#00e700');
    }
}

function toggleActivateSirenDisplay(toggle) {
    let el = document.getElementById('sirendisplay');
    el.style.display = toggle ? 'flex' : 'none';
}

function addButtonSound(button) {
    let playBtn = document.querySelector(button)
    let heartbeat = document.getElementById('heartbeat')
    audios = document.querySelectorAll('audio');

    playBtn.addEventListener('click', function() {
        heartbeat.volume = 0.1;
        heartbeat.play();
    }, false);

    // playBtn.addEventListener('mouseleave', function() {
    //     heartbeat.pause();
    //     heartbeat.currentTime = 0;
    // }, false);
}