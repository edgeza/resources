let stopwatchInterval = null;
var notificationSound2 = new Audio('sounds/flash.ogg');
var closing = false;
var isSet = false
var Locales;

window.addEventListener('message', function(event) {
  	var data = event.data;
	if (data.event == "showTimer") {
		document.getElementById('stopwatchtime').innerHTML = ".000";
		const stopwatchContainer = document.getElementById('stopwatch-time-cont');
		

		stopwatchContainer.style.height = '0';
		stopwatchContainer.style.overflow = 'hidden';
		stopwatchContainer.style.display = 'flex';
		stopwatchContainer.style.alignItems = 'center';
		stopwatchContainer.style.justifyContent = 'center';
		document.getElementById("stopwatchtime").style.color = "#fff";

		stopwatchContainer.animate(
		{ height: ['0', '100px'] },
		{ duration: 1500, easing: 'ease-in-out', fill: 'forwards' }
		);
	} else if (data.event == "startCount") {
		startStopwatch();
	} else if (data.event == "pauseCount") {
		stopStopwatch(data.time);
	}else if(data.event=="leaderboard"){
		if (closing === false) {
			openLeaderboard(data);
		}
	}else if(data.event=="timeslip"){
		showticket(data);
	}else if(data.event=="hidetimeslip"){
				hidetimeslip()
	} else if (data.event == "cancelRace") {
	  const stopwatchContainer = document.getElementById('stopwatch-time-cont');

	  document.getElementById("stopwatchtime").style.color = "#FF0000";
	  clearInterval(stopwatchInterval);
	  stopwatchInterval = null;

	  setTimeout(() => {
		stopwatchContainer.animate(
		  { height: ['100px', '0'] },
		  { duration: 1500, easing: 'ease-in-out', fill: 'forwards' }
		);

		setTimeout(() => {
		  stopwatchContainer.style.display = 'none';
		  stopwatchContainer.style.height = '0';
		}, 1600);
	  }, 5000);
	}else if (data.event == "newRecord") {

	// flicker the element four times
	for (var i = 0; i < 6; i++) {
		// set the color to white
		document.getElementById("stopwatchtime").style.color = "#fff";
		notificationSound2.play();
		// wait for 100 milliseconds
		setTimeout(function() {
			// set the color back to its original value
			document.getElementById("stopwatchtime").style.color = "#3ef20d";
		}, 100);
		
		// wait for 200 milliseconds before flickering again
		setTimeout(function() {
			// set the color to white again
			document.getElementById("stopwatchtime").style.color = "#fff";
		}, 200);
		
		// wait for 300 milliseconds before the next flicker
		setTimeout(function() {
			// set the color to the original green again
			document.getElementById("stopwatchtime").style.color = "#3ef20d";
		}, 300);
		
		// wait for 400 milliseconds before the next flicker
		setTimeout(function() {
			// set the color to white again
			document.getElementById("stopwatchtime").style.color = "#fff";
		}, 400);
		
		setTimeout(function() {
			// set the color to the original green again
			document.getElementById("stopwatchtime").style.color = "#3ef20d";
		}, 500);
		
		// wait for 400 milliseconds before the next flicker
		setTimeout(function() {
			// set the color to white again
			document.getElementById("stopwatchtime").style.color = "#fff";
		}, 600);
	}

	}
});

let startTime = null;

function startStopwatch() {
  startTime = new Date();
  stopwatchInterval = setInterval(() => {
    updateStopwatch();
  }, 10);
}

function stopStopwatch(time) {
  const stopwatchContainer = document.getElementById('stopwatch-time-cont');
  clearInterval(stopwatchInterval);
  stopwatchInterval = null;
  document.getElementById("stopwatchtime").innerHTML = time;
  document.getElementById("stopwatchtime").style.color = '#3ef20d';

  setTimeout(() => {
    stopwatchContainer.animate(
      { height: ['100px', '0'] },
      { duration: 1000, easing: 'ease-in-out', fill: 'forwards' }
    );

    setTimeout(() => {
      stopwatchContainer.style.display = 'none';
      stopwatchContainer.style.height = '0';
    }, 1000);
  }, 10000);
}


function updateStopwatch() {
  const currentTime = new Date();
  const elapsedMilliseconds = currentTime - startTime;
  const elapsedSeconds = Math.floor(elapsedMilliseconds / 1000);
  const elapsedMillisecondsFormatted = elapsedMilliseconds % 1000;
  const formattedStopwatchTime = `${elapsedSeconds < 10 ? '0' : ''}${elapsedSeconds}.${elapsedMillisecondsFormatted < 10 ? '00' : elapsedMillisecondsFormatted < 100 ? '0' : ''}${elapsedMillisecondsFormatted}`;
  document.getElementById('stopwatchtime').innerHTML = formattedStopwatchTime;
}



// Stop and reset the stopwatch when the window is unloaded
window.addEventListener('beforeunload', function() {
  stopStopwatch();
});



// leaderboard


$(document).keyup(function(event) {
	if (event.which == 27) {
		closeMenu()
		return
	}
});

function openLeaderboard(data) {
	var count = 1
	document.querySelector(".yourrank").innerHTML = `<span>N/A ${Locales["ranked_place"]}</span>`;
	if (data.data) {
		Object.values(data.data).forEach(function(element) {
		addListItem(element.name, element.car, element.time, element.identifier, data.playerIdentifer, count, element.speed, data.unit);
		count = count + 1;
		});
	}
	document.querySelector(".playeramount").innerHTML = data.total;
	document.querySelector(".traplocation").innerHTML = data.name;
	var container = document.querySelector(".container");
	container.style.display = "block";
	container.classList.add('animate__animated', 'animate__fadeInDown');
	container.style.setProperty('--animate-duration', '0.8s');
	isSet = false
}
  
  
function closeMenu() {
	$.post(`https://${GetParentResourceName()}/closemenu`);

	var container = $(".container");
	container.addClass('animate__animated animate__fadeOutUp');
	container.css('--animate-duration', '0.8s');
	closing = true;
	const listContainer = document.querySelector('.listcontainer ul');
	while (listContainer.hasChildNodes()) {
	listContainer.removeChild(listContainer.firstChild);
	}
	container.animate({ opacity: 0 }, 800, function() {
	container.hide();

	setTimeout(function() {
		container.removeClass('animate__animated animate__fadeOutUp');
	}, 1); 
	closing = false;
	});
}



function addListItem(username, car, time, identifier, playerID, rank, speed, unit) {
	const listContainer = document.querySelector('.listcontainer ul');
	const listItem = document.createElement('li');

	if(identifier == playerID && !isSet){
		listItem.style.background = 'linear-gradient(to right, rgb(255, 207, 117) 90%, rgb(255, 149, 0) 90%)';
		document.querySelector(".yourrank").innerHTML = `<span>${addEnding(rank)} ${Locales["ranked_place"]}</span>`;
		isSet = true
	}

	listItem.innerHTML = `
	<span class="rank">${rank}</span>
	<span class="userinfo">${username}, ${car}<span class="userspeed">${speed} ${unit}</span></span>
	<span class="speed">${time}</span>`;

	listContainer.appendChild(listItem);
}

function addEnding(number) {
	if (number % 100 >= 11 && number % 100 <= 13) {
		return number + 'th';
	}

	switch (number % 10) {
	case 1:
		return number + 'st';
	case 2:
		return number + 'nd';
	case 3:
		return number + 'rd';
	default:
		return number + 'th';
	}
}

  // show ticket

function showticket(data) {

/*$.post(`https://${GetParentResourceName()}/spectate`, JSON.stringify({
	id : data.id,
	}));*/

var ticket = document.querySelector(".timeslip");
var carmodel = document.getElementById("car-model");
var greeting = document.querySelector(".greeting");
var totalmph = document.getElementById("totalmph");
var hundredmph = document.getElementById("100mph");
var sixtymph = document.getElementById("60mph");
var reactiontime = document.getElementById("reactiontime");

//distances

var oneeight = document.getElementById("8thmile");
var quartermile = document.getElementById("quartermile");
var halfmile = document.getElementById("halfmile");
var onemile = document.getElementById("1mile");

ticket.style.display = "block";

greeting.textContent = (`${Locales["welcome"]}` + data.name) 
carmodel.textContent = (`${Locales["car_model"]}` + data.model)

reactiontime.textContent = (`${Locales["reaction_time"]}` + data.reaction)  
oneeight.textContent = (`${Locales["one_eighth"]}` + data.eighth)  
quartermile.textContent = (`${Locales["one_fourth"]}` + data.quarter)  
halfmile.textContent = (`${Locales["one_half"]}` + data.half)
onemile.textContent = (`${Locales["one_mile"]}` + data.full)   
totalmph.textContent = (`${Locales["top_speed"]}` + data.topSpeed)

if (data.mph) {
	hundredmph.textContent = (`${Locales["one_hundred"]}` + data.hundred) 
	sixtymph.textContent = (`${Locales["sixty"]}` + data.sixty) 
} else {
	hundredmph.textContent = (`${Locales["one_sixty"]}` + data.hundred) 
	sixtymph.textContent = (`${Locales["one_hundred_kmh"]}` + data.sixty) 
}

}

function hidetimeslip() {
var ticket = document.querySelector(".timeslip");
ticket.classList.add("fadeOutRight");
setTimeout(function() {
	ticket.style.display = "none";
	ticket.classList.remove("fadeOutRight");
}, 500);
}


document.addEventListener('DOMContentLoaded', function() {
	$.post(`https://${GetParentResourceName()}/getlocale`, JSON.stringify({}), function(data) {
    Locales = data
    $("#plyranked").html(data["players_ranked"]);
	$(".headertext").html(data["header_text"]);
	$(".greeting2").html(data["thankyou"]);
	$("#your-times").html(data["your_times"]);
  });
});