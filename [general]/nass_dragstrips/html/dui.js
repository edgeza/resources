const leftbox = document.querySelector(".firstbox");
const rightbox = document.querySelector(".secondbox");
const DisplayRoot = document.getElementById("board-times");
	
const firsttime = document.getElementById("firsttime");
const secondtime = document.getElementById("secondtime");
const firstmph = document.getElementById("firstmph");
const secondmph = document.getElementById("secondmph");

window.addEventListener("message", function(event) {
	var data = event.data
	if(data.event=="showTime") {
		
		DisplayRoot.classList.toggle("hidden", false)
		if (data.pos == 1) {
			leftbox.style.opacity = "1";
			firsttime.textContent = `${data.time}`;
			firstmph.textContent = `${data.speed} ${data.unit}`;
		} else if (data.pos == 2) {
			rightbox.style.opacity = "1";
			secondtime.textContent = `${data.time}`;
			secondmph.textContent = `${data.speed} ${data.unit}`;
		}
	}else if(data.event=="hideBoard"){
		leftbox.style.opacity = "0";
		rightbox.style.opacity = "0";
	}
});


fetch(`https://${document.location.host}/duiIsReady`, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify({ok: true})
})