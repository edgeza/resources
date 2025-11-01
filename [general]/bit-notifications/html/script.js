document.addEventListener("DOMContentLoaded", function () {
    function display(bool) {
        if (bool) {
            document.getElementById("body").style.display = "block";
        } else {
            document.getElementById("body").style.display = "none";
        }
    }

    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type === "open") {   
            const notificationElement = document.createElement('div');
            notificationElement.id = "notification-" + item.id;
            notificationElement.innerHTML = item.notificationHTML;
            notificationElement.style.marginBottom = "3vh"; 
            notificationElement.classList.add("notification");

            // Añadir la notificación al contenedor principal
            document.getElementById("notifications").appendChild(notificationElement);
            if (item.position === "top-right") {
                document.getElementById("notifications").style.top = "4vh";
                document.getElementById("notifications").style.right = "2vw";
            } else if (item.position === "top-left") {
                document.getElementById("notifications").style.top = "4vh";
                document.getElementById("notifications").style.left = "2vw";
            } else if (item.position === "bottom-right") {
                document.getElementById("notifications").style.bottom = "4vh";
                document.getElementById("notifications").style.right = "2vw";
            }
            else if (item.position === "bottom-left") {
                document.getElementById("notifications").style.bottom = "4vh";
                document.getElementById("notifications").style.left = "2vw";
            } else if (item.position === "top-center") {
                document.getElementById("notifications").style.top = "4vh";
                document.getElementById("notifications").style.left = "50%";
                document.getElementById("notifications").style.transform = "translateX(-50%)";
            } else if (item.position === "bottom-center") {
                document.getElementById("notifications").style.bottom = "4vh";
                document.getElementById("notifications").style.left = "50%";
                document.getElementById("notifications").style.transform = "translateX(-50%)";
            } else if (item.position === "center-left") {
                document.getElementById("notifications").style.top = "50%";
                document.getElementById("notifications").style.left = "2vw";
                document.getElementById("notifications").style.transform = "translateY(-50%)";
            } else if (item.position === "center-right") {
                document.getElementById("notifications").style.top = "50%";
                document.getElementById("notifications").style.right = "2vw";
                document.getElementById("notifications").style.transform = "translateY(-50%)";
            }
            display(true)
        }
        if (item.type === "close") {
            const notificationElement = document.getElementById("notification-" + item.id);
            if (notificationElement) {
                notificationElement.classList.add("fade-out");

                setTimeout(() => {
                    notificationElement.remove();
                    if (document.getElementById("notifications").children.length === 0) {
                        display(false);
                    }
                }, 500);
            }
            if (document.getElementById("notifications").children.length === 0) {
                display(false);
            }
        }
        if (item.type === "storeopen") {
            const notificationElementStore = document.createElement('div');
            notificationElementStore.id = "notificationstore-" + item.id;
            notificationElementStore.innerHTML = item.notificationHTML;
            notificationElementStore.style.marginBottom = "3vh"; 
            notificationElementStore.classList.add("notification");
            document.getElementById("store").appendChild(notificationElementStore);
            if (item.position === "top-right") {
                document.getElementById("store").style.top = "4vh";
                document.getElementById("store").style.right = "2vw";
            } else if (item.position === "top-left") {
                document.getElementById("store").style.top = "4vh";
                document.getElementById("store").style.left = "2vw";
            } else if (item.position === "bottom-right") {
                document.getElementById("store").style.bottom = "4vh";
                document.getElementById("store").style.right = "2vw";
            }
            else if (item.position === "bottom-left") {
                document.getElementById("store").style.bottom = "4vh";
                document.getElementById("store").style.left = "2vw";
            } else if (item.position === "top-center") {
                document.getElementById("store").style.top = "4vh";
                document.getElementById("store").style.left = "50%";
                document.getElementById("store").style.transform = "translateX(-50%)";
            } else if (item.position === "bottom-center") {
                document.getElementById("store").style.bottom = "4vh";
                document.getElementById("store").style.left = "50%";
                document.getElementById("store").style.transform = "translateX(-50%)";
            } else if (item.position === "center-left") {
                document.getElementById("store").style.top = "50%";
                document.getElementById("store").style.left = "2vw";
                document.getElementById("store").style.transform = "translateY(-50%)";
            } else if (item.position === "center-right") {
                document.getElementById("store").style.top = "50%";
                document.getElementById("store").style.right = "2vw";
                document.getElementById("store").style.transform = "translateY(-50%)";
            }
            display(true);
        }
        if (item.type === "storeclose") {
            const notificationElementStore = document.getElementById("notificationstore-" + item.id);
            if (notificationElementStore) {
                notificationElementStore.classList.add("fade-out");

                setTimeout(() => {
                    notificationElementStore.remove();
                    if (document.getElementById("store").children.length === 0) {
                        display(false);
                    }
                }, 500);
            }
            if (document.getElementById("store").children.length === 0) {
                display(false);
            }
        }
    })

});