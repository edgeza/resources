time = null
LocalTime = 0

window.addEventListener('message', function(event) {
    let data = event.data

    if (data.action === "OpenMenu") {
        ExecutionsTable = data.table
        ExecutionsTable2 = data.executions
        Currency = data.currencyforms
        LocalTime = data.currenttime
        MaxTime = data.repeatable
        PreparationStarted = data.preparation
        show('execution_menu')
        BackgroundBlur('plugin', 'panel_main')
        CreateMainPage()
    } 
    else if (data.action === "OpenDetonatorMenu") {
        if (data.time != null && time == null){
            time = data.time
            $('.indicator').css("top", '215px')
            $('.indicator').css("left", '153.5px')
            $('.indicator').css("transform", 'none')
            $('.counter').css("animation", 'none')

            $(`.counter`).html(fancyTimeFormat(time))
            Timer = setInterval(() => {
                if (time != 0){
                    time = time - 1 
        
                    $(`.counter`).html(fancyTimeFormat(time))
                }
                else{
                    clearInterval(Timer)
                    time = null
                    window.postMessage({action : "Deactivate"}, '*');
                }
            }, 1000)
        }

        show('bomb_detonator')
    } 
    else if (data.action === "Deactivate") {
        clearInterval(Timer)
        time = null
        $('.indicator').css("top", '116px')
        $('.indicator').css("left", '155.5px')
        $('.indicator').css("transform", 'ScaleY(-1)')
        $('.counter').css("animation", 'counter_anim 1s infinite')
    }
    else if (data.action === "OpenTaskPanel") {
        show('task_next_menu')
        $(".task_next_menu .title").html(data.title)
        $(".task_next_menu .next_des").html(data.description)
        setTimeout(() => {
            BackgroundBlur("plugin6", 'panel_task_next')
        }, 1);
        setTimeout(() => {
            hide('task_next_menu')
        }, 15000);
    }
    else if (data.action === "HideTaskPanel") {
        hide('task_next_menu')
    }
    else if (data.action === "OpenTaskEndPanel") {
        Currency = data.currencyforms
        show('task_completed_menu')
        $(".task_completed_menu .title").html(data.title)
        $(".task_completed_menu .task_label").html(data.description)
        $(".task_completed_menu .task_plus_rep").html(data.reputation  == 0?"":"+"+data.reputation.toLocaleString() +" "+Currency.rep)
        BackgroundBlur("plugin5", 'panel_task_completed')
        setTimeout(() => {
            hide('task_completed_menu')
        }, 10000);
    }
    else if (data.action === "close") {
        Close()
    }
})

document.onkeydown = function(data) {
    if (event.key == 'Escape') {
        Close()
    }
}

function Close() {
    hide('execution_menu')
    hide('bomb_detonator')
    $.post('https://' + GetParentResourceName() + '/UseButton', JSON.stringify({
        action: "close"
    }))
}

function CreateMainPage(){
    $(".task_container").html("")
    for (const key in ExecutionsTable) {
        if (ExecutionsTable[key].previous == 0 || (LocalTime-ExecutionsTable[key].previous)/MaxTime >= 1){
            if (ExecutionsTable[key].preparation){
                $(".task_container").append(`
                    <div class="task_element can_start">
                        <div class="label">${ExecutionsTable2[ExecutionsTable[key].key].Label}</div>
                        <div class="des">${ExecutionsTable2[ExecutionsTable[key].key].Description}</div>
                         <div class="reward ready">${'READY'+'<br><span class="green_text">'+ExecutionsTable2[ExecutionsTable[key].key].Price.toLocaleString()+' '+Currency.balance+'</span>'}</div>
                        <div class="action_part" style="position: absolute; bottom: 5px; right: -5px;">
                            <button class="start_task_btn" id="${ExecutionsTable[key].key}" onclick="StartExecution(id)">START<img src="assets/arrows.svg"></button>
                        </div>
                    </div>
                `)
            }
            else{
                $(".task_container").append(`
                    <div class="task_element">
                        <div class="label">${ExecutionsTable2[ExecutionsTable[key].key].Label}</div>
                        <div class="des">${ExecutionsTable2[ExecutionsTable[key].key].Description}</div>
                        <div class="reward">${'PREPARATION'+'<br><span class="green_text">'+ExecutionsTable2[ExecutionsTable[key].key].Price.toLocaleString()+' '+Currency.balance+'</span>'}</div>
                        <div class="action_part" style="position: absolute; bottom: 5px; right: -5px;">
                            <button class="start_task_btn" id="${ExecutionsTable[key].key}" onclick="StartExecution(id)">START<img src="assets/arrows.svg"></button>
                        </div>
                    </div>
                `)
            }
        }
        else{
            $(".task_container").append(`
                <div class="task_element">
                    <div class="label">${ExecutionsTable2[ExecutionsTable[key].key].Label}</div>
                    <div class="des">${ExecutionsTable2[ExecutionsTable[key].key].Description}</div>
                    <div class="reward">PREPARATION</div>
                    <div class="action_part" style="position: absolute; bottom: -5px; right: -30px; height: 40px; width: 300px; scale: 0.8;">
                            <div class="status_text">REMAINED:</div>
                            <div class="status_text right_side">${fancyTimeFormat2(MaxTime-(LocalTime-ExecutionsTable[key].previous))}</div>
                            <div class="progress_line">
                                <div class="progress" style="width: ${(LocalTime-ExecutionsTable[key].previous)/MaxTime*100}%"></div>
                            </div>
                    </div>
                </div>
            `)
        }
    }

    if (PreparationStarted != null){
        document.getElementById(PreparationStarted).disabled = true
    }
}

function StartExecution(id){
    Close()
    $.post('https://' + GetParentResourceName() + '/UseButton', JSON.stringify({
        action: "execution",
        key: id
    }))
}

function SendDetonation(){
    window.postMessage({action : "Deactivate"}, '*');
    $.post('https://' + GetParentResourceName() + '/UseButton', JSON.stringify({
        action: "detonator"
    }))
}


function BackgroundBlur(element, target) {
    var bodyRect = document.body.getBoundingClientRect()
    let elemRect = document.getElementById(target).getBoundingClientRect()
    offset = []
    offset.push(elemRect.top - bodyRect.top, (elemRect.right - bodyRect.right) * (-1), elemRect.bottom - bodyRect.bottom, elemRect.left - bodyRect.left)
    $('#' + element).css('clip-path', `inset(${offset[0]}px ${offset[1]}px calc(100% - ${offset[2]}px) ${offset[3]}px)`)
}

function show(element) {
    $("#" + element).css("display", "block")
    document.getElementById(element).style.animation = "showmenu 0.35s ease";
}

function hide(element) {
    document.getElementById(element).style.animation = "hidemenu 0.3s ease";
    setTimeout(function() {
        $("#" + element).css("display", "none")
    }, 300)
}

function show2(element) {
    $("#" + element).css("display", "block")
    document.getElementById(element).style.animation = "Home_cons 0.3s ease";
}

function hide2(element) {
    document.getElementById(element).style.animation = "reverse_Home_cons 0.2s ease";
    setTimeout(function() {
        $("#" + element).css("display", "none")
    }, 200)
}


function isNumber(evt) {
    evt = (evt) ? evt : window.event
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false
    }
    return true
}

function fancyTimeFormat(duration)
{   
    var hrs = ~~(duration / 3600);
    var mins = ~~((duration % 3600) / 60);
    var secs = ~~duration % 60;

    var ret = "";

    if (hrs > 0){
        mins = 60
    }

    if (mins < 10) {
        mins = '0'+ mins
    }

    if (duration % 2 == 0){
        ret += "" + mins + " : " + (secs < 10 ? "0" : "");         
    }
    else{
        ret += "" + mins + " <span>:</span> " + (secs < 10 ? "0" : "");
    }

    ret += "" + secs;
    return ret;
}

function fancyTimeFormat2(duration)
{   
    var hrs = ~~(duration / 3600);
    var mins = ~~((duration % 3600) / 60);
    var secs = ~~duration % 60;

    var ret = "";

    if (hrs > 0) {
        ret += "" + hrs + "h " + (mins < 10 ? "0" : "");
    }

    ret += "" + mins + "m "// + (secs < 10 ? "0" : "");
    //ret += "" + secs + "s";
    return ret;
}

