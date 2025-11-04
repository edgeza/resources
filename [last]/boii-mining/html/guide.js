//------------------------------\\
//---\\ BOII | DEVELOPMENT //---\\
//------------------------------\\

var pages = document.getElementsByClassName('page');

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.open == true) {
            $('#main-container').removeClass('hidden');
        } else if (item.open == false) {
            $('#main-container').addClass('hidden');
        } 
    })
    $(document).keyup(function (exit) {
        if (exit.keyCode === 27) {     
            CloseGuide();      
        }      
    });
})

for (var i = 0; i < pages.length; i++) {
    var page = pages[i];
    if (i % 2 === 0)
    {
        page.style.zIndex = (pages.length - i);
    }
}

document.addEventListener('DOMContentLoaded', function() {
    for (var i = 0; i < pages.length; i++) {
        pages[i].pageNum = i + 1;
        pages[i].onclick=function() {
        if (this.pageNum % 2 === 0) {
                this.classList.remove('flipped');
                this.previousElementSibling.classList.remove('flipped');
            }
        else {
                this.classList.add('flipped');
                this.nextElementSibling.classList.add('flipped');
            }
        }
    }
})

function CloseGuide() {
    $.post('https://boii-mining/CloseGuide', JSON.stringify({}));  
	$('#main-container').addClass('hidden');
}