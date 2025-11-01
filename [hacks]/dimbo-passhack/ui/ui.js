let prompt = null
let timerDone = false
let timeoutHandle = null
let progress = 0

let ProgressSpeed = 70 // Increase this to make the progress slower - Decrease this to make the progress faster

window.addEventListener('message', function (event) {
    if ( event.data.type === "show" ) {

		let passDelay = 0
		timerDone = false
		progress = 0

		$("#prog-bar").css('width', 100 - progress + "%") // Make the progress bar full

		if (timeoutHandle) {
			clearInterval(timeoutHandle)
			timeoutHandle = null;
		}

		$("#passhack-input").show()
		$("#passhack-hint").show()
		$("#prog-bar").show()

		// Ugly way of doing this but it'll work for now
		switch (event.data.diff) {
			case 1:
				prompt = getRandIntRange(1000, 9999)
				passDelay = 1000
				break;
				
			case 2:
				prompt = getRandIntRange(10000, 99999)
				passDelay = 1500
				break;

			case 3:
				prompt = getRandIntRange(100000, 999999)
				passDelay = 2000
				break;

			case 4:
				prompt = getRandIntRange(1000000, 9999999)
				passDelay = 2500
				break;

			case 5:
				prompt = getRandIntRange(10000000, 99999999)
				passDelay = 3000
				break;

			case 6:
				prompt = getRandIntRange(100000000, 999999999)
				passDelay = 3500
				break;

			case 7:
				prompt = getRandIntRange(1000000000, 9999999999)
				passDelay = 4000
				break;

			case 8:
				prompt = getRandIntRange(10000000000, 99999999999)
				passDelay = 4500
				break;

			case 9:
				prompt = getRandIntRange(100000000000, 999999999999)
				passDelay = 5000
				break;

			case 10:
				prompt = getRandIntRange(1000000000000, 9999999999999)
				passDelay = 5500
				break;
		}

		// Show the password for a few seconds
		$("#passhack-prompt").html(prompt)
		$("#body").fadeIn(300)
		document.getElementById("passhack-input").disabled = true

		
		// After a few seconds, hide the password
		setTimeout(() => {
			document.getElementById("passhack-input").disabled = false
			document.getElementById("passhack-input").focus()
			$("#passhack-prompt").html(prompt.toString().replace(/[0-9]/g, '*'))

			// Start the timer
			timeoutHandle = setInterval(() => {
				progress++
				$("#prog-bar").css('width', 100 - progress + "%")

				if (progress == 100) {
					if ( timerDone ) { return } // Check if the timer is already done.

					document.getElementById("passhack-input").style.border = "1px solid #ea686d"
					document.getElementById("passhack-input").disabled = true
					document.getElementById("passhack-prompt").innerHTML = "Failed Crack!"

					$("#passhack-input").hide()
					$("#passhack-hint").hide()
					$("#prog-bar").hide()

					setTimeout(() => {
						document.getElementById("passhack-input").disabled = true
						document.getElementById("passhack-input").style.border = "none"
						$.post('http://dimbo-passhack/failHack', JSON.stringify({}));
						$("#body").hide()
					}, 1500);

					timerDone = true

					clearInterval(timeoutHandle)
					timeoutHandle = null;
				}
			}, ProgressSpeed);
			
		}, passDelay);
	}
});

document.onkeyup = function (data) {
	if (data.which == 27) { // Escape key
		$("#body").hide()
		$.post('http://dimbo-passhack/close', JSON.stringify({}));
	}
};

$(document).ready(function() {
	$("#body").hide()

	// Handle hitting enter to submit the password
	document.getElementById("passhack-input").addEventListener("keyup", function(event) {
		if (event.keyCode === 13) {
			event.preventDefault();

			if ( prompt == document.getElementById("passhack-input").value ) {
				
				if ( timerDone ) { return }
				document.getElementById("passhack-input").style.border = "1px solid #4bc076"
				document.getElementById("passhack-input").disabled = true
				document.getElementById("passhack-prompt").innerHTML = "Password Cracked!"
				$("#passhack-input").hide()
				$("#passhack-hint").hide()
				$("#prog-bar").hide()
				setTimeout(() => {
					document.getElementById("passhack-input").disabled = false
					document.getElementById("passhack-input").style.border = "none"
					$.post('http://dimbo-passhack/passHack', JSON.stringify({}));
					$("#body").hide()
				}, 1500);

				clearInterval(timeoutHandle)
				timeoutHandle = null;

				timerDone = true

			} else {

				if ( timerDone ) { return }
				document.getElementById("passhack-input").style.border = "1px solid #ea686d"
				document.getElementById("passhack-input").disabled = true
				document.getElementById("passhack-prompt").innerHTML = "Failed Crack!"
				$("#passhack-input").hide()
				$("#passhack-hint").hide()
				$("#prog-bar").hide()
				setTimeout(() => {
					document.getElementById("passhack-input").disabled = false
					document.getElementById("passhack-input").style.border = "none"
					$.post('http://dimbo-passhack/failHack', JSON.stringify({}));
					$("#body").hide()
				}, 1500);

				clearInterval(timeoutHandle)
				timeoutHandle = null;

				timerDone = true
			}

			document.getElementById("passhack-input").value = ""
		}
	});
})

function getRandIntRange(min, max) {
	return Math.floor(Math.random() * (max - min + 1) + min);
}

// Stops player from copy/pasting the password. Don't remove this!
$('body').bind('copy paste',function(e) {
    e.preventDefault(); return false; 
});

// This will eventually fix the ugly code of difficulty switch case
// function randomFixedInteger(length) {
//     return Math.floor(Math.pow(10, length-1) + Math.random() * (Math.pow(10, length) - Math.pow(10, length-1) - 1));
// }