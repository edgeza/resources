window.addEventListener('message', function(event){
    const progressBarContainer = document.querySelector('.progress-bar__container');
    const progressBar = document.querySelector('.progress-bar');
    const progressBarText = document.querySelector('.progress-bar__text');

    let data = event.data;
    let endState = 100;

    $('#task').text(data.task);

    if(event.data.Type == "showBar")
	{
		$(".barcontainer").css("visibility","visible");

        if(event.data.time >= endState){
            gsap.to(progressBar, {
              x: `${event.data.time}%`,
              backgroundColor: event.data.color,
            });
          }else{
            gsap.to(progressBar, {
          x: `${event.data.time}%`,
          backgroundColor: event.data.color,
            });
          }

	}
	else  if(event.data.Type == "hideBar")
	{
		$(".barcontainer").css("visibility","hidden");
    gsap.to(progressBar, {
      x: `0%`
        });
	}
});