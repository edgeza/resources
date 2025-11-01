window.addEventListener("message", function(event) {
    var item = event.data;

    switch (item.action) {
        case "OPEN_MENU":
            app.showUI();
            app.getPlayerLevel(item.value,item.playername,item.playerxp, item.items)
            break;
        case "CATEGORIES":
            app.GetCategories(item.value)
            break;
        case "send_response":
            app.GetResponse(item.resourceName)

            break;
        case "CRAFTITEMS":
            app.GetCraftables(item.value);
            break;

        case "ITEMSUPDATE":
            app.GetNewData(item.value);
            break;
        case "DISCORDIMG":
            app.getDiscord(item.value)
            break;
        case "LOCALES":
                app.language(item.value)
        break;
        case "SET_ITEMS":
            app.setPlayerItems(item.value)
        break;
        case "CLOSE_MENU":
            app.hideUI()
            break

        default:

            break;
    }
});

function clicksound() {

	audioPlayer = new Audio("./codemclick.ogg");
	audioPlayer.volume = 0.9;
	audioPlayer.play();
}


const app = new Vue({
    el: "#app",

    data: {
        show: false,
        page: 'main',
        achievementsSwiper: false,
        selectbutton: 'main',
        backgroundimage: 'weaponsbg',
        mainPage: 'main',
        resourceName: '',
        categories: '',
        craftItems: '',
        craftDeatilText: false,
        selectCraftItem: [],
        requiredItems: [],
        playerItems: [],
        enoughBehavior: false,
        lastCraftItemName: '',
        lastitemamount : 1,
        weaponitem: false,
        weaponammo: 0,
        lastCraftItemLabel: '',
        lastCraftItemTime: '',
        lastCraftItemCategory : '',
        cacheUniqeId: null,
        lastCraftItemXp: 0,
        getNewCraftData: [],
        playerDiscordImg: './images/pp.png',
        uuidid: 0,
        playerLevel: 0,
        itemShow: false,
        playerxp: 0,
        lastCraftItemLevel: 0,
        categoryText : '',
        timerImg : '',
        playername : '',
        timeoutCraftButton : false,
        timeout : false,
        languages  :{},

    },
    mounted() {

        document.onkeydown = (evt) => {
            evt = evt || window.event;
            var isEscape = false;
            if ("key" in evt) {
                isEscape = (evt.key === "Escape" || evt.key === "Esc");
            } else {
                isEscape = (evt.keyCode === 27);
            }
            if (isEscape) {
                this.hideUI()
            }
        };



        this.UpdateTimesCraft();
        setInterval(() => {

            this.UpdateTimesCraft();
            this.$forceUpdate();

        }, 1000)

    },
    computed: {
      

        getImage() {
            return (val,completed)=>{
                
                if (completed) {
                    return {
                        ['background-image']: 'url(images/awating-bg-active.png)'
                    }
                }
                if (val == 'weapons') {
                    return {
                        ['background-image']: 'url(images/awating-bg.png)'
                    }
                }
                if (val == 'ammo') {
                    return {
                        ['background-image']: 'url(images/ammo-waiting.png)'
                    }
                }
                if (val == 'tools') {
                    return {
                        ['background-image']: 'url(images/tools-waiting.png)'
                    }
                }
            }
        },
       

    },
    methods: {
        language(val){
            this.languages = val;
         
        },
        
        getTimerImage(val){
            
                if (val == 'weapons') {
                   
                        this.timerImg = 'weaponstimer'
                  
                }
                if (val == 'ammo') {
                  
                        this.timerImg = 'ammotimer'
                    
                }
                if (val == 'tools') {
                  
                        this.timerImg = 'toolstimer'
                    
                }
            
        },

        setPlayerItems(val) {
            this.playerItems = val;
        },

        closepage(){
            clicksound()
            this.show = false
            $.post(`https://${this.resourceName}/close`);
        },
   
        getPlayerLevel(val,val2,val3,val4) {
            this.playerLevel = val;
            this.playername = val2;
            this.playerxp = val3;
            this.playerItems = val4;
        },
        showUI() {
            this.show = true;

          
            setTimeout(() => {
                app.setupAchievementsSwiper();
            },200)
        },

        hideUI() {
            clicksound()
            this.show = false
            this.craftDeatilText = false;
            this.itemShow = false;
            this.enoughBehavior = false;
            this.craftDeatilText = false;
            $.post(`https://${this.resourceName}/close`);

        },
        getUid() {

            this.uuidid = Date.now()
        },
        getDiscord(val) {
            if (val == null) {
                this.playerDiscordImg = './images/pp.png'
            } else {
                this.playerDiscordImg = val
            }
        },
        GetNewData(val) {

            this.getNewCraftData = val;
            this.UpdateTimesCraft();
        },
        crafItemClick(time, uniqeid) {
            if (!this.timeout && this.cacheUniqeId != uniqeid) {
              this.cacheUniqeId = uniqeid;
              this.timeout = true;
          
              if (time < 0) {
                $.post(`https://${this.resourceName}/claimItem`, JSON.stringify({
                  uniqeid: uniqeid
                }), () => {
                  this.cacheUniqeId = null;
                  setTimeout(() => {
                    this.timeout = false;
                  }, 500);
                });
              } else {
                this.cacheUniqeId = null;
                setTimeout(() => {
                  this.timeout = false;
                }, 500);
              }
            }
        },
        GetCraftables(value) {
            this.craftItems = value;
        },

        itemShowFunc() {
            clicksound()
            this.itemShow = false;
            this.craftDeatilText = false;
            this.enoughBehavior = false;
        },

        newButton(val, val2) {
            clicksound()
            this.backgroundimage = val2;
            this.itemShow = false;
            this.selectbutton = val;
            this.mainPage = val;
            this.craftDeatilText = false;
            this.enoughBehavior = false;
            
            if(val == 'weapons'){
                this.categoryText = this.languages['weaponsblueprint']
            }else if(val == 'ammo'){
                this.categoryText = this.languages['ammoblueprint']
            }else if(val == 'tools'){
                this.categoryText =  this.languages['toolsblueprint']
            }
        },
        GetCategories(val) {

            this.categories = val;

        },
        GetResponse(resourceName) {
            this.resourceName = resourceName
            $.post(`https://${
                this.resourceName
            }/GetResponse`, JSON.stringify({}));

        },
        UpdateTimesCraft: function() {
            var startDate = new Date()

            if (this.getNewCraftData) {
                this.getNewCraftData.forEach((item, index) => {
                    item.completed = false;
                    
                    let seconds = item.itemtime - startDate.getTime() / 1000;
                    if (seconds <= 0) {
                        item.completed = true;
                    }
                    this.getNewCraftData[index].displayTimeCraft = this.toHHMMSScraft(seconds);
                    this.getNewCraftData[index].seconds = seconds;
                })

            }


        },
        toHHMMSScraft: function(secs) {
            var sec_num = parseInt(secs, 10);
            var hours = Math.floor(sec_num / 3600);
            var minutes = Math.floor(sec_num / 60) % 60;
            var seconds = sec_num % 60;

            return [hours, minutes, seconds]
                .map((v) => (v < 10 ? "0" + v : v))
                .filter((v, i) => v !== "00" || i > 0)
                .join(":");
        },
        setupAchievementsSwiper() {
            if (this.achievementsSwiper) {
                this.achievementsSwiper.destroy()
            }
            Vue.nextTick(() => {
                this.achievementsSwiper = new Swiper('.mySwiper', {
                    cssMode: true,
                        navigation: {
                          nextEl: ".swiper-button-next",
                          prevEl: ".swiper-button-prev",
                        },
                        pagination: {
                          el: ".swiper-pagination",
                        },
                        mousewheel: true,
                        keyboard: true,

                });


            })

        },
        craftSelectItems() {
            if(!this.timeoutCraftButton) {
                this.timeoutCraftButton = true;
                clicksound()
                this.itemShow = false
                this.getUid()
                $.post(`https://${this.resourceName}/craftItems`, JSON.stringify({
                    item: this.requiredItems,
                    itemname: this.lastCraftItemName,
                    itemlabel: this.lastCraftItemLabel,
                    itemtime: this.lastCraftItemTime,
                    uniqeid: this.uuidid,
                    weaponitem: this.weaponitem,
                    weaponammo: this.weaponammo,
                    itemxp: this.lastCraftItemXp,
                    itemcategory : this.lastCraftItemCategory,
                    itemamount : this.lastitemamount
                }));
                this.craftDeatilText = false;
            }


            setTimeout(() => {
                this.timeoutCraftButton = false;
            }, 300)
        },

        setItem(name, label, reqItem, time, itemlevel, playerlevel, xp,categories,weaponitem,weaponammo,itemamount) {
           
            if (playerlevel >= itemlevel) {
                this.itemShow = true;
                this.requiredItems = [];
                this.selectCraftItem = [];
                this.lastCraftItemName = name;
                this.lastitemamount = itemamount;
                this.weaponitem = weaponitem;
                this.weaponammo = weaponammo;
                this.lastCraftItemLabel = label;
                this.lastCraftItemXp = xp;
                this.lastCraftItemTime = time;
                this.lastCraftItemCategory = categories;
                this.lastCraftItemLevel = itemlevel;
                this.enoughBehavior = true;
                this.craftDeatilText = true;
                if (this.playerItems) {
                    this.selectCraftItem.push({
                        name: name,
                        label: label,
                        reqItem: reqItem,
                        reqTime: time
                    })
                    this.selectCraftItem.forEach(element => {
                        const {
                            name,
                            label,
                            reqItem,
                            ...rest
                        } = element
                        reqItem.forEach(item => {
        
                            const founded = this.playerItems.find(playeritem => playeritem.name === item.name)
                            if (founded) {
                                if (founded.count) {
                                    this.requiredItems.push({
                                        inventorycount: founded.count,
                                        inventoryname: founded.name,
                                        count: item.count,
                                        label: item.label
                                    })   

                                    for (let index = 0; index < this.requiredItems.length; index++) {
                                        const data = this.requiredItems[index]
                                        if (data.inventorycount < data.count) {
                                            this.enoughBehavior = false;
                                            break;
                                        }
                                    }


                                } else {
                                    this.requiredItems.push({
                                        inventorycount: founded.amount,
                                        inventoryname: founded.name,
                                        count: item.count,
                                        label: item.label
                                    })    
                                    
                                    for (let index = 0; index < this.requiredItems.length; index++) {
                                        const data = this.requiredItems[index]
                                        if (data.inventorycount < data.count) {
                                            this.enoughBehavior = false;
                                            break;
                                        }
                                    }
                                }
                            } else {
                                this.enoughBehavior = false;
                                this.requiredItems.push({
                                    inventorycount: 0,
                                    inventoryname: item.name,
                                    count: item.count,
                                    label: item.label
                                })
                            }
                        });
                    });
                }
            }
        }
    }
})