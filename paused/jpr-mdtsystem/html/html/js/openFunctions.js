var maxRetries = 3 // dont touch
var maxTimeout = 3000 // dont touch
var maxQueries = 25 // dont touch

function FormatDate(timestamp) {
    const date = new Date(timestamp);
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0'); // Los meses empiezan desde 0
    const year = date.getFullYear();

    return `${day}/${month}/${year}`;
}

function ChangeReportBackgroundColor(id) {
    const boxes = document.querySelectorAll('.mdt-content-reports-list-list .mdt-content-reports-list');

    boxes.forEach(box => {
        var Informacoes = $(box).data('reportData');

        if (id) {
            if (Informacoes.id == id) {
                $(box).css({"background-color":"rgba(241, 166, 26, 0.501)"})
            }
        } else {
            $(box).css({"background-color":"var(--mainBG)"})
        }
    });
}

function ClickSound() {
    if (mdtData?.configFile?.EnableSound) {
        var audio = document.getElementById("clickSound");
        audio.volume = 0.45;
        audio.play();
    }
}

function FormatCurrency(amount) {
    return amount+"€"
}

function SearchFine() {
    var filter = $("#searchFines").val().toUpperCase();
    var list = document.getElementById("allFines");
    var divs = list.getElementsByTagName("div");
    
    for (var i = 0; i < divs.length; i++) {
        var a = divs[i].getElementsByTagName("h1")[0];
    
        if (a) {
            if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
                $(divs[i]).fadeIn(100)
            } else {
                $(divs[i]).fadeOut(100)
            }
        }
    }
}