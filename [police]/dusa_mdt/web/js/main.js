let criminalP
let config

function status(rate, type) {
  if (type == "install") {
    const criminal = new ProgressBar.Circle("#criminal", {
      color: "#0075FF",
      strokeWidth: 6,
      trailColor: "#D9D9D912",
      trailWidth: 6,
      duration: 2000, // milliseconds
      easing: "easeInOut",
    })
    criminalP = criminal
    criminal.animate(rate / 100)
  }
  if (type == "update") {
    criminalP.animate(rate / 100)
  }
}

const center_x = 117.3
const center_y = 172.8
const scale_x = 0.02072
const scale_y = 0.0205
var mymap
var markers = []
var SateliteStyle = L.tileLayer("mapStyles/styleSatelite/{z}/{x}/{y}.jpg", {
  noWrap: true,
  continuousWorld: false,
  attribution: "Dusa Map",
  id: "SateliteStyle map",
})
var southWest = L.latLng(-5000, -6500) // Example Southwest corner
var northEast = L.latLng(9000, 7500) // Example Northeast corner
var bounds = L.latLngBounds(southWest, northEast)
const blueIcon = L.divIcon({
  className: "custom-div-icon",
  html: "<div id='custom-marker' style='width: 25px; height: 25px; background-color: #0075FF; border-radius: 50%;'></div>",
  iconSize: [30, 30],
})
const redIcon = L.divIcon({
  className: "custom-div-icon",
  html: "<div id='custom-marker' style='width: 25px; height: 25px; background-color: #FF3667; border-radius: 50%;'></div>",
  iconSize: [30, 30],
})
var customOptions = {
  className: "custom",
}

function installMap() {
  CUSTOM_CRS = L.extend({}, L.CRS.Simple, {
    projection: L.Projection.LonLat,
    scale: function (zoom) {
      return Math.pow(2, zoom)
    },
    zoom: function (sc) {
      return Math.log(sc) / 0.6931471805599453
    },
    distance: function (pos1, pos2) {
      var x_difference = pos2.lng - pos1.lng
      var y_difference = pos2.lat - pos1.lat
      return Math.sqrt(x_difference * x_difference + y_difference * y_difference)
    },
    transformation: new L.Transformation(scale_x, center_x, -scale_y, center_y),
    infinite: true,
  })
  mymap = L.map("map", {
    crs: CUSTOM_CRS,
    minZoom: 3,
    maxZoom: 5,
    Zoom: 5,
    maxBounds: bounds,
    maxNativeZoom: 5,
    preferCanvas: true,
    attributionControl: false,
    layers: [SateliteStyle],
    center: [0, 0],
    zoom: 4,
  })
}

function getPopupContent(name, rank, type) {
  var customPopup = `<div class="pop-up ${type == redIcon ? "pop-up-border" : ""}">
  <div class="pop-up-left">
  <img src="assets/img/mdt/pop-up.png" alt="img" />
  </div>
  <div class="pop-up-right">
  <h1>${name}</h1>
  <p>${rank}</p>
  </div>
  </div>`
  return customPopup
}

function newMarker(x, y, citizen, name, rank, type = blueIcon) {
  const findIndex = markers.findIndex((m) => m.citizen === citizen)
  if (findIndex !== -1) {
    const prevMarker = markers[findIndex]
    prevMarker.marker.remove()
    markers.splice(findIndex, 1)
  }

  const customPopup = getPopupContent(name, rank, type)
  const marker = L.marker([x, y], { icon: type }).bindPopup(customPopup, customOptions).addTo(mymap)
  markers.push({ x: x, y: y, citizen: citizen, marker: marker })
}

function deleteMarker(citizen) {
  const findIndex = markers.findIndex((m) => m.citizen === citizen)
  if (findIndex !== -1) {
    const prevMarker = markers[findIndex]
    prevMarker.marker.remove()
    markers.splice(findIndex, 1)
  }
}

updateMarketCoordinates = (x, y, citizen) => {
  const findIndex = markers.findIndex((m) => m.citizen === citizen)
  if (findIndex !== -1) {
    const prevMarker = markers[findIndex]
    prevMarker.marker.setLatLng([x, y])
  }
}

let isRunning = false;

function post(event, data) {
  if (isRunning) return;
  isRunning = true;
  var xhr = new XMLHttpRequest();
  xhr.open("POST", "https://dusa_mdt/" + event);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
    }
  };
  xhr.send(JSON.stringify(data));
  isRunning = false;
}

// en.json dosyasının içindeki veriyi bir değişkene ata


const app = new Vue({
  el: "#app",
  data: {
    framework: 'qb',
    info: {
      policeMdt: "Police MDT",
      welcomeMessage: "Welcome to the MDT",
      dashboard: "Dashboard",
      citizensList: "Citizens List",
      wanted: "Wanted",
      cars: "Vehicles",
      incidents: "Incidents",
      chargesEvidence: "Evidence",
      chargesUser: "Charges User",
      houses: "Houses",
      fines: "Fines",
      giveLicanse: "Give License",
      licanses: "Licanse",
      licanse: "Licanse",
      cameras: "Cameras",
      cameraHacked: "Camera Hacked",
      liveMap: "Live Map",
      activeInactivePolice: "Officer List",
      form: "Form",
      select: "Select",
      commands: "Commands",
      settings: "Settings",
      mdtGuideTitle: "Need help for MDT ?",
      mdtGuideDesc: "Please check youtube video",
      mdtGuideButton: "Click here",
      todayCrimes: "Today crimes",
      activePolice: "Active police",
      emergencyAlert: "Emergency alert",
      c: "C",
      p: "P",
      e: "E",
      safe: "Safe",
      leery: "Leery",
      danger: "Danger",
      welcome: "Welcome",
      welcomeText: "Glad to see you again! Ask me anything..",
      circle: "Criminal Capture Rate",
      circleText: "For All Time",
      succesRate: "Succes Rate",
      graphic: "By crime types",
      graphicText: "For All Time",
      reply: "Reply...",
      notWanted: "Not Wanted",
      wantedList: "Wanted List",
      forAllTime: "For All Time",
      createWanted: "Create Wanted",
      pastCrimes: "Past Crimes",
      crimes: "Crimes",
      reports: "Reports",
      createdBy: "Created by",
      addReport: "Add Report",
      evidences: "Evidences",
      caught: "Caught",
      cameraActive: "Camera Active",
      cameraPassive: "Camera Passive",
      name: "Name",
      code: "Code",
      status: "Status",
      detail: "Detail",
      house: "House",
      car: "Car",
      carInfo: "Car Info",
      carOwner: "Car Owner",
      telephone: "Phone Number",
      job: "Job",
      dateofbirth: "Date of Birth",
      gender: "Gender",
      rank: "Rank",
      crime: "Crime",
      note: "Note",
      notes: "Notes",
      writeYourNote: "Write your note",
      addNote: "Add Note",
      commandList: "Command List",
      citizenList: "Citizen List",
      createCommand: "Create Command",
      searchCommand: "Search Command",
      markAsWanted: "Mark as Wanted",
      guiltyPerson: "Wanted Citizen",
      orospuMert: "Latest Crimes",
      unWanted: "Unwanted",
      commandCode: "Command Code",
      commandCreateDate: "Command Create Date",
      commandCreator: "Command Creator",
      commandDescription: "Command Description",
      createForm: "Create Form",
      forms: "Forms",
      formTitle: "Form Title",
      formDescription: "Form Description",
      createForm: "Create Form",
      save: "Save",
      delete: "Delete",
      online: "Online",
      offline: "Offline",
      selecet: "Select",
      searchFines: "Search Fines",
      finesList: "Fines List",
      createFine: "Create Fine",
      fineName: "Fine Name",
      fineCode: "Fine Code",
      finePrice: "Fine Price",
      searchUserList: "Search User List",
      allCars: "All Cars",
      searchAllCars: "Search All Cars",
      searchWantedCars: "Search Wanted Cars",
      wantedCars: "Wanted Cars",
      carName: "Car Name",
      carPlate: "Car Plate",
      carOwner: "Car Owner",
      newCrime: "New Crime",
      carCrime: "Car Crime",
      wantedCar: "Wanted Car",
      caughtCar: "Caught Car",
      writeYourCrime: "Write your crime",
      houseList: "House List",
      searchHouseList: "Search House List",
      houseInfo: "House Info",
      houseOwner: "House Owner",
      houseName: "House Name",
      houseAddress: "House Address",
      giveLicansePermit: "Give a License/Permit",
      searchLicanseList: "Search License List",
      writeLicanse: "Write License",
      liveMap: "Live Map",
      alerts: "Alerts",
      alert: "Alert",
      alertCoordinate: "Alert Coordinate",
      sendAlert: "Send a Alert",
      alertName: "Alert Name",
      alertDetail: "Alert Detail",
      writeAlertName: "Write Alert Name",
      writeAlertDetail: "Write Alert Detail",
      createAlert: "Create Alert",
      incidentsList: "Incidents List",
      createIncident: "Create Incident",
      searchIndicent: "Search Incident",
      incidentsName: "Incident Name",
      incidentsDescription: "Incident Description",
      addImage: "Add Image",
      addLink: "Add Link",
      screenShot: "Screen Shot",
      takeScreenShot: "Take Screen Shot",
      imageLink: "Image Link",
      addImage: "Add Image",
      deleteIncidents: "Delete Incidents",
      createIncidents: "Create Incidents",
      evidenceList: "Evidence List",
      createEvidence: "Create Evidence",
      chargesUserDesc: "You can create a charge for a user",
      userList: "User List",
      chargesUserListDesc: "You can select a user and fine them",
      issueaFine: "Issue a Fine",
      sendToJail: "Send to Jail",
      imposeaPublicFine: "Send to Community Service",
      jailReason: "Jail Reason",
      writeJailReason: "Write Jail Reason",
      writeJailTime: "Write Jail Time",
      minutes: "Minute",
      hours: "Hour",
      days: "Day",
      jail: "Jail",
      public: "Public",
      money: "Money",
      jailTime: "Jail Time",
      publicAmount: "Public Amount",
      crimeDeleted: "Crime deleted",
      crimeReason: "Crime Reason",
      writeCrimeReason: "Write Crime Reason",
      writeCrimePrice: "Write Crime Price",
      crimePrice: "Crime Price",
      sendToCrime: "Send to Crime",
      writePublicReason: "Write Public Reason",
      publicReason: "Public Reason",
      writePublicAmount: "Write Public Amount",
      sendToPublic: "Send to Public",
      searchEvidence: "Search Evidence",
      evidenceName: "Evidence Name",
      evidenceDescription: "Evidence Description",
      deleteEvidence: "Delete Evidence",
      createEvidence: "Create Evidence",
      setTheme: "Set a Theme",
      themeDesc: "You can change theme from here",
      userCitizen: "User Citizen",
      bluetheme: "Blue Theme",
      redtheme: "Red Theme",
      purpletheme: "Purple Theme",
      orangetheme: "Orange Theme",
      aquatheme: "Aqua Theme",
      greentheme: "Green Theme",
      whitetheme: "White Theme",
      blacktheme: "Black Theme",
      setLanguage: "Set a Language",
      languageDesc: "You can change language from here",
      warning: "ERROR",
      info: "INFO",
      success: "SUCCESS",
      fineDeleted: "Fine deleted",
      noteDeleted: "Note has been deleted.",
      addedWanted: "Player has been added to the wanted list.",
      camHacked: "HACKED",
      bolos: "Bolos",
      boloCitizenName: "Citizen Name (Optional)",
      reportsList: "Reports List",
      searchReports: "Search Reports",
      createReport: "Create Report",
      location: "Location",
      locationName: "Location Name",
      writeLocationName: "Write Location Name",
      description: "Description",
      writeDescription: "Write Description",
      traffic: "Traffic",
      arrest: "Arrest",
      incident: "Incident",
      bolosList: "Bolos List",
      searchBolos: "Search Bolos",
      createBolos: "Create Bolos",
      boloName: "Bolo Name",
      personelDef: "Personal Definition",
      carDef: "Vehicle Definition",
      eventDef: "Event Definition",
      writeBoloName: "Write Bolo Name",
      writePersonelDef: "Write Personal Definition",
      writeCarDef: "Write Vehicle Definition",
      writeEventDef: "Write Event Definition",
      writePlate: "Write Plate",
      writeName: "Write Name",
      createBolos: "Create Bolos",
      plate: "Plate (Optional)",
      personel: "Personel",
      other: "Other",
      noDef: "Not Specified",
      dispatch: "Dispatch",
      markLocation: "Mark Location",
      deleteFromList: "Delete From List",
      // Yeni Eklendi
      excel: "Excel",
      excelHeader: "Excel Table",
      excelDesc: "General Department Document",
      serialNumber: "Serial Number",
      gunList: "Gun List",
      searchGunList: "Search Gun List",
      fingerPrintList: "Finger Print List",
      searchFingerList: "Search Finger Print List",
      serialNo: "Serial No",
      owner: "Owner",
      details: "Details",
      fingerPrintNo: "Finger Print No",

      enterDuty: "Enter Duty",
      exitDuty: "Exit Duty",
      dutyOn: "You are now on duty",
      dutyOff: "You are now off duty",

      commandcreated: "New command created successfully.",
      commandremoved: "Command removed from list.",
      formcreated: "New form created successfully.",
      formremoved: "Form removed from list.",
      nametooshort: "User name must be at least 3 characters.",
      alreadysearcheduser: "You have already searched for this user.",
      platetooshort: "Plate must be at least 3 characters.",
      alreadysearchedplate: "You have already searched for this plate.",
      vehiclewanted: "Vehicle has been added to the wanted list.",
      vehicleremovedwanted: "Vehicle has been removed from the wanted list.",
      revokedlicense: "License has been revoked.",
      grantedlicense: "License has been granted.",
      alertnotified: "Your new alert has been notified to the officers on duty.",
      alertremoved: "Created alert removed successfully.",
      incidentremoved: "Incident removed from list.",
      incidentcreated: "New incident created successfully.",
      evidenceremoved: "Evidence removed from list.",
      evidencecreated: "New evidence created successfully.",
      sentToJail: "User has been sent to jail.",
      issuedCharge: "Charge has been issued to the user.",
      sentToPublic: "User has been sent to community service.",
      serialTooShort: "Serial number must be at least 3 characters.",
      alreadySearchedSerial: "You have already searched for this serial number.",
      serialNotFound: "Serial number not found.",
      fingerprintTooShort: "Finger print number must be at least 3 characters.",
      alreadySearchedFingerprint: "You have already searched for this finger print number.",
      fingerprintNotFound: "Finger print number not found.",
      themeSetTo: "Theme has been set to",
    },
    notifyDelay: 5000,
    camera: {
      enabled: false,
      hacked: false,
      camName: "Camera 1",
    },
    mdt: {
      enabled: false,
      profil: {
        name: "John Doe",
        rank: "Cadet",
        img: "https://source.unsplash.com/random/500x500?sig=1",
        citizen: "313131",
      },
      headerInfo: {
        crimes: 50,
        activePolice: 232,
        emergency: "Safe",
      },
      crimesGraphicList: [],
      crimesList: [
        // { name: "Robbery", amount: 402, code: "R1-135", id: "KDJGJWUIJ13", price: 5500, selecet: false },
        // { name: "Murder", amount: 302, code: "R2-235", id: "KDJGJWUIJ14", price: 6000, selecet: false },
        // { name: "Stealing a Vehicle", amount: 202, code: "A01-3051", id: "KDJGJWUIJ15", price: 1000, selecet: false },
        // { name: "Money Laundering", amount: 412, code: "M41-005", id: "KDJGJWUIJ16", price: 2000, selecet: false },
        // { name: "Insult", amount: 870, code: "I31-3131", id: "KDJGJWUIJ17", price: 3000, selecet: false },
      ],
      userList: [],
      citizenList: [],
      carsList: [],
      housesList: [],
      languageList: [
        { code: "af", name: "Afrikaans" },
        { code: "bg", name: "Bulgarian" },
        { code: "da", name: "Danish" },
        { code: "de", name: "German" },
        { code: "el", name: "Greek" },
        { code: "en", name: "English" },
        { code: "es", name: "Spanish" },
        { code: "et", name: "Estonian" },
        { code: "fi", name: "Finnish" },
        { code: "fr", name: "French" },
        { code: "hu", name: "Hungarian" },
        { code: "it", name: "Italian" },
        { code: "lb", name: "Luxembourgish" },
        { code: "lt", name: "Lithuanian" },
        { code: "pl", name: "Polish" },
        { code: "pt", name: "Portuguese" },
        { code: "ro", name: "Romanian" },
        { code: "ru", name: "Russian" },
        { code: "sr", name: "Serbian" },
        { code: "sv", name: "Swedish" },
        { code: "tr", name: "Turkish" },
        { code: "zh", name: "Chinese" },
      ],
      messageList: [],
      camerasList: [],
      commandsList: [
      ],
      policeList: [],
      formsList: [],
      alertList: [],
      incidentsList: [],
      evidencesList: [],
      licanseList:[],
      nearList: [],
      // Yeni eklendi
      bolosList: [
        {
          boloName: "Bolo 1",
          name: "Test 1",
          personDefinition: "Lorem ipsum dolar ssit kasdlşas asdklşas",
          eventDefinition: "Lorem ipsum dolar ssit kasdlşas asdklşas",
          plate: "",
          carDefinition: "",
          boloType: "personel",
          showId: "AD57",
          id: "JKFUAJ831",
          citizen: "4814951",
          active: false,
        },
        {
          boloName: "Bolo 2",
          name: "",
          personDefinition: "",
          eventDefinition: "Lorem ipsum dolar ssit kasdlşas asdklşas",
          plate: "AD-314",
          carDefinition: "Lorem ipsum dolar ssit kasdlşas asdklşas",
          boloType: "car",
          showId: "AD58",
          id: "JKFUAJ8390",
          citizen: "4814951",
          active: false,
        },
        {
          boloName: "Bolo 3",
          name: "",
          personDefinition: "",
          eventDefinition:
            "Lorem ipsum dolar ssit kasdlşas asdklşas Lorem ipsum dolar ssit kasdlşas asdklşas Lorem ipsum dolar ssit kasdlşas asdklşas Lorem ipsum dolar ssit kasdlşas asdklşas Lorem ipsum dolar ssit kasdlşas asdklşas",
          plate: "",
          carDefinition: "",
          boloType: "other",
          showId: "AD59",
          id: "JKFUAJ83320",
          citizen: "4814951",
          active: false,
        },
      ],
      reportList:[
        {
          id: "JKFUAJ8131",
          name: "Test 1",
          user: "John Doe",
          userRank: "Cadet",
          citizen: "4814951",
          description: "Lorem ipsum dolar ssit kasdlşas asdklşas",
          locationName: "Los Santos 1",
          location: "09123909431",
          type: "traffic",
          active: false,
        },
        {
          id: "JKFUAJ8531",
          name: "Test 2",
          user: "John Doe",
          userRank: "Cadet",
          citizen: "4814951",
          description: "Lorem ipsum dolar ssit kasdlşas asdklşas",
          locationName: "Los Santos 1",
          location: "09123909431",
          type: "arrest",
          active: false,
        },
        {
          id: "JKFUAJ8t31",
          name: "Test 3",
          user: "John Doe",
          userRank: "Cadet",
          citizen: "4814951",
          description: "Lorem ipsum dolar ssit kasdlşas asdklşas",
          locationName: "Los Santos 1",
          location: "09123909431",
          type: "crime",
          active: false,
        },
        {
          id: "JKFUAJ83d1",
          name: "Test 4",
          user: "John Doe",
          userRank: "Cadet",
          citizen: "4814951",
          description: "Lorem ipsum dolar ssit kasdlşas asdklşas",
          locationName: "Los Santos 1",
          location: "09123909431",
          type: "incident",
          active: false,
        },
      ],
      dispatchList:[
      ],
      // Yeni eklendi
      gunList:[
        // {
        //   serialNumber: "JFGUJEI18",
        //   model: "Glock 19",
        //   img:"",
        //   owner: "John Doe",
        //   citizenId: "4814951",
        //   ownerImage: "https://cdn-icons-png.flaticon.com/512/456/456283.png",
        //   infoList:[
        //     {
        //       label: "durability",
        //       value: "50/100",
        //     },
        //     {
        //       label: "licanse",
        //       value: "Yes",
        //     }
        //   ],
        //   selected: false,
        // },
      ],
      fingerList: [
        // {
        //   fingerNo: "1",
        //   owner: "John Doe",
        //   citizenId: "4814951",
        //   ownerImage: "./assets/img/mdt/default.png",
        //   infoList:[
        //     {
        //       label: "durability",
        //       value: "50/100",
        //     },
        //     {
        //       label: "licanse",
        //       value: "Yes",
        //     },
        //   ],
        //   selected: false,
        // },
      ],
      searchGunList: "",
      searchFingerList: "",
      serialNumberTypes: "",
      serialNumberActive: "",
      serialNumberDetail: false,
      //-----------------------------------------
      dispatchDeleteTime: 30, // 30 dk geçtiyse siler
      searchReports: "",
      reportsDetail: "",
      reportsDetails: false,
      reportsNew: true,
      reportsName: "",
      reportsDesc: "",
      reporstLoaction: "",
      reportsType: "traffic",
      bolosSearch: "",
      bolosDetail: "",
      bolosDetails: false,
      bolosNew: true,
      bolosName: "",
      bolosUser: "",
      bolosPersonDefinition: "",
      bolosEventDefinition: "",
      bolosCarDefinition: "",
      bolosPlate: "",
      bolosType: "personel",
      // --------------------------------
      alertMenu: false,
      incidentsSearch: "",
      incidentsDetail: "",
      incidentsDetails: false,
      incidentsUserSearch: "",
      incidentsNew: false,
      incidentsName: "",
      incidentsDesc: "",
      incidentsImg: [],
      incidentsImgLink: "",
      incidentsUserSearchNew: "",
      incidentsImgMenu: "screenShot",
      incidentsAddedCitizen: [],
      evidencesSearch: "",
      evidencesDetail: "",
      evidencesDetails: false,
      evidencesUserSearch: "",
      evidencesNew: false,
      evidencesName: "",
      evidencesDesc: "",
      evidencesImg: [],
      evidencesImgLink: "",
      evidencesUserSearchNew: "",
      evidencesImgMenu: "screenShot",
      evidencesAddedCitizen: [],
      userSearch: "",
      userDetail: "",
      userDetails: false,
      licanseSearch: "",
      licanseAdd: "",
      wantedDetail: "",
      wantedDetails: false,
      wantedAddCrimes: false,
      wantedAddCrimesValue: "",
      carsAllSearch: "",
      carsWantedSearch: "",
      carDetail: "",
      carDetailCitizen: "",
      carDetails: false,
      houseSearch: "",
      houseDetail: "",
      houseDetails: false,
      houseCitizen: "",
      commandDetail: "",
      commandDetails: false,
      commandSearch: "",
      commandEdit: false,
      commandEditValue: "",
      commandEditDesc: "",
      commandEditDescs: false,
      newCommandDesc: "",
      newCommands: true,
      newCommand: "",
      crimeSearch: "",
      crimeDetail: "",
      crimeDetails: false,
      crimeEditCodes: false,
      crimeEditCode: "",
      crimeEditName: "",
      crimeEditNames: false,
      crimeEditPrice: null,
      crimeEditPrices: false,
      newCrimeCode: "",
      newCrimeName: "",
      
      newCrimePrice: null,
      // NEW
      newCrimeType: "money",
      newCrimePublicAmount: "",
      newCrimeJailTime: "",
      newCrimeJailTimeType: "minute",

      newCrimes: false,
      firsInstallMap: false,
      newMessage: "",
      activePoliceDetails: false,
      activePoliceDetail: "313131",
      alertTitle: "",
      alertDetail: "",
      formTitle: "",
      formDesc: "",
      formRouter: "viewForm",
      // NEW
      formDetail: "",

      chargesUserSearch: "",
      chargesUserCitizen: "",
      jailReason: "",
      jailTime: "",
      jailTimeType: "minute",
      crimeReason: "",
      crimePrice: "",
      publicReason: "",
      publicAmount: "",
      chargesRouter: "criminal", //criminal, prison, public
      criminalCaptureRate: 80,
      mdtRouter: "dashboard",
      mdtLanguage: "en",
      themeMode: "blue",
      defaultTheme: "blue",
      grade: 0,
      permissions: {
        incident: 0,
        evidence: 0,
        chargeuser: 0,
        commands: 0,
        fines: 0,
        forms: 0,
        givelicense: 0,
      },
      enable: {
        communityservice: true,
        jail: true,
        fine: true,
      },
      // Yeni Eklendi
      duty: false,
      excelLink: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQPR5IJ70E_cGsIHyuoZbBwx3ZtQaljMiU2aYRtxWUR0xR94pM4cwKATcfEKgHIVGgiARRY8doVoao0/pubhtml",
      //--------------------------------
    },
  },

  mounted() {
    status(this.mdt.criminalCaptureRate, "install")

    let messageList = document.querySelector(".chat-screen")
    messageList.scrollTop = messageList.scrollHeight

    // top 5 crimes push to graphic
    this.mdt.crimesList.sort((a, b) => (a.amount < b.amount ? 1 : -1))
    let crimeLenght = this.mdt.crimesList.length
    let dashboardLength = crimeLenght > 5 ? 5 : crimeLenght
    for (let i = 0; i < dashboardLength; i++) {
      this.mdt.crimesGraphicList.push(this.mdt.crimesList[i])
    }

    document.addEventListener("keydown", function(event) {
      if (event.key === "Escape") {
        post("updateSettings", {language: app.mdt.mdtLanguage, theme: app.mdt.themeMode})
        post("close")
        app.mdt.enabled = false;
      }
    });

    setInterval(this.updateNotifications, 1800000)

    setTimeout(() => {
      this.notify("success", this.info.welcomeMessage)
    }, 1000)
  },
  methods: {
    // Fivem

    checkImage(url) {
      return new Promise((resolve, reject) => {
      var request = new XMLHttpRequest();
      request.open("GET", url, true);
      request.send();
      request.onload = function() {
        if (request.status === 200) {
        resolve(true);
        } else {
        resolve(false);
        }
      }
      request.onerror = function() {
        resolve(false);
      }
      });
    },
    setup(type, data) {
      // give me switch case example for type variable
      switch (type) {
        case "profile":
          this.mdt.profil = {
            name: data.name,
            rank: data.rank.charAt(0).toUpperCase() + data.rank.slice(1),
            img: data.gender == 0 ? "assets/img/mdt/police_m.png" : "assets/img/mdt/police_f.png",
            citizen: data.citizen
          };
          break
        case "grade":
          fetch(`https://dusa_mdt/getGrade`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({})
          })
          .then((grade) => grade.json())
          .then((grade) => {
            this.mdt.grade = grade
          });
          break
        case "dispatch":
          fetch(`https://dusa_mdt/getDispatch`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({})
          })
          .then((dispatch) => dispatch.json())
          .then((dispatch) => {
            if (dispatch === false) {
              return;
            }
            if (typeof dispatch === "string") { dispatch = JSON.parse(dispatch); }
            dispatch.forEach((alert) => {
              let check = this.checkBeforePush(alert);
              if (check === false) return;
              alert.time = Date.now()
              if (!this.mdt.dispatchList.some((item) => item.id === alert.id)) {
                this.mdt.dispatchList.push({
                  id: alert.id,
                  gameId: alert.gameId,
                  code: alert.code,
                  menu: false,
                  iconList: alert.iconList,
                  location: alert.location,
                  time: alert.time,
                  img: alert.img,
                  message: alert.message,
                  imgOpen: false,
                });
              }
            })
          });
          break
        case "settings":
          let settings = data[0]
          if (!settings) {this.mdt.themeMode = this.mdt.defaultTheme; this.changeTheme(this.mdt.themeMode, true); return} ;
          this.mdt.themeMode = settings.theme
          this.mdt.mdtLanguage = settings.language
          this.changeTheme(this.mdt.themeMode, true)

          setTimeout(() => {
            fetch(`./locales/${this.mdt.mdtLanguage}.json`)
            .then((response) => response.json())
            .then((langdata) => {
              for (let key in langdata) {
                this.info[key] = langdata[key];
              }
            })
          }, 1000)
          break
        case "camera":
          this.mdt.camerasList = [];
          data.forEach((camera) => {
            let check = this.checkBeforePush(camera);
            if (check === false) return;
            let showImage = "./assets/img/mdt/no-image.png";
            this.checkImage(camera.img).then(result => {
              showImage = result ? camera.img : "./assets/img/mdt/no-image.png";
            });
            setTimeout(() => {
              this.mdt.camerasList.push({ title: camera.title, location: camera.location, status: !camera.isDisabled, hacked: camera.isHacked, id: camera.id, img: showImage, coords: camera.coords })
            }, 1000)
          })
          break
        case "fines":
          this.mdt.crimesList = [];
          data.forEach((fine) => {
            let check = this.checkBeforePush(fine);
            if (check === false) return;
            if (typeof fine.data === "string") { fine.data = JSON.parse(fine.data); }

            this.mdt.crimesList.push({ id: fine.id, name: fine.name, code: fine.code, jailTime: fine.data.jailTime, jailTimeType: fine.data.jailTimeType, publicAmount: fine.data.publicAmount, price: fine.data.price, selecet: false })
          })
          break
        case "commands":
          this.mdt.commandsList = [];
          data.forEach((command) => {
            let check = this.checkBeforePush(command);
            if (check === false) return;
            this.mdt.commandsList.push({ id: command.command_id, code: command.code, date: command.date, userImage: command.userImage, user: command.user, description: command.description, selected: false })
          })
          break
        case "forms":
          this.mdt.formsList = [];
          data.forEach((form) => {
            let check = this.checkBeforePush(form);
            if (check === false) return;
            this.mdt.formsList.push({ id: form.id, time: form.time, date: form.date, user: form.user, title: form.title, description: form.description })
          })
          break
        case "bolos":
          this.mdt.bolosList = [];
          data.forEach((bolo) => {
            let check = this.checkBeforePush(bolo);
            if (check === false) return;
            this.mdt.bolosList.push({ 
              id: bolo.id,
              boloName: bolo.name_bolo || bolo.boloName, 
              citizen: bolo.citizen, 
              name: bolo.name, 
              personDefinition: bolo.definition_person || bolo.personDefinition, 
              eventDefinition: bolo.definition_event || bolo.eventDefinition, 
              plate: bolo.plate,
              carDefinition: bolo.definition_car || bolo.carDefinition, 
              boloType: bolo.type || bolo.boloType, 
              showId: bolo.showId, 
              active: false
             })
          })
          break
        case "reports":
          this.mdt.reportList = [];
          data.forEach((report) => {
            let check = this.checkBeforePush(report);
            if (check === false) return;
            this.mdt.reportList.push({ 
              id: report.id,
              name: report.name,
              user: report.user,
              userRank: report.userRank,
              citizen: report.citizen,
              description: report.description,
              locationName: report.locationName,
              location: report.location,
              type: report.type,
              active: false,
             })
          })
          break
        case "incident":
          this.mdt.incidentsList = [];
          data.forEach((incident) => {
            let check = this.checkBeforePush(incident);
            if (check === false) return;
            const incexists = this.mdt.incidentsList.find((item) => item.id === incident.id);
            if (typeof incident.image === "string") { incident.image = JSON.parse(incident.image); }
            if (typeof incident.addedCitizen === "string") { incident.addedCitizen = JSON.parse(incident.addedCitizen); }
            incident.image.forEach((img, index) => {
              this.checkImage(img).then(result => {
                incident.image[index] = result ? img : "./assets/img/mdt/no-image.png";
              });
            });

            incident.userCitizen = incident.userCitizen || incident.citizenid;
            setTimeout(() => {
              if (!incexists) {
                this.mdt.incidentsList.push({ active: false, id: incident.id, name: incident.name, description: incident.description, userCitizen: incident.userCitizen, addedCitizen: incident.addedCitizen.length > 0 ? incident.addedCitizen : [], image: incident.image.length > 0 ? incident.image : []
                });
              }
            }, 1000)
          });
          break
        case "evidence":
          this.mdt.evidencesList = [];
          data.forEach((evidence) => {
            let check = this.checkBeforePush(evidence);
            if (check === false) return;
            const eviexists = this.mdt.evidencesList.find((item) => item.id === evidence.id);
            if (typeof evidence.image === "string") { evidence.image = JSON.parse(evidence.image); }
            if (typeof evidence.addedCitizen === "string") { evidence.addedCitizen = JSON.parse(evidence.addedCitizen); }
            evidence.image.forEach((img, index) => {
              this.checkImage(img).then(result => {
                evidence.image[index] = result ? img : "./assets/img/mdt/no-image.png";
              });
            });

            evidence.userCitizen = evidence.userCitizen || evidence.citizenid;
              setTimeout(() => {
              if (!eviexists) {
                this.mdt.evidencesList.push({ active: false, id: evidence.id, name: evidence.name, description: evidence.description, userCitizen: evidence.userCitizen, addedCitizen: evidence.addedCitizen.length > 0 ? evidence.addedCitizen : [], image: evidence.image.length > 0 ? evidence.image : []
                });
              }
            }, 1000)
          });
          break
        case "police":
          this.mdt.policeList = [];
          data.forEach((police) => {
            let check = this.checkBeforePush(police);
            if (check === false) return;
            const polexists = this.mdt.policeList.find((item) => item.citizen === police.citizen);
            if (!polexists) {
              this.mdt.policeList.push({ name: police.name, rank: police.rank, status: police.status, gender: police.gender === 0 ? "Male" : "Female", code: police.code, date: police.date, citizen: police.citizen });
            }
          });
          break
        case "house":
          this.mdt.housesList = [];
          if (data.length === 0) return
          data.forEach((house) => {
            let check = this.checkBeforePush(house);
            if (check === false) return;
            if (house.citizen === 0) return;
            this.mdt.housesList.push({ img: house.img, name: house.name, address: house.address, id: house.id, citizen: house.citizen, coords: house.coords, selected: false })
          });
          break
        case "license":
          this.mdt.licanseList = [];
          data.forEach((license) => {
            let check = this.checkBeforePush(license);
            if (check === false) return;
            this.mdt.licanseList.push({ type: license.type, name: license.name })
          });
          break
        case "vehicles":
          this.mdt.carsList = [];
          if (data.length === 0) return
          data.forEach((wantedCar) => {
            let check = this.checkBeforePush(wantedCar);
            if (check === false) return;
            let showImage = "./assets/img/mdt/no-image.png";
            let wikiImage = 'https://docs.fivem.net/vehicles/' + data.name + '.webp'

            if (wantedCar.wanted === "1") wantedCar.wanted = true;
            if (wantedCar.wanted === "0") wantedCar.wanted = false;

            this.checkImage(wikiImage).then(result => {
              showImage = result ? wikiImage : "./assets/img/mdt/no-image.png";
            });
            setTimeout(() => {
              this.mdt.carsList.push({
                plate: wantedCar.plate,
                citizen: wantedCar.citizenid,
                name: wantedCar.name,
                reports: wantedCar.reports,
                img: showImage,
                wanted: wantedCar.wanted,
                color: 'red',
                selected: false
              });
            }, 1000);
          });
          break
        case "users":
          // this.mdt.userList = [];
          data.forEach((user) => {
            let check = this.checkBeforePush(user);
            if (check === false) return;
            user.citizen = user.citizen || user.citizenid;
            if (typeof user.crimes === "string") { user.crimes = JSON.parse(user.crimes); }
            if (typeof user.pastcrimes === "string") { user.pastcrimes = JSON.parse(user.pastcrimes); }
            if (typeof user.notes === "string") { user.notes = JSON.parse(user.notes); }
            if (typeof user.reports === "string") { user.reports = JSON.parse(user.reports); }
            if (typeof user.cars === "string") { user.cars = JSON.parse(user.cars.value); }
            // let findUserList = this.mdt.userList.find((ply) => ply.citizen === user.citizen);
            let showImage = "./assets/img/mdt/default.png";
            let userImage = this.checkImage(user.userImage).then(result => {
              showImage = result ? user.userImage : "./assets/img/mdt/default.png";
            });
            // burası
            setTimeout(() => {
              if (!this.mdt.userList.some(a => a.citizen === user.citizen)) {
                this.mdt.userList.push({
                  user: user.user,
                  citizen: user.citizen,
                  userImage: showImage,
                  date: user.date,
                  telephone: user.telephone,
                  gender: user.gender,
                  job: user.job,
                  wanted: user.wanted,
                  caught: user.caught,
                  selected: false,
                  crimes: user.crimes.length > 0 ? user.crimes : [],
                  pastcrimes: user.pastcrimes.length > 0 ? user.pastcrimes : [],
                  notes: user.notes.length > 0 ? user.notes : [],
                  reports: user.reports.length > 0 ? user.reports : [],
                  cars: user.cars.length > 0 ? user.cars : [],
                  houses: user.houses,
                  licanse: user.licanse, 
                });
              }

            }, 1000)
          })
          this.updateGraphic()
          break
        case "nearby":
          this.mdt.nearList = []
          data.forEach((near) => {
            this.mdt.nearList.push({ 
              citizen: near.citizen,
              id: near.id, 
              active: false 
            })
          })
          break
        case "config":
          config = data
          for (const key in config.permissions) {
            this.mdt.permissions[key] = config.permissions[key];
          }
          for (const key in config.enable) {
            this.mdt.enable[key] = config.enable[key];
          }
          this.mdt.mdtLanguage = config.defaultlanguage
          this.mdt.excelLink = config.excelLink
          break
        default:
      }
    },

    openCamera(item) {
      this.camera.enabled = true
      this.camera.hacked = item.hacked 
      this.camera.camName = this.camera.hacked ? this.info.camHacked : item.title
      post('connectCam', item)
    },
    // Global Functions
    randomId() {
      let id = Math.random().toString(36).substr(2, 10)
      // return id uppercase
      return id.toUpperCase()
    },
    onBeforeEnter(el){
      el.style.opacity = 0
    },
    hiddenMdtCont(){
      const mdtCont = document.getElementById("mdtCont")
      gsap.to(mdtCont, { opacity: 0.3, duration: 0.3, ease: "power2.inOut" })
    },
    showMdtCont(){
      const mdtCont = document.getElementById("mdtCont")
      gsap.to(mdtCont, { opacity: 1, duration: 0.3, ease: "power2.inOut" })
    },
    onEnter(el, done){
      gsap.to(el, {opacity: 1, duration: 0.3, onComplete: done})
    },
    onLeave(el, done){
      gsap.to(el, {opacity: 0, duration: 0.3, onComplete: done})
    },
    playHackedVideo() {
      let video = document.getElementById("hacked-video")
      video.volume = 0.1
      video.play()
    },
    selectLanguage(lang){
      this.mdt.mdtLanguage = lang
    },
    changeTheme(option, hideNotify) {
      let tl = gsap.timeline({
        duration: 0.3,
        ease: "power2.inOut",
      })

      if(!hideNotify) this.notify("info", this.info.themeSetTo + " " + option);
      if (option == "red") {
        tl.to(
          "body",
          {
            "--background-componet": "linear-gradient(127deg, rgba(40, 5, 17, 0.94) 19.41%, rgba(34, 10, 17, 0.49) 76.65%)",
          },
          "start"
        )
          .to(
            "body",
            {
              "--background-router": "linear-gradient(112deg, rgba(38, 6, 17, 0.94) 59.3%, rgba(57, 28, 38, 0.00) 100%)",
            },
            "start"
          )
          .to(
            "body",
            {
              "--input-background": "linear-gradient(127deg, rgba(37, 6, 16, 0.74) 28.26%, rgba(55, 26, 36, 0.50) 91.2%)",
            },
            "start"
          )
          .to("body", { "--background-router-icon": "#351923" }, "start")
          .to("body", { "--background-fill": "#FF3667" }, "start")
          .to("body", { "--svg-fill": "#FF3667" }, "start")
        this.mdt.themeMode = "red"
      }
      if (option == "blue") {
        tl.to(
          "body",
          {
            "--background-componet": "linear-gradient(127deg, rgba(6, 11, 40, 0.94) 19.41%, rgba(10, 14, 35, 0.49) 76.65%)",
          },
          "start"
        )
          .to(
            "body",
            {
              "--background-router": "linear-gradient(112deg, rgba(6, 11, 38, 0.94) 59.3%, rgba(26, 31, 55, 0.00) 100%)",
            },
            "start"
          )
          .to(
            "body",
            {
              "--input-background": "linear-gradient(127deg, rgba(6, 11, 38, 0.74) 28.26%, rgba(26, 31, 55, 0.50) 91.2%)",
            },
            "start"
          )
          .to("body", { "--background-router-icon": "#1A1F37" }, "start")
          .to("body", { "--background-fill": "#0075FF" }, "start")
          .to("body", { "--svg-fill": "#0075FF" }, "start")
        this.mdt.themeMode = "blue"
      }
      if (option == "purple") {
        tl.to(
          "body",
          {
            "--background-componet": "linear-gradient(127deg, rgba(37, 5, 38, 0.94) 19.41%, rgba(39, 11, 40, 0.49) 76.65%)",
          },
          "start"
        )
          .to(
            "body",
            {
              "--background-router": "linear-gradient(112deg, rgba(42, 7, 43, 0.94) 59.3%, rgba(63, 31, 63, 0.00) 100%)",
            },
            "start"
          )
          .to(
            "body",
            {
              "--input-background": "linear-gradient(127deg, rgba(39, 6, 40, 0.74) 28.26%, rgba(56, 27, 57, 0.50) 91.2%)",
            },
            "start"
          )
          .to("body", { "--background-router-icon": "#1A1F37" }, "start")
          .to("body", { "--background-fill": "#F311F6" }, "start")
          .to("body", { "--svg-fill": "#F311F6" }, "start")
        this.mdt.themeMode = "purple"
      }
      if (option == "orange") {
        tl.to(
          "body",
          {
            "--background-componet": " linear-gradient(127deg, rgba(37, 24, 6, 0.94) 19.41%, rgba(44, 31, 13, 0.49) 76.65%)",
          },
          "start"
        )
          .to(
            "body",
            {
              "--background-router": "linear-gradient(112deg, rgba(51, 34, 9, 0.94) 59.3%, rgba(63, 31, 63, 0.00) 100%)",
            },
            "start"
          )
          .to(
            "body",
            {
              "--input-background": "linear-gradient(127deg, rgba(35, 23, 6, 0.74) 28.26%, rgba(62, 49, 31, 0.50) 91.2%)",
            },
            "start"
          )
          .to("body", { "--background-router-icon": "#1a1f3770" }, "start")
          .to("body", { "--background-fill": "#DC8B13" }, "start")
          .to("body", { "--svg-fill": "#DC8B13" }, "start")
        this.mdt.themeMode = "orange"
      }
      if (option == "aqua") {
        tl.to(
          "body",
          {
            "--background-componet": "linear-gradient(127deg, rgba(6, 39, 40, 0.94) 19.41%, rgba(13, 45, 46, 0.49) 76.65%)",
          },
          "start"
        )
          .to(
            "body",
            {
              "--background-router": "linear-gradient(112deg, rgba(9, 51, 52, 0.94) 59.3%, rgba(35, 70, 71, 0.00) 100%)",
            },
            "start"
          )
          .to(
            "body",
            {
              "--input-background": "linear-gradient(127deg, rgba(7, 42, 44, 0.74) 28.26%, rgba(28, 55, 57, 0.50) 91.2%)",
            },
            "start"
          )
          .to("body", { "--background-router-icon": "#1a1f3770" }, "start")
          .to("body", { "--background-fill": "#0AC5CC" }, "start")
          .to("body", { "--svg-fill": "#0AC5CC" }, "start")
        this.mdt.themeMode = "aqua"
      }
      if (option == "green") {
        tl.to(
          "body",
          {
            "--background-componet": "linear-gradient(127deg, rgba(7, 42, 25, 0.94) 19.41%, rgba(14, 49, 32, 0.49) 76.65%)",
          },
          "start"
        )
          .to(
            "body",
            {
              "--background-router": "linear-gradient(112deg, rgba(10, 56, 33, 0.94) 59.3%, rgba(35, 71, 54, 0.00) 100%)",
            },
            "start"
          )
          .to(
            "body",
            {
              "--input-background": "linear-gradient(127deg, rgba(6, 36, 22, 0.74) 28.26%, rgba(26, 53, 40, 0.50) 91.2%)",
            },
            "start"
          )
          .to("body", { "--background-router-icon": "#1a1f3770" }, "start")
          .to("body", { "--background-fill": "#0EE77D" }, "start")
          .to("body", { "--svg-fill": "#0EE77D" }, "start")
        this.mdt.themeMode = "green"
      }
      if (option == "white") {
        tl.to(
          "body",
          {
            "--background-componet": "linear-gradient(127deg, rgba(56, 58, 57, 0.94) 19.41%, rgba(52, 52, 52, 0.49) 76.65%)",
          },
          "start"
        )
          .to(
            "body",
            {
              "--background-router": "linear-gradient(112deg, rgba(48, 49, 48, 0.94) 59.3%, rgba(50, 51, 50, 0.00) 100%)",
            },
            "start"
          )
          .to(
            "body",
            {
              "--input-background": "linear-gradient(114deg, rgba(89, 89, 89, 0.74) 28.6%, rgba(44, 44, 44, 0.50) 82.69%)",
            },
            "start"
          )
          .to("body", { "--background-router-icon": "#1a1f3770" }, "start")
          .to("body", { "--background-fill": "#D2D2D2" }, "start")
          .to("body", { "--svg-fill": "#D2D2D2" }, "start")
        this.mdt.themeMode = "white"
      }
      if (option == "black") {
        tl.to(
          "body",
          {
            "--background-componet": "linear-gradient(127deg, rgba(0, 0, 0, 0.94) 19.41%, rgba(17, 17, 17, 0.49) 76.65%)",
          },
          "start"
        )
          .to(
            "body",
            {
              "--background-router": "linear-gradient(112deg, rgba(13, 13, 13, 0.94) 59.3%, rgba(0, 0, 0, 0.00) 100%)",
            },
            "start"
          )
          .to(
            "body",
            {
              "--input-background": "linear-gradient(127deg, rgba(40, 40, 40, 0.74) 28.26%, rgba(0, 0, 0, 0.50) 91.2%)",
            },
            "start"
          )
          .to("body", { "--background-router-icon": "#141414" }, "start")
          .to("body", { "--background-fill": "#292929" }, "start")
          .to("body", { "--svg-fill": "#D2D2D2" }, "start")
        this.mdt.themeMode = "black"
      }
    },
    getCrimes(code) {
      let data = []
      code.forEach((element) => {
        let index = this.mdt.crimesList.findIndex((x) => x.code === element)
        data.push(this.mdt.crimesList[index])
      })
      return data
    },
    getCrime(code) {
      let index = this.mdt.crimesList.findIndex((x) => x.code === code)
      if (index == -1) return {name: this.info.crimeDeleted}
      return this.mdt.crimesList[index]
    },
    updateGraphic() {
      this.mdt.crimesList.sort((a, b) => (a.amount < b.amount ? 1 : -1))
      this.mdt.crimesGraphicList = []
      let crimeLenght = this.mdt.crimesList.length
      let dashboardLength = crimeLenght > 5 ? 5 : crimeLenght
      for (let i = 0; i < dashboardLength; i++) {
        this.mdt.crimesGraphicList.push(this.mdt.crimesList[i])
        post('updateFine', this.mdt.crimesList[i])
      }
      // Today Crimes
      let total = this.mdt.crimesList.reduce((acc, crime) => acc + crime.amount, 0);
      this.mdt.headerInfo.crimes = total;

      // Progressbar
      // Get the users with wanted true
      const wantedUsers = this.mdt.userList.filter(user => user.wanted === true);
      const caughtUsers = this.mdt.userList.filter(user => user.caught === true);
      let caughtPercentage = (caughtUsers.length / wantedUsers.length) * 100;
      if (isNaN(caughtPercentage)) caughtPercentage = 0;
      this.mdt.criminalCaptureRate = Math.floor(caughtPercentage);
      status(this.mdt.criminalCaptureRate, "update")
    },
    currentDate() {
      let date = new Date()
      let day = date.getDate()
      let month = date.getMonth() + 1
      let year = date.getFullYear()
      return `${year}-${month.toString().padStart(2, "0")}-${day.toString().padStart(2, "0")}`
    },
    currentTime() {
      let date = new Date()
      let hour = date.getHours()
      let minute = date.getMinutes()
      let second = date.getSeconds()
      return `${hour}:${minute}:${second}`
    },
    getUserInfo: function(citizen, type) {
      if (citizen == "") return null; // veya istediğiniz bir değer
      let index = this.mdt.userList.findIndex((x) => x.citizen === citizen);
      if (index == -1) return;
      let data;

      data = this.mdt.userList[index];

      if (data) {
        // Eğer data varsa istenilen tipi döndür
        switch (type) {
          case "name":
            return data.user;
          case "job":
            return data.job;
          case "phone":
            return data.telephone;
          case "img":
            return data.userImage;
          case "gender":
            return data.gender;
          case "date":
            return data.date;
          case "crimes":
            return data.crimes;
          case "pastcrimes":
            return data.pastcrimes;
          case "licenses":
            return data.licanse;
          case "reports":
            return data.reports;
          case "notes":
            return data.notes;
          case "cars":
            return data.cars;
          case "houses":
            return data.houses;
          case "wanted":
            return data.wanted;
          case "caught":
            return data.caught;
          default:
            return null; // veya istediğiniz bir değer
        }
      } else {
        return null; // veya istediğiniz bir değer
      }
    },
    addNewData(data){
       // Eğer varsa push etmez bu sayede aynı veri eklenmez
       let check = this.checkBeforePush(data);
       if (check === false) return;
       data.citizen = data.citizen || data.citizenid;
       let findUserList = this.mdt.userList.find((user) => user.citizen === data.citizen);
       let findCitizenList = this.mdt.citizenList.find((citizen) => citizen.citizen === data.citizen);
       if(findUserList === -1 || findUserList === undefined){
          this.mdt.userList.push(data);
       }
       if(findCitizenList === -1 || findCitizenList === undefined){
          this.mdt.citizenList.push(data);
       }
    },
    addCarData(data){
      let check = this.checkBeforePush(data);
      if (check === false) return;
      let findCarList = this.mdt.carsList.find((car) => car.plate === data.plate);
      if(findCarList === -1 || findCarList === undefined){
        let showImage = "./assets/img/mdt/no-image.png";
        let wikiImage = 'https://docs.fivem.net/vehicles/' + data.name + '.webp'
        this.checkImage(wikiImage).then(result => {
          showImage = result ? wikiImage : "./assets/img/mdt/no-image.png";
        });
        setTimeout(() => {
          data.img = showImage;
          this.mdt.carsList.push(data);
        }, 250)
      }
    },
    addUserData(data){
      let check = this.checkBeforePush(data);
      if (check === false) return;
      let findUserList = this.mdt.userList.find((user) => user.citizen === data.citizen);
      if(findUserList === -1 || findUserList === undefined){
        this.mdt.userList.push(data);
      }
    },
    // Yeni aramada wanted olmayanları siler
    clearCarData(){
      this.mdt.carsList.forEach((element) => {
        if(!element.wanted){
          // Wanted olmayanları siler
          this.mdt.carsList = this.mdt.carsList.filter((x) => x.plate !== element.plate)
        }
      })
    },

    // Dashboard
    lineHeight(amount) {
      // Max height: 100%, max amount: 500
      let height = (amount * 100) / 500
      return height
    },
    newMessageSend() {
      if (this.mdt.newMessage != "") {
        let date = new Date()
        let day = date.getDate()
        let month = date.getMonth() + 1
        let year = date.getFullYear()
        let hour = date.getHours()
        let minute = date.getMinutes()
        let second = date.getSeconds()
        let time = hour + ":" + minute + ":" + second
        let fullDate = `${year}-${month.toString().padStart(2, "0")}-${day.toString().padStart(2, "0")}`
        this.mdt.messageList.push({
          user: this.mdt.profil.name,
          message: this.mdt.newMessage,
          date: fullDate,
          time: time,
          citizen: this.mdt.profil.citizen,
        })
        post('sync', {key: 'chat', value: this.mdt.messageList, message: this.mdt.newMessage, sender: this.mdt.profil.name})
        this.mdt.newMessage = ""
      }
    },
    emergencyAlert(emergency) {
      this.mdt.headerInfo.emergency = this.info[emergency]
      post('emergency', {type: emergency})
      this.mdt.alertMenu = false
    },

    onBeforeEnter(el){
      el.style.opacity = 0
    },
    onEnter(el, done){
      gsap.to(el, {opacity: 1, duration: 0.3, onComplete: done})
    },
    onLeave(el, done){
      gsap.to(el, {opacity: 0, duration: 0.3, onComplete: done})
    },

    // Yeni Eklendi
    enterDuty() {
      this.mdt.duty = !this.mdt.duty
      post('setDuty', this.mdt.duty)
      this.notify("info", this.mdt.duty ? this.info.dutyOn : this.info.dutyOff)
    },
    //-------------------------------------

    // Wanted List
    selectWanted(item) {
      if (item.selected == true) {
        item.selected = false
        this.mdt.wantedDetails = false
        this.mdt.wantedAddCrimes = false
        this.mdt.wantedAddEvidence = false
        setTimeout(() => {
          this.mdt.wantedDetail = ""
        }, 400)
        return
      }
      this.mdt.userList.forEach((element) => {
        element.selected = false
      })
      item.selected = true
      this.mdt.wantedAddCrimes = false
      this.mdt.wantedAddEvidence = false
      this.mdt.wantedDetail = item.citizen
      this.mdt.wantedDetails = true
    },
    callWantedDetail(id) {
      if (wantedDetail == "") return
      let index = this.mdt.wantedList.findIndex((x) => x.id === id)
      this.mdt.wantedList[index].selected = true
      return this.mdt.wantedList[index]
    },
    wantedDeleteCrimes(code) {
      if (this.mdt.wantedDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.wantedDetail)
      let data = this.mdt.userList[index].crimes.filter((x) => x !== code)
      this.mdt.userList[index].crimes = data
      post('updateWanted', this.mdt.userList[index])

      let crimeIndex = this.mdt.crimesList.findIndex((x) => x.code === code)
      this.mdt.crimesList[crimeIndex].amount--
      this.updateGraphic()
    },
    getAddCrimesList() {
      if (this.mdt.wantedDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.wantedDetail)
      let data = this.mdt.crimesList.filter((x) => !this.mdt.userList[index].crimes.includes(x.code))

      if (data.length == 0) {
        this.mdt.wantedAddCrimes = false
        return
      }
      return data
    },
    // addWantedCrime() {
    //   if (this.wantedDetail == "") return
    //   let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.wantedDetail)
    //   this.mdt.userList[index].crimes.push(this.mdt.wantedAddCrimesValue)
    //   post('updateWanted', this.mdt.userList[index])
    //   this.mdt.wantedAddCrimes = false

    //   // Add amount to crimes
    //   let crimeIndex = this.mdt.crimesList.findIndex((x) => x.code === this.mdt.wantedAddCrimesValue)
    //   this.mdt.crimesList[crimeIndex].amount++
    //   this.mdt.wantedAddCrimesValue = ""
    //   this.updateGraphic()
    // },
    addWantedCrime(code) {
      if (this.wantedDetail == "") return
      this.mdt.wantedAddCrimesValue = code
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.wantedDetail)
      this.mdt.userList[index].crimes.push(this.mdt.wantedAddCrimesValue)
      this.mdt.wantedAddCrimes = false

      // Add amount to crimes
      let crimeIndex = this.mdt.crimesList.findIndex((x) => x.code === this.mdt.wantedAddCrimesValue)
      this.mdt.crimesList[crimeIndex].amount++
      this.mdt.wantedAddCrimesValue = ""
      this.updateGraphic()
    },
    wantedEditReports(item, index) {
      item.edit = !item.edit
      let textArea = document.getElementById("edit-" + index)
      let ind = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.wantedDetail)
      if (item.edit) {
        setTimeout(() => {
          textArea.focus()
        }, 100)
      } else {
        post('updateWanted', this.mdt.userList[ind])
      }
    },
    wantedDeleteReport(item) {
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.wantedDetail)
      let data = this.mdt.userList[index].reports.filter((x) => x !== item)
      this.mdt.userList[index].reports = data
      post('updateWanted', this.mdt.userList[index])
    },
    wantedAddReport() {
      if (this.mdt.wantedDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.wantedDetail)
      this.mdt.userList[index].reports.unshift({ description: this.mdt.newMessage, user: this.mdt.profil.name, date: this.currentDate(), time: this.currentTime(), edit: true, active: false })
      // post('updateWanted', this.mdt.userList[index])
    },
    wantedCaught() {
      if (this.mdt.wantedDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.wantedDetail)
      let data = this.mdt.userList[index]
      if(data.caught == false){
        data.caught = true
        post('updateWanted', data)
        this.updateGraphic()
        return
      } else{
        this.mdt.wantedDetail = ""
        this.mdt.wantedDetails = false
        data.wanted = false
        data.caught = false
        data.crimes.forEach((element) => {
          data.pastcrimes.push(element)
        })
        post('updateWanted', data)
        this.updateGraphic()
        data.crimes = []
      }
    },
    getWantedEvidence(){
      if (this.mdt.wantedDetail == "") return
      let index = this.mdt.evidencesList.filter((x) => x.userCitizen === this.mdt.wantedDetail)
      return index
    },
    wantedReportSelect(item) {
      if (this.mdt.wantedDetail == "") return
      this.getUserInfo(this.mdt.wantedDetail, "reports").forEach((element) => {
        element.active = false
      })
      item.active = true
    },

    // Commands
    commandSelect(item) {
      this.mdt.newCommands = false
      if (item.selected == true) {
        item.selected = false
        this.mdt.commandDetails = false
        this.mdt.commandEdit = false
        this.mdt.commandEditValue = ""
        setTimeout(() => {
          this.mdt.commandDetail = ""
        }, 400)
        return
      }
      this.mdt.commandsList.forEach((element) => {
        element.selected = false
      })
      item.selected = true
      this.mdt.commandEdit = false
      this.mdt.commandDetail = item.id
      this.mdt.commandDetails = true
    },
    commandGetCode() {
      if (this.mdt.commandDetail == "") return
      let index = this.mdt.commandsList.findIndex((x) => x.id === this.mdt.commandDetail)
      return this.mdt.commandsList[index].code
    },
    commandGetDate() {
      if (this.mdt.commandDetail == "") return
      let index = this.mdt.commandsList.findIndex((x) => x.id === this.mdt.commandDetail)
      return this.mdt.commandsList[index].date
    },
    commandGetUser() {
      if (this.mdt.commandDetail == "") return
      let index = this.mdt.commandsList.findIndex((x) => x.id === this.mdt.commandDetail)
      return this.mdt.commandsList[index].user
    },
    commandGetDescription() {
      if (this.mdt.commandDetail == "") return
      let index = this.mdt.commandsList.findIndex((x) => x.id === this.mdt.commandDetail)
      return this.mdt.commandsList[index].description
    },
    editCommandDescription() {
      if (this.mdt.commandEditDescs) {
        if (this.mdt.commandEditDesc == "") return
        let index = this.mdt.commandsList.findIndex((x) => x.id === this.mdt.commandDetail)
        this.mdt.commandsList[index].description = this.mdt.commandEditDesc
        post('updateCommand', this.mdt.commandsList[index])
        this.mdt.commandEditDescs = false
        this.mdt.commandEditDesc = ""
      } else if (!this.mdt.commandEditDescs) {
        this.mdt.commandEditDescs = !this.mdt.commandEditDescs
        this.mdt.commandEditDesc = this.commandGetDescription()
        setTimeout(() => {
          let input = document.getElementById("command-description")
          input.focus()
        }, 100)
      }
    },
    checkBeforePush(table) {
      for (let key in table) {
        if (table[key] === null || table[key] === 'null' || table[key] === undefined) {
          return false;
        }
      }
      return true;
    },
    editCommandCode() {
      if (this.mdt.commandEdit) {
        if (this.mdt.commandDetail == "") return
        let index = this.mdt.commandsList.findIndex((x) => x.id === this.mdt.commandDetail)
        this.mdt.commandsList[index].code = this.mdt.commandEditValue
        post('updateCommand', this.mdt.commandsList[index])
        this.mdt.commandEdit = false
        this.mdt.commandEditValue = ""
      } else if (!this.mdt.commandEdit) {
        this.mdt.commandEdit = !this.mdt.commandEdit
        this.mdt.commandEditValue = this.commandGetCode()
        setTimeout(() => {
          let input = document.getElementById("command-edit")
          input.focus()
        }, 100)
      }
    },
    newCommand() {
      this.mdt.commandDetails = false
      this.mdt.commandEdit = false
      this.mdt.commandEditValue = ""
      this.mdt.commandDetail = ""
      this.mdt.commandsList.forEach((element) => {
        element.selected = false
      })
      this.mdt.newCommands = !this.mdt.newCommands
      setTimeout(() => {
        document.getElementById("command-new").focus()
      }, 100)
    },
    addNewCommand() {
      if (this.mdt.newCommand != "") {
        let newCommand = {
          id: this.randomId(),
          code: this.mdt.newCommand,
          date: this.currentDate(),
          userImage: this.mdt.profil.img,
          user: this.mdt.profil.name,
          description: this.mdt.newCommandDesc,
          selected: false,
        }
        this.mdt.commandsList.push(newCommand)
        post('addCommand', newCommand)
        this.notify("success", this.info.commandcreated)

        // post('addCommand', this.mdt.commandsList)
        this.mdt.newCommands = false
        this.mdt.newCommand = ""
        this.mdt.newCommandDesc = ""
      }
    },
    deleteCommand() {
      if (this.mdt.commandDetail == "") return
      let index = this.mdt.commandsList.findIndex((x) => x.id === this.mdt.commandDetail)
      post('removeCommand', this.mdt.commandsList[index])
      this.notify("error", this.info.commandremoved)

      this.mdt.commandsList.splice(index, 1)
      this.mdt.commandDetail = ""
      this.mdt.commandDetails = false
    },

    // Active Polices
    getOnlinePolice() {
      this.mdt.headerInfo.activePolice = this.mdt.policeList.filter((x) => x.status === "Online").length;
      return this.mdt.policeList.filter((x) => x.status === "Online")
    },
    getOfflinePolice() {
      return this.mdt.policeList.filter((x) => x.status === "Offline")
    },
    getActivePoliceDetails() {
      if (this.mdt.activePoliceDetail == "") return
      let index = this.mdt.policeList.findIndex((x) => x.citizen === this.mdt.activePoliceDetail)
      return this.mdt.policeList[index]
    },
    closeActivePoliceDetail() {
      this.mdt.activePoliceDetails = false
      this.mdt.activePoliceDetail = ""
    },
    activePoliceDetail(citizen) {
      this.mdt.activePoliceDetails = true
      this.mdt.activePoliceDetail = citizen
    },

    // Forms
    createNewForm() {
      let Form = {
        id: this.randomId(),
        time: this.currentTime(),
        date: this.currentDate(),
        user: this.mdt.profil.name,
        title: this.mdt.formTitle,
        description: this.mdt.formDesc,
      }
      this.notify("success", this.info.formcreated)
      post('addForm', Form)
      this.mdt.formsList.push(Form)
      this.mdt.formTitle = ""
      this.mdt.formDesc = ""
    },
    deleteForm(id) {
      let index = this.mdt.formsList.findIndex((x) => x.id === id)
      this.notify("error", this.info.formremoved)

      post('removeForm', this.mdt.formsList[index])
      this.mdt.formsList.splice(index, 1)
    },
    formSelect(item) {
      this.mdt.formDetail = item.id
      this.mdt.formRouter = "detailForm"
    },
    getFormDetail(id , type) {
      if (id == "") return
      let index = this.mdt.formsList.findIndex((x) => x.id === id)
      if (type == "title") return this.mdt.formsList[index].title
      if (type == "description") return this.mdt.formsList[index].description
      if (type == "user") return this.mdt.formsList[index].user
      if (type == "date") return this.mdt.formsList[index].date
      if (type == "time") return this.mdt.formsList[index].time
    },

    // Fines
    fineSelect(item) {
      this.mdt.crimeDetail = item.id
      this.mdt.crimeDetails = true
      this.mdt.newCrimes = false
      this.mdt.crimesList.forEach((element) => {
        element.selecet = false
      })
      item.selecet = true
      this.mdt.crimeEditCodes = false
      this.mdt.crimeEditNames = false
      this.mdt.crimeEditPrices = false
    },
    getFineName() {
      if (this.mdt.crimeDetail == "") return
      let index = this.mdt.crimesList.findIndex((x) => x.id === this.mdt.crimeDetail)
      return this.mdt.crimesList[index].name
    },
    getFineCode() {
      if (this.mdt.crimeDetail == "") return
      let index = this.mdt.crimesList.findIndex((x) => x.id === this.mdt.crimeDetail)
      return this.mdt.crimesList[index].code
    },
    getFinePrice() {
      if (this.mdt.crimeDetail == "") return
      let index = this.mdt.crimesList.findIndex((x) => x.id === this.mdt.crimeDetail)
      return this.mdt.crimesList[index].price
    },
    fineEditName() {
      if (this.mdt.crimeEditNames) {
        if (this.mdt.crimeDetail == "") return
        let index = this.mdt.crimesList.findIndex((x) => x.id === this.mdt.crimeDetail)
        this.mdt.crimesList[index].name = this.mdt.crimeEditName
        post('updateFine', this.mdt.crimesList[index])
        this.mdt.crimeEditNames = false
        this.mdt.crimeEditName = ""
      } else if (!this.mdt.crimeEditNames) {
        this.mdt.crimeEditNames = !this.mdt.crimeEditNames
        this.mdt.crimeEditName = this.getFineName()
        setTimeout(() => {
          let input = document.getElementById("fine-name")
          input.focus()
        }, 100)
      }
    },
    fineEditCode() {
      if (this.mdt.crimeEditCodes) {
        if (this.mdt.crimeDetail == "") return
        let index = this.mdt.crimesList.findIndex((x) => x.id === this.mdt.crimeDetail)
        this.mdt.crimesList[index].code = this.mdt.crimeEditCode
        post('updateFine', this.mdt.crimesList[index])
        this.mdt.crimeEditCodes = false
        this.mdt.crimeEditCode = ""
      } else if (!this.mdt.crimeEditCodes) {
        this.mdt.crimeEditCodes = !this.mdt.crimeEditCodes
        this.mdt.crimeEditCode = this.getFineCode()
        setTimeout(() => {
          let input = document.getElementById("fine-code")
          input.focus()
        }, 100)
      }
    },
    fineEditPrice() {
      if (this.mdt.crimeEditPrices) {
        if (this.mdt.crimeDetail == "") return
        let index = this.mdt.crimesList.findIndex((x) => x.id === this.mdt.crimeDetail)
        this.mdt.crimesList[index].price = this.mdt.crimeEditPrice
        post('updateFine', this.mdt.crimesList[index])
        this.mdt.crimeEditPrices = false
        this.mdt.crimeEditPrice = ""
      } else if (!this.mdt.crimeEditPrices) {
        this.mdt.crimeEditPrices = !this.mdt.crimeEditPrices
        this.mdt.crimeEditPrice = this.getFinePrice()
        setTimeout(() => {
          let input = document.getElementById("fine-price")
          input.focus()
        }, 100)
      }
    },
    newFine() {
      this.mdt.crimeDetails = false
      this.mdt.crimeEditCodes = false
      this.mdt.crimeEditNames = false
      this.mdt.crimeEditPrices = false
      this.mdt.crimeDetail = ""
      this.mdt.crimesList.forEach((element) => {
        element.selecet = false
      })
      this.mdt.newCrimes = !this.mdt.newCrimes
    },
    // Değişti
    addNewFine() {
      if (this.mdt.newCrimeCode == "" || this.mdt.newCrimeName == "") return
      if (this.mdt.newCrimeType == "jail" && this.mdt.newCrimeJailTime == "") return
      if (this.mdt.newCrimeType == "public" && this.mdt.newCrimePublicAmount == "") return
      if (this.mdt.newCrimeType == "money" && this.mdt.newCrimePrice == null) return
      let newFineJail = {
        id: this.randomId(),
        code: this.mdt.newCrimeCode,
        name: this.mdt.newCrimeName,
        crimeType: this.mdt.newCrimeType,
        jailTime: this.mdt.newCrimeJailTime,
        jailTimeType: this.mdt.newCrimeJailTimeType,
        amount: 0,
        selecet: false,
      }
      let newFinePublic = {
        id: this.randomId(),
        code: this.mdt.newCrimeCode,
        name: this.mdt.newCrimeName,
        crimeType: this.mdt.newCrimeType,
        publicAmount: this.mdt.newCrimePublicAmount,
        amount: 0,
        selecet: false,
      }
      let newFineMoney = {
        id: this.randomId(),
        code: this.mdt.newCrimeCode,
        name: this.mdt.newCrimeName,
        crimeType: this.mdt.newCrimeType,
        price: this.mdt.newCrimePrice,
        amount: 0,
        selecet: false,
      }
      let newFine = {
        id: this.randomId(),
        code: this.mdt.newCrimeCode,
        name: this.mdt.newCrimeName,
        price: this.mdt.newCrimePrice,
        publicAmount: this.mdt.newCrimePublicAmount,
        jailTime: this.mdt.newCrimeJailTime,
        jailTimeType: this.mdt.newCrimeJailTimeType,
        amount: 0,
        selecet: false,
      }
      post('addFine', newFine)
      // if (this.mdt.newCrimeType == "money") {
      //   this.mdt.crimesList.push(newFineMoney)
      // } else if (this.mdt.newCrimeType == "public") {
      //   this.mdt.crimesList.push(newFinePublic)
      // } else if (this.mdt.newCrimeType == "jail") {
      //   this.mdt.crimesList.push(newFineJail)
      // }
      this.mdt.crimesList.push(newFine)
      this.mdt.newCrimes = false
      this.mdt.newCrimeCode = ""
      this.mdt.newCrimeName = ""
      this.mdt.newCrimeType = "money"
      this.mdt.newCrimeJailTime = ""
      this.mdt.newCrimeJailTimeType = "minute"
      this.mdt.newCrimePublicAmount = ""
      this.mdt.newCrimePrice = null
    },
    // -------
    deleteFine() {
      if (this.mdt.crimeDetail == "") return
      let index = this.mdt.crimesList.findIndex((x) => x.id === this.mdt.crimeDetail)
      post('removeFine', this.mdt.crimesList[index], )
      this.mdt.crimesList.splice(index, 1)
      this.mdt.crimeDetail = ""
      this.mdt.crimeDetails = false
      this.notify("error", this.info.fineDeleted)
      this.updateGraphic()
    },
    getFineInfo(type) {
      if (this.mdt.crimeDetail == "") return
      let index = this.mdt.crimesList.findIndex((x) => x.id === this.mdt.crimeDetail)
      if (type == "code") return this.mdt.crimesList[index].code
      if (type == "name") return this.mdt.crimesList[index].name
      if (type == "price") return this.mdt.crimesList[index].price
      if (type == "crimeType") return this.mdt.crimesList[index].crimeType
      if (type == "jailTime") return this.mdt.crimesList[index].jailTime
      if (type == "jailTimeType") return this.mdt.crimesList[index].jailTimeType
      if (type == "publicAmount") return this.mdt.crimesList[index].publicAmount
    },
    

    // User List
    selectUser(item) {
      if (item.selected) {
        this.mdt.userDetails = false
        this.mdt.userDetail = ""
        item.selected = false
        return
      } else {
        this.mdt.userDetail = item.citizen
        this.mdt.userDetails = true
        this.mdt.citizenList.forEach((element) => {
          element.selected = false
        })
        this.mdt.userList.forEach((element) => {
          element.selected = false
        })
        item.selected = true
      }
    },
    searchUser(){
         // Yeni eklendi
        if (this.mdt.userSearch.length < 3) return this.notify("error", this.info.nametooshort);
        if (this.mdt.userList.some(f => f.citizen === this.mdt.userSearch)) return this.notify("error", this.info.alreadysearcheduser);

        this.mdt.citizenList = [];
         fetch(`https://dusa_mdt/executePlayer`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: JSON.stringify({
            name: this.mdt.userSearch,
          }),
        })
        .then((player) => player.json())
        .then((player) => {
          if (player === false || player === null) {
            return;
          }
          player.forEach((ply) => {
            this.addNewData(ply)
          });
        });
    },
    addNote() {
      if (this.mdt.userDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.userDetail)
      this.mdt.userList[index].notes.unshift({ user: this.mdt.profil.name, description: "", date: this.currentDate(), time: this.currentTime(), edit: true })
    },
    editNote(added) {
      if (this.mdt.userDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.userDetail)
      if (added) return;
      post('updateWanted', this.mdt.userList[index]) 
    },
    deleteNote(item) {
      if (this.mdt.userDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.userDetail)
      let data = this.mdt.userList[index].notes.filter((x) => x !== item)
      this.mdt.userList[index].notes = data
      this.notify("error", this.info.noteDeleted)
      post('updateWanted', this.mdt.userList[index]) 
    },
    setWanted() {
      if (this.mdt.userDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.userDetail)
      this.mdt.userList[index].wanted = !this.mdt.userList[index].wanted
      this.updateGraphic();
      this.notify("info", this.info.addedWanted)
      post('setWanted', this.mdt.userList[index]);
    },

    // Cars
    selectCar(item) {
      if (item.selected) {
        this.mdt.carDetails = false
        this.mdt.carDetail = ""
        this.mdt.carDetailCitizen = ""
        item.selected = false
        return
      }
      this.mdt.carDetail = item.plate
      this.mdt.carDetailCitizen = item.citizen
      this.mdt.carDetails = true
      this.mdt.carsList.forEach((element) => {
        element.selected = false
      })
      item.selected = true
    },
    searchVehicle(){
      // Yeni eklendi
      if (this.mdt.carsAllSearch.length < 3) {
        return this.notify("error", this.info.platetooshort);
      }
      if (this.mdt.carsList.some(f => f.plate === this.mdt.carsAllSearch)) return this.notify("error", this.info.alreadysearchedplate);
      
       this.mdt.citizenList = [];
       this.clearCarData();
       fetch(`https://dusa_mdt/executeVehicle`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({
          plate: this.mdt.carsAllSearch,
        }),
      })
      .then((data) => data.json())
      .then((data) => {
        if (data === false || data === null) {
          return;
        }
        if(data.length === 0) return
        if(data.player === null) return
        if(data.car === null) return
        
        // İLK ARABALARIN SAHİPLERİ EKLENECEK
        data.player.forEach((ply) => {
          this.addUserData(ply)
        });
        // İKİNCİ OLARAK ARABALAR EKLENECEK
        data.car.forEach((veh) => {
          this.addCarData(veh)
        });
      });  
    },
    getCarInfo(plate, type) {
      if (plate == "") return
      let index = this.mdt.carsList.findIndex((x) => x.plate === plate)
      if (index == -1) return
      let data = this.mdt.carsList[index]
      if (type == "name") return data.name
      if (type == "owner") return this.getUserInfo(data.citizen, "name")
      if (type == "citizen") return data.citizen
      if (type == "plate") return data.plate
      if (type == "wanted") return data.wanted
      if (type == "reports") return data.reports
      if (type == "img") return data.img
      if (type == "color") return data.color
    },
    deleteCarReport(item) {
      if (this.mdt.carDetail == "") return
      let index = this.mdt.carsList.findIndex((x) => x.plate === this.mdt.carDetail)
      let data = this.mdt.carsList[index].reports.filter((x) => x !== item)
      this.mdt.carsList[index].reports = data
      post('setVehicleWanted', this.mdt.carsList[index])
    },
    newCarReports() {
      if (this.mdt.carDetail == "") return
      let index = this.mdt.carsList.findIndex((x) => x.plate === this.mdt.carDetail)
      this.mdt.carsList[index].reports.unshift({ description: this.mdt.newMessage, user: this.mdt.profil.name, date: this.currentDate(), time: this.currentTime(), edit: true, active: false })
      // create 500 ms timeout
      setTimeout(() => {
        post('setVehicleWanted', this.mdt.carsList[index])
      }, 500)
    },
    wantedCar() {
      if (this.mdt.carDetail == "") return
      let index = this.mdt.carsList.findIndex((x) => x.plate === this.mdt.carDetail)
      this.mdt.carsList[index].wanted = !this.mdt.carsList[index].wanted
      this.notify("info", this.info.vehiclewanted)
      if (this.mdt.carsList[index].wanted) post('setVehicleWanted', this.mdt.carsList[index]);
    },
    caughtCar() {
      if (this.mdt.carDetail == "") return
      let index = this.mdt.carsList.findIndex((x) => x.plate === this.mdt.carDetail)
      this.mdt.carsList[index].wanted = !this.mdt.carsList[index].wanted
      this.notify("info", this.info.vehicleremovedwanted)
      if(!this.mdt.carsList[index].wanted) post('removeVehicleWanted', this.mdt.carsList[index]);
      this.mdt.carsList[index].reports = []
    },

    // House
    selectHouse(item) {
      if (item.selected) {
        this.mdt.houseDetails = false
        this.mdt.houseDetail = ""
        this.mdt.houseCitizen = ""
        item.selected = false
        return
      }
      this.mdt.houseDetail = item.id
      this.mdt.houseCitizen = item.citizen
      this.mdt.houseDetails = true
      this.mdt.housesList.forEach((element) => {
        element.selected = false
      })
      item.selected = true
    },
    getHouseInfo(id, type) {
      if (this.mdt.houseDetail == "") return
      let index = this.mdt.housesList.findIndex((x) => x.id === id)
      let data = this.mdt.housesList[index]
      if (type == "owner") return this.getUserInfo(data.citizen, "name")
      if (type == "citizen") return data.citizen
      if (type == "address") return data.address
      if (type == "img") return data.img
      if (type == "name") return data.name
    },
    navigateHouse() {
      if (this.mdt.houseDetail == "") return
      let index = this.mdt.housesList.findIndex((x) => x.id === this.mdt.houseDetail)
      let data = this.mdt.housesList[index]
      post('navigateHouse', data)
    },

    // Licanse
    deleteLicanse(item) {
      if (this.mdt.userDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.userDetail)
      let data = this.mdt.userList[index].licanse.filter((x) => x !== item)
      this.notify("error", this.info.revokedlicense)
      post('removeLicense', {license: item, citizenid: this.mdt.userList[index].citizen})
      this.mdt.userList[index].licanse = data
    },
    searchLicanse(){
      // Yeni eklendi
      if (this.mdt.userSearch.length < 3) {
        return;
      }
       this.mdt.citizenList = [];
       fetch(`https://dusa_mdt/executePlayer`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({
          name: this.mdt.userSearch,
        }),
      })
      .then((player) => player.json())
      .then((player) => {
        if (player === false || player === null) {
          return;
        }
        player.forEach((ply) => {
          this.addNewData(ply)
        });
      });  
    },
    addLicanse() {
      if (this.mdt.userDetail == "") return
      if (this.mdt.licanseAdd == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.userDetail)
      this.mdt.userList[index].licanse.unshift(this.mdt.licanseAdd)
      this.notify("success", this.info.grantedlicense)
      post('updateLicense', {license: this.mdt.userList[index].licanse, citizenid: this.mdt.userList[index].citizen, added: this.mdt.licanseAdd})
      this.mdt.licanseAdd = ""
    },

    // Live Map
    createAlert() {
      if (this.mdt.alertTitle == "" || this.mdt.alertDetail == "") return
      let findIndex = this.mdt.alertList.findIndex((x) => x.citizen === this.mdt.profil.citizen)
      if (findIndex !== -1) {
        this.mdt.alertList.splice(findIndex, 1)
      }
      fetch(`https://dusa_mdt/getCoords`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({}),
      })
      .then((coords) => coords.json())
      .then((coords) => {
        if (coords === false) {
          return;
        }
        coords = JSON.parse(coords)
        let alert = {
          title: this.mdt.alertTitle,
          citizen: this.mdt.profil.citizen,
          description: this.mdt.alertDetail,
          x: coords.x,
          y: coords.y,
        }
        this.mdt.alertList.push(alert)
        this.mdt.alertTitle = ""
        this.mdt.alertDetail = ""
        this.notify("success", this.info.alertnotified)
        newMarker(coords.y, coords.x, this.mdt.profil.citizen, this.mdt.profil.name, this.mdt.profil.rank, redIcon)
        post('notifyAlert', alert)
        post('emergency', {type: 'livemap', alertname: alert.title})
      });
    },
    alertCoordinate(x, y) {
    },
    deleteAlert(citizen) {
      let index = this.mdt.alertList.findIndex((x) => x.citizen === citizen)
      this.mdt.alertList.splice(index, 1)
      this.notify("error", this.info.alertremoved)
      deleteMarker(citizen)
    },

    // Incidents
    incidentsSelect(item) {
      if (item.active) {
        this.clearIncidents()
        return
      }
      this.mdt.incidentsList.forEach((element) => {
        element.active = false
      })
      item.active = true
      this.mdt.incidentsDetail = item.id
      this.mdt.incidentsNew = false
      this.mdt.incidentsDetails = true
    },
    deleteIncidents() {
      if (this.mdt.incidentsDetail == "") return
      let index = this.mdt.incidentsList.findIndex((x) => x.id === this.mdt.incidentsDetail)
      post('removeIncident', this.mdt.incidentsList[index])
      this.mdt.incidentsList.splice(index, 1)
      this.notify("error", this.info.incidentremoved)
      this.clearIncidents()
    },
    clearIncidents() {
      this.mdt.incidentsList.forEach((element) => {
        element.active = false
      })
      this.mdt.incidentsDetail = ""
      this.mdt.incidentsDetails = false
      this.mdt.incidentsUserSearch = ""
      this.mdt.incidentsSearch = ""
      this.mdt.incidentsDesc = ""
      this.mdt.incidentsName = ""
      this.mdt.incidentsImg = []
      this.mdt.incidentsImgLink = ""
      this.mdt.incidentsUserSearchNew = ""
      this.mdt.incidentsImgMenu = "screenShot"
      this.mdt.incidentsAddedCitizen = []
      this.mdt.incidentsNew = false
    },
    getIncidentInfo(id, type) {
      if (id == "") return
      let index = this.mdt.incidentsList.findIndex((x) => x.id === id)
      let data = this.mdt.incidentsList[index]
      if (type == "name") return data.name
      if (type == "description") return data.description
      if (type == "userCitizen") return data.userCitizen
      if (type == "addedCitizen") return data.addedCitizen
      if (type == "img") return data.image
      if (type == "creator") return this.getUserInfo(data.userCitizen, "name")
    },
    addIncidentsUsers(citizen) {
      if (this.mdt.incidentsDetail == "") return
      let index = this.mdt.incidentsList.findIndex((x) => x.id === this.mdt.incidentsDetail)
      this.mdt.incidentsList[index].addedCitizen.push(citizen)
    },
    deleteIncidentsUsers(citizen) {
      if (this.mdt.incidentsDetail == "") return
      let index = this.mdt.incidentsList.findIndex((x) => x.id === this.mdt.incidentsDetail)
      let data = this.mdt.incidentsList[index].addedCitizen.filter((x) => x !== citizen)
      this.mdt.incidentsList[index].addedCitizen = data
    },
    deleteIncidentsImage(item) {
      if (this.mdt.incidentsDetail == "") return
      let index = this.mdt.incidentsList.findIndex((x) => x.id === this.mdt.incidentsDetail)
      let data = this.mdt.incidentsList[index].image.filter((x) => x !== item)
      this.mdt.incidentsList[index].image = data
    },
    screenShotIncidents() {
      if (this.mdt.incidentsDetail == "") return
      let index = this.mdt.incidentsList.findIndex((x) => x.id === this.mdt.incidentsDetail)
      var xhr = new XMLHttpRequest();
      xhr.open("POST", "https://dusa_mdt/takephoto");
      xhr.setRequestHeader("Content-Type", "application/json");
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          let url = xhr.responseText
          // url değişkeninin başındaki ve sonundaki "" işaretlerini kaldır
          
          app.mdt.incidentsList[index].image.push(JSON.parse(url))
        }
      };
      xhr.send(JSON.stringify({}));
      // this.mdt.incidentsList[index].image.push("https://via.placeholder.com/150")
    },
    addLinkIncidents() {
      if (this.mdt.incidentsDetail == "") return
      if (this.mdt.incidentsImgLink == "") return
      let index = this.mdt.incidentsList.findIndex((x) => x.id === this.mdt.incidentsDetail)
      this.mdt.incidentsList[index].image.push(this.mdt.incidentsImgLink)
      this.mdt.incidentsImgLink = ""
    },
    getIncidentBanner(id) {
      if (id == "") return
      return this.getIncidentInfo(id, "img")[0]
    },
    newIncidents() {
      this.clearIncidents()
      this.mdt.incidentsNew = !this.mdt.incidentsNew
    },
    addIncidentsNewUsers(citizen) {
      this.mdt.incidentsAddedCitizen.push(citizen)
      this.mdt.incidentsUserSearchNew = ""
    },
    deleteNewIncidentsUsers(citizen) {
      let data = this.mdt.incidentsAddedCitizen.filter((x) => x !== citizen)
      this.mdt.incidentsAddedCitizen = data
    },
    deleteNewIncidentsImage(item) {
      let data = this.mdt.incidentsImg.filter((x) => x !== item)
      this.mdt.incidentsImg = data
    },
    screenShotNewIncidents() {
      var xhr = new XMLHttpRequest();
      xhr.open("POST", "https://dusa_mdt/takephoto");
      xhr.setRequestHeader("Content-Type", "application/json");
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          let url = xhr.responseText
          // url değişkeninin başındaki ve sonundaki "" işaretlerini kaldır
          
          app.mdt.incidentsImg.push(JSON.parse(url))
        }
      };
      xhr.send(JSON.stringify({}));
    },
    addLinkNewIncidents() {
      if (this.mdt.incidentsImgLinkNew == "") return
      this.mdt.incidentsImg.push(this.mdt.incidentsImgLinkNew)
      this.mdt.incidentsImgLinkNew = ""
    },
    createIncidents() {
      if (this.mdt.incidentsName == "" || this.mdt.incidentsDesc == "") return
      fetch(`https://dusa_mdt/getCitizenid`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({}),
      })
      .then((citizenid) => citizenid.json())
      .then((citizenid) => {
        if (citizenid === false) {
          return;
        }
        let incidents = {
          active: false,
          id: this.randomId(),
          name: this.mdt.incidentsName,
          description: this.mdt.incidentsDesc,
          userCitizen: citizenid,
          addedCitizen: this.mdt.incidentsAddedCitizen,
          image: this.mdt.incidentsImg,
        }
        this.mdt.incidentsList.push(incidents)
       this.notify("success", this.info.incidentcreated)
        post('addIncident', incidents)
        this.clearIncidents()
      });
    },

    // Evidence
    evidencesSelect(item) {
      if (item.active) {
        this.clearEvidences()
        return
      }
      this.mdt.evidencesList.forEach((element) => {
        element.active = false
      })
      item.active = true
      this.mdt.evidencesDetail = item.id
      this.mdt.evidencesNew = false
      this.mdt.evidencesDetails = true
    },
    clearEvidences() {
      this.mdt.evidencesList.forEach((element) => {
        element.active = false
      })
      this.mdt.evidencesDetail = ""
      this.mdt.evidencesDetails = false
      this.mdt.evidencesUserSearch = ""
      this.mdt.evidencesSearch = ""
      this.mdt.evidencesDesc = ""
      this.mdt.evidencesName = ""
      this.mdt.evidencesImg = []
      this.mdt.evidencesImgLink = ""
      this.mdt.evidencesUserSearchNew = ""
      this.mdt.evidencesImgMenu = "screenShot"
      this.mdt.evidencesAddedCitizen = []
      this.mdt.evidencesNew = false
    },
    deleteEvidences() {
      if (this.mdt.evidencesDetail == "") return
      let index = this.mdt.evidencesList.findIndex((x) => x.id === this.mdt.evidencesDetail)
      post('removeEvidence', this.mdt.evidencesList[index])
      this.mdt.evidencesList.splice(index, 1)
      this.notify("error", this.info.evidenceremoved)
      this.clearEvidences()
    },
    getEvidenceInfo(id, type) {
      if (id == "") return
      let index = this.mdt.evidencesList.findIndex((x) => x.id === id)
      let data = this.mdt.evidencesList[index]
      if (type == "name") return data.name
      if (type == "description") return data.description
      if (type == "userCitizen") return data.userCitizen
      if (type == "addedCitizen") return data.addedCitizen
      if (type == "img") return data.image
      if (type == "creator") return this.getUserInfo(data.userCitizen, "name")
    },
    addEvidencesUsers(citizen) {
      if (this.mdt.evidencesDetail == "") return
      let index = this.mdt.evidencesList.findIndex((x) => x.id === this.mdt.evidencesDetail)
      this.mdt.evidencesList[index].addedCitizen.push(citizen)
    },
    deleteEvidencesUsers(citizen){
      if (this.mdt.evidencesDetail == "") return
      let index = this.mdt.evidencesList.findIndex((x) => x.id === this.mdt.evidencesDetail)
      let data = this.mdt.evidencesList[index].addedCitizen.filter((x) => x !== citizen)
      this.mdt.evidencesList[index].addedCitizen = data
    },
    deleteEvidencesImage(item){
      if (this.mdt.evidencesDetail == "") return
      let index = this.mdt.evidencesList.findIndex((x) => x.id === this.mdt.evidencesDetail)
      let data = this.mdt.evidencesList[index].image.filter((x) => x !== item)
      this.mdt.evidencesList[index].image = data
    },
    screenShotEvidences(){
      if (this.mdt.evidencesDetail == "") return
      let index = this.mdt.evidencesList.findIndex((x) => x.id === this.mdt.evidencesDetail)
      // this.mdt.evidencesList[index].image.push("https://via.placeholder.com/150")
      var xhr = new XMLHttpRequest();
      xhr.open("POST", "https://dusa_mdt/takephoto");
      xhr.setRequestHeader("Content-Type", "application/json");
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          let url = xhr.responseText
          // url değişkeninin başındaki ve sonundaki "" işaretlerini kaldır
          
          this.mdt.evidencesList[index].image.push(JSON.parse(url))
        }
      };
      xhr.send(JSON.stringify({}));
    },
    addLinkEvidences(){
      if (this.mdt.evidencesDetail == "") return
      if (this.mdt.evidencesImgLink == "") return
      let index = this.mdt.evidencesList.findIndex((x) => x.id === this.mdt.evidencesDetail)
      this.mdt.evidencesList[index].image.push(this.mdt.evidencesImgLink)
      this.mdt.evidencesImgLink = ""
    },
    getEvidenceBanner(id){
      if (id == "") return
      return this.getEvidenceInfo(id, "img")[0]
    },
    newEvidences(){
      this.clearEvidences()
      this.mdt.evidencesNew = !this.mdt.evidencesNew
    },
    addEvidencesNewUsers(citizen){
      this.mdt.evidencesAddedCitizen.push(citizen)
      this.mdt.evidencesUserSearchNew = ""
    },
    deleteNewEvidencesUsers(citizen){
      let data = this.mdt.evidencesAddedCitizen.filter((x) => x !== citizen)
      this.mdt.evidencesAddedCitizen = data
    },
    deleteNewEvidencesImage(item){
      let data = this.mdt.evidencesImg.filter((x) => x !== item)
      this.mdt.evidencesImg = data
    },
    screenShotNewEvidences() {
      var xhr = new XMLHttpRequest();
      xhr.open("POST", "https://dusa_mdt/takephoto");
      xhr.setRequestHeader("Content-Type", "application/json");
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          let url = xhr.responseText
          // url değişkeninin başındaki ve sonundaki "" işaretlerini kaldır
          
          app.mdt.evidencesImg.push(JSON.parse(url))
        }
      };
      xhr.send(JSON.stringify({}));
      // this.mdt.evidencesImg.push("https://via.placeholder.com/150")
    },
    addLinkNewEvidences(){
      if (this.mdt.evidencesImgLinkNew == "") return
      this.mdt.evidencesImg.push(this.mdt.evidencesImgLinkNew)
      this.mdt.evidencesImgLinkNew = ""
    },
    createEvidences() {
      if (this.mdt.evidencesName == "" || this.mdt.evidencesDesc == "") return
      fetch(`https://dusa_mdt/getCitizenid`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({}),
      })
      .then((citizenid) => citizenid.json())
      .then((citizenid) => {
        if (citizenid === false) {
          return;
        }
        let evidences = {
          active: false,
          id: this.randomId(),
          name: this.mdt.evidencesName,
          description: this.mdt.evidencesDesc,
          userCitizen: citizenid,
          addedCitizen: this.mdt.evidencesAddedCitizen,
          image: this.mdt.evidencesImg,
        }
        this.mdt.evidencesList.push(evidences)
        post('addEvidence', evidences)
        this.notify("success", this.info.evidencecreated)
        this.clearEvidences()
      });
    },
    // Charges user
    selectChargesUser(item){

      if(item.active){

        item.active = false

        this.mdt.chargesUserCitizen = ""
        this.mdt.chargesUserId = ""

        this.chargesUserClearData()

      } else{

        this.mdt.nearList.forEach((element) => {
          element.active = false
        })

        this.mdt.chargesUserCitizen = item.citizen
        this.mdt.chargesUserId = item.id

        item.active = true

      }

    },

    sendToJail(){

      if(this.mdt.chargesUserCitizen == "" || this.mdt.chargesUserId == "" || this.mdt.jailTime == "" || this.mdt.jailReason == "") return


      let data = {
        citizen: this.mdt.chargesUserCitizen,
        id: this.mdt.chargesUserId,
        time: this.mdt.jailTime,
        type: this.mdt.jailTimeType,
        reason: this.mdt.jailReason
      }
      post('sendtoJail', data)
      this.notify("success", this.info.sentToJail)

      this.mdt.chargesUserCitizen = ""

      this.mdt.jailTime = ""

      this.mdt.jailTimeType = "minute"

      this.mdt.jailReason = ""

    },

    sendToCrime(){

      if(this.mdt.chargesUserCitizen == "" || this.mdt.chargesUserId == "" || this.mdt.crimePrice == "" || this.mdt.crimeReason == "") return

      let data = {
        citizen: this.mdt.chargesUserCitizen,
        id: this.mdt.chargesUserId,
        price: this.mdt.crimePrice,
        reason: this.mdt.crimeReason
      }
      this.notify("success", this.info.issuedCharge)

      post('createCharge', data)
      
      this.mdt.chargesUserCitizen = ""
      this.mdt.chargesUserId = ""
      this.mdt.crimePrice = ""
      this.mdt.crimeReason = ""
    },

    sendToPublic(){

      if(this.mdt.chargesUserCitizen == "" || this.mdt.chargesUserId == "" || this.mdt.publicReason == "" || this.mdt.publicAmount == "") return

      let data = {
        citizen: this.mdt.chargesUserCitizen,
        id: this.mdt.chargesUserId,
        amount: this.mdt.publicAmount,
        reason: this.mdt.publicReason
      }
      this.notify("success", this.info.sentToPublic)
      post('sendtoCommunityService', data)
      this.mdt.chargesUserCitizen = ""
      this.mdt.publicReason = ""
      this.mdt.publicAmount = ""
    },

    chargesUserClearData(){

      this.mdt.jailTime = ""

      this.mdt.jailTimeType = "minute"

      this.mdt.jailReason = ""

      this.mdt.crimePrice = ""

      this.mdt.crimeReason = ""

      this.mdt.publicReason = ""

      this.mdt.publicAmount = ""

    },

        //Yeni eklendi
    // Bolos

    clearBolos() {
      this.mdt.bolosList.forEach((element) => {
        element.active = false
      })
      this.mdt.bolosDetail = ""
      this.mdt.bolosDetails = false
      this.mdt.bolosNew = false
      this.mdt.bolosName = ""
      this.mdt.bolosUser = ""
      this.mdt.bolosPersonDefinition = ""
      this.mdt.bolosEventDefinition = ""
      this.mdt.bolosCarDefinition = ""
      this.mdt.bolosPlate = ""
      this.mdt.bolosType = "personel"
    },
    selectBolo(item) {
      if (item.active) {
        item.active = false
        this.mdt.bolosDetails = false
        return
      }
      this.mdt.bolosList.forEach((element) => {
        element.active = false
      })
      item.active = true
      this.mdt.bolosDetail = item.id
      this.mdt.bolosNew = false
      this.mdt.bolosDetails = true
    },
    getBoloInfo(id, type) {
      if (id == "") return
      let index = this.mdt.bolosList.findIndex((x) => x.id === id)
      if (index == -1) return
      let data = this.mdt.bolosList[index]
      if (type == "boloName") return data.boloName
      if (type == "showId") return data.showId
      if (type == "name") return data.name
      if (type == "personDef") return data.personDefinition
      if (type == "eventDef") return data.eventDefinition
      if (type == "carDef") return data.carDefinition
      if (type == "plate") return data.plate
      if (type == "type") return data.boloType
    },
    selectNewBolo() {
      this.clearBolos()
      this.mdt.bolosNew = !this.mdt.bolosNew
    },
    bolosId() {
      const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      const numbers = "0123456789"

      let randomLetter = letters[Math.floor(Math.random() * letters.length)]
      let randomLetter2 = letters[Math.floor(Math.random() * letters.length)]
      let randomNumber = Math.floor(Math.random() * 100)
        .toString()
        .padStart(2, "0")

      let generatedId = randomLetter + randomLetter2 + randomNumber
      return generatedId
    },
    createBolo() {
      if (this.mdt.bolosName == "") return
      if(this.mdt.bolosType == "personel"){
        if (this.mdt.bolosPersonDefinition == "" ) return
      }
      if(this.mdt.bolosType == "other"){
        if (this.mdt.bolosEventDefinition == "" ) return
      }
      if(this.mdt.bolosType == "car"){
        if (this.mdt.bolosCarDefinition == "" ) return
      }
      let bolo = {
        active: false,
        id: this.randomId(),
        boloName: this.mdt.bolosName,
        showId: this.bolosId(),
        name: (this.mdt.bolosUser == "") ? this.info.noDef : this.mdt.bolosUser,
        personDefinition: (this.mdt.bolosPersonDefinition == "") ? this.info.noDef : this.mdt.bolosPersonDefinition,
        eventDefinition: (this.mdt.bolosEventDefinition == "") ? this.info.noDef : this.mdt.bolosEventDefinition,
        carDefinition: (this.mdt.bolosCarDefinition == "") ? this.info.noDef : this.mdt.bolosCarDefinition,
        plate: (this.mdt.bolosPlate == "") ? this.info.noDef : this.mdt.bolosPlate,
        boloType: this.mdt.bolosType,
      }
      this.mdt.bolosList.push(bolo)
      post('addBolo', bolo)
      this.clearBolos()
    },
    deleteBolo() {
      if (this.mdt.bolosDetail == "") return
      let index = this.mdt.bolosList.findIndex((x) => x.id === this.mdt.bolosDetail)
      post('removeBolo', this.mdt.bolosList[index])
      this.mdt.bolosList.splice(index, 1)
      this.clearBolos()
    },

    // Reports

    clearReports() {
      this.mdt.reportList.forEach((element) => {
        element.active = false
      })
      this.mdt.reportsDetail = ""
      this.mdt.reportsDetails = false
      this.mdt.reportsNew = false
      this.mdt.reportsName = ""
      this.mdt.reportsDesc = ""
      this.mdt.reporstLoaction = ""
      this.mdt.reportsType = "traffic"
    },
    selectReport(item) {
      if (item.active) {
        item.active = false
        this.mdt.reportsDetails = false
        return
      }
      this.mdt.reportList.forEach((element) => {
        element.active = false
      })
      item.active = true
      this.mdt.reportsDetail = item.id
      this.mdt.reportsNew = false
      this.mdt.reportsDetails = true
    },
    getReportInfo(id, type) {
      if (id == "") return
      let index = this.mdt.reportList.findIndex((x) => x.id === id)
      if (index == -1) return
      let data = this.mdt.reportList[index]
      if (type == "name") return data.name
      if (type == "desc") return data.description
      if (type == "user") return data.user
      if (type == "rank") return data.userRank
      if (type == "locationName") return data.locationName
      if (type == "type") return data.type
    },
    selectNewReport() {
      this.clearReports()
      this.mdt.reportsNew = !this.mdt.reportsNew
    },
    selectLocation() {
      if(this.mdt.reportsDetail == "") return
      let index = this.mdt.reportList.findIndex((x) => x.id === this.mdt.reportsDetail)
      post('navigateLocation', this.mdt.reportList[index].location)
    },
    createReport() {
      if (this.mdt.reportsName == "" || this.mdt.reportsDesc == "") return
      fetch(`https://dusa_mdt/getLocation`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({}),
      }).then((data) => data.json()).then((data) => {
        if (data === false) {
          return;
        }
        let defaultLocation = data.street
        let report = {
          active: false,
          id: this.randomId(),
          name: this.mdt.reportsName,
          user: this.mdt.profil.name,
          userRank: this.mdt.profil.rank,
          description: this.mdt.reportsDesc,
          location: data.coords,
          locationName: (this.mdt.reporstLoaction == "") ? defaultLocation : this.mdt.reporstLoaction,
          type: this.mdt.reportsType,
        }
        post('addReport', report)
        this.mdt.reportList.push(report)
        this.clearReports()
      })
    },
    deleteReport() {
      if (this.mdt.reportsDetail == "") return
      let index = this.mdt.reportList.findIndex((x) => x.id === this.mdt.reportsDetail)
      post('removeReport', this.mdt.reportList[index])
      this.mdt.reportList.splice(index, 1)
      this.clearReports()
    },

    // Dispatch
    markLocationDispatch(item){
      post('navigateDispatch', item.location)
    },
    deleteDispatch(item){
      let index = this.mdt.dispatchList.findIndex((x) => x.id === item.id)
      post('removeDispatch', item)
      this.mdt.dispatchList.splice(index, 1)
    },
    updateNotifications() {
      const now = Date.now();
      for (let i = this.mdt.dispatchList.length - 1; i >= 0; i--) {
        const notification = this.mdt.dispatchList[i];
        const difference = now - notification.time;
        if (difference >= (this.mdt.dispatchDeleteTime * 60 * 1000)) {
          post('removeDispatch', notification)
          this.mdt.dispatchList.splice(i, 1);
        }
      }
    },

    //Yeni eklendi
    //Serial Number
    searchGunList: function () {
      if (this.mdt.searchGunList.length < 3) return this.notify("error", this.info.serialTooShort);
      if (this.mdt.gunList.some(f => f.serialNumber === this.mdt.searchGunList)) return this.notify("error", this.info.alreadySearchedSerial);
      
      fetch(`https://dusa_mdt/searchSerial`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({
          id: this.mdt.searchGunList,
        }),
      })
      .then((serial) => serial.json())
      .then((serial) => {
        if (serial === false || serial === null) {
          this.notify("error", this.info.serialNotFound);
          this.mdt.searchGunList = ""
          return;
        }
        if (!this.mdt.gunList.some(f => f.serialNumber === serial.serialNumber)) {
          this.mdt.gunList.push(serial);
        }
      });
    },
    searchFingerList: function () {
      if (this.mdt.searchFingerList.length < 3) return this.notify("error", this.info.fingerprintTooShort);
      if (this.mdt.fingerList.some(f => f.fingerNo === this.mdt.searchFingerList)) return this.notify("error", this.info.alreadySearchedFingerprint);
      
      fetch(`https://dusa_mdt/searchFingerprint`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({
          id: this.mdt.searchFingerList,
        }),
      })
      .then((fingerprint) => fingerprint.json())
      .then((fingerprint) => {
        if (fingerprint === false || fingerprint === null) {
          this.notify("error", this.info.fingerprintNotFound);
          this.mdt.searchFingerList = ""
          return;
        }
        if (!this.mdt.fingerList.some(f => f.fingerNo === fingerprint.fingerNo)) {
          this.mdt.fingerList.push(fingerprint);
        }
      });
    },
    selectSerialNumber: function(item, type){
      if (item.selected) {
        this.mdt.serialNumberDetail = false
        this.mdt.serialNumberActive = ""
        this.mdt.serialNumberTypes = ""
        item.selected = false
        return
      }
      if(type == "gun"){
        this.mdt.serialNumberActive = item.serialNumber
      }
      if(type == "finger"){
        this.mdt.serialNumberActive = item.fingerNo
      }
      this.mdt.serialNumberDetail = true
      this.mdt.serialNumberTypes = type
      this.mdt.gunList.forEach((element) => {
        element.selected = false
      })
      this.mdt.fingerList.forEach((element) => {
        element.selected = false
      })
      item.selected = true
    },
    getSerialGunInfo: function(serialNumber, type){
      if (serialNumber == "") return
      if (this.mdt.serialNumberTypes !== "gun") return
      let index = this.mdt.gunList.findIndex((x) => x.serialNumber === serialNumber)
      let data = this.mdt.gunList[index]
      if (type == "serialNumber") return data.serialNumber
      if (type == "citizen") return data.citizenId
      if (type == "model") return data.model
      if (type == "gunImg") return data.img
      if (type == "owner") return data.owner
      if (type == "img") return data.ownerImage
      if (type == "info") return data.infoList
    },
    getSerialFingerInfo: function(fingerNo, type){
      if (fingerNo == "") return
      if (this.mdt.serialNumberTypes !== "finger") return
      let index = this.mdt.fingerList.findIndex((x) => x.fingerNo === fingerNo)
      let data = this.mdt.fingerList[index]
      if (type == "fingerNo") return data.fingerNo
      if (type == "citizen") return data.citizenId
      if (type == "owner") return data.owner
      if (type == "img") return data.ownerImage
      if (type == "info") return data.infoList
    },

    //-----------------------------------------------

    // Notify
    notify: function (type, text) {
      let notify = document.querySelector(".notify-cont")
      let delayA = this.notifyDelay / 1000 - 1
      if (type === "error") {
        var number = Math.floor(Math.random() * 1000 + 1)
        notify.insertAdjacentHTML(
          "beforeend",
          `
          <div class="notify warning" id="notify-${number}">
                <div class="notify-inner">
                <div class="notify-border">
                  <svg width="4" height="61" viewBox="0 0 4 61" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <rect x="-11" width="15" height="61" rx="3.57895"/>
                  </svg>
                </div>
                  <div class="notify-icon">
                    <svg width="53" height="53" viewBox="0 0 53 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path
                        d="M0 4.10823C0 1.83931 1.83932 0 4.10823 0H47.9293C50.1982 0 52.0376 1.83932 52.0376 4.10823V47.9293C52.0376 50.1982 50.1982 52.0376 47.9293 52.0376H4.10823C1.83931 52.0376 0 50.1982 0 47.9293V4.10823Z"
                        fill="#FF002E"
                        fill-opacity="0.12"
                      />
                      <path
                        d="M39.7293 35.0998L28.0179 14.7611C27.7252 14.2628 27.3074 13.8497 26.8059 13.5626C26.3043 13.2755 25.7365 13.1245 25.1586 13.1245C24.5808 13.1245 24.0129 13.2755 23.5114 13.5626C23.0099 13.8497 22.5921 14.2628 22.2994 14.7611L10.5879 35.0998C10.3064 35.5818 10.158 36.1299 10.158 36.6881C10.158 37.2463 10.3064 37.7945 10.5879 38.2764C10.8769 38.7777 11.2939 39.1931 11.7964 39.48C12.2989 39.7669 12.8686 39.915 13.4472 39.9089H36.8701C37.4482 39.9145 38.0174 39.7662 38.5193 39.4794C39.0213 39.1925 39.4379 38.7773 39.7266 38.2764C40.0086 37.7947 40.1575 37.2467 40.158 36.6885C40.1584 36.1303 40.0105 35.582 39.7293 35.0998ZM24.0873 23.8383C24.0873 23.5542 24.2001 23.2817 24.4011 23.0808C24.602 22.8798 24.8745 22.767 25.1586 22.767C25.4428 22.767 25.7153 22.8798 25.9162 23.0808C26.1171 23.2817 26.23 23.5542 26.23 23.8383V29.1952C26.23 29.4794 26.1171 29.7519 25.9162 29.9528C25.7153 30.1537 25.4428 30.2666 25.1586 30.2666C24.8745 30.2666 24.602 30.1537 24.4011 29.9528C24.2001 29.7519 24.0873 29.4794 24.0873 29.1952V23.8383ZM25.1586 35.6234C24.8408 35.6234 24.5301 35.5292 24.2658 35.3526C24.0015 35.176 23.7955 34.925 23.6739 34.6314C23.5523 34.3377 23.5204 34.0146 23.5824 33.7029C23.6445 33.3911 23.7975 33.1048 24.0223 32.88C24.247 32.6553 24.5334 32.5022 24.8451 32.4402C25.1568 32.3782 25.48 32.41 25.7736 32.5317C26.0673 32.6533 26.3183 32.8593 26.4948 33.1236C26.6714 33.3878 26.7657 33.6985 26.7657 34.0164C26.7657 34.4426 26.5964 34.8514 26.295 35.1527C25.9936 35.4541 25.5848 35.6234 25.1586 35.6234Z"
                        fill="#FF002E"
                      />
                    </svg>
                  </div>
                  <div class="notify-text">
                    <h2>${this.info.warning}</h2>
                    <p>${text}</p>
                  </div>
                </div>
            </div>
          `
        )
        // Delete İtem And Anim
        let item = document.getElementById("notify-" + number)
        gsap.to(item, { left: "-2vw", duration: 0.5, ease: "power2.out" })
        gsap.to(item, { left: "20vw", duration: 0.5, ease: "power2.out", delay: delayA })
        setTimeout(() => {
          item.remove()
        }, this.notifyDelay)
      } else if (type === "info") {
        var number = Math.floor(Math.random() * 1000 + 1)
        notify.insertAdjacentHTML(
          "beforeend",
          `
          <div class="notify info" id="notify-${number}">
          <div class="notify-inner">
              <div class="notify-border">
              <svg width="4" height="61" viewBox="0 0 4 61" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <rect x="-11" width="15" height="61" rx="3.57895"/>
              </svg>
              </div>
              <div class="notify-icon">
              <svg width="53" height="53" viewBox="0 0 53 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M0.842041 4.98371C0.842041 2.7148 2.68136 0.875488 4.95027 0.875488H48.7714C51.0403 0.875488 52.8796 2.7148 52.8796 4.98372V48.8048C52.8796 51.0737 51.0403 52.913 48.7714 52.913H4.95027C2.68135 52.913 0.842041 51.0737 0.842041 48.8048V4.98371Z" fill="#0075FF" fill-opacity="0.12"/>
                  <path d="M26.1761 13.2C23.3323 13.2 20.5523 14.0433 18.1877 15.6232C15.8231 17.2032 13.9801 19.4488 12.8919 22.0762C11.8036 24.7036 11.5188 27.5947 12.0736 30.3839C12.6284 33.1731 13.9979 35.7352 16.0088 37.7461C18.0197 39.757 20.5818 41.1265 23.371 41.6813C26.1602 42.2361 29.0513 41.9513 31.6787 40.863C34.306 39.7747 36.5517 37.9318 38.1317 35.5672C39.7116 33.2026 40.5549 30.4226 40.5549 27.5788C40.5509 23.7665 39.0347 20.1115 36.339 17.4159C33.6434 14.7202 29.9884 13.204 26.1761 13.2ZM25.6231 19.8363C25.9512 19.8363 26.272 19.9336 26.5448 20.1159C26.8177 20.2982 27.0303 20.5574 27.1559 20.8605C27.2815 21.1637 27.3143 21.4973 27.2503 21.8191C27.1863 22.1409 27.0283 22.4365 26.7963 22.6686C26.5642 22.9006 26.2686 23.0586 25.9468 23.1226C25.6249 23.1867 25.2913 23.1538 24.9882 23.0282C24.685 22.9026 24.4259 22.69 24.2436 22.4172C24.0613 22.1443 23.964 21.8236 23.964 21.4954C23.964 21.0554 24.1388 20.6334 24.4499 20.3223C24.7611 20.0111 25.1831 19.8363 25.6231 19.8363ZM27.2822 35.3212C26.6955 35.3212 26.1328 35.0881 25.718 34.6733C25.3031 34.2584 25.0701 33.6958 25.0701 33.1091V27.5788C24.7767 27.5788 24.4954 27.4622 24.288 27.2548C24.0805 27.0474 23.964 26.766 23.964 26.4727C23.964 26.1794 24.0805 25.898 24.288 25.6906C24.4954 25.4832 24.7767 25.3666 25.0701 25.3666C25.6568 25.3666 26.2194 25.5997 26.6343 26.0146C27.0491 26.4294 27.2822 26.9921 27.2822 27.5788V33.1091C27.5755 33.1091 27.8569 33.2256 28.0643 33.433C28.2717 33.6404 28.3883 33.9218 28.3883 34.2151C28.3883 34.5085 28.2717 34.7898 28.0643 34.9972C27.8569 35.2047 27.5755 35.3212 27.2822 35.3212Z" fill="#0075FF"/>
              </svg>              
              </div>
              <div class="notify-text">
                  <h2> ${this.info.info} </h2>
                  <p> ${text} </p>
              </div>
          </div>
      </div>
          `
        )
        // Delete İtem And Anim
        let item = document.getElementById("notify-" + number)
        gsap.to(item, { left: "-2vw", duration: 0.5, ease: "power2.out" })
        // gsap.to(item, { left: "20vw", duration: 0.5, ease: "power2.out", delay: delayA })
        setTimeout(() => {
          item.remove()
        }, this.notifyDelay)
      } else if (type === "success") {
        var number = Math.floor(Math.random() * 1000 + 1)
        notify.insertAdjacentHTML(
          "beforeend",
          `
          <div class="notify success" id="notify-${number}">
          <div class="notify-inner">
          <div class="notify-border">
          <svg width="4" height="61" viewBox="0 0 4 61" fill="none" xmlns="http://www.w3.org/2000/svg">
              <rect x="-11" width="15" height="61" rx="3.57895"/>
          </svg>
          </div>
              <div class="notify-icon">
              <svg width="53" height="53" viewBox="0 0 53 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M0.842041 4.98371C0.842041 2.7148 2.68136 0.875488 4.95027 0.875488H48.7714C51.0403 0.875488 52.8796 2.7148 52.8796 4.98372V48.8048C52.8796 51.0737 51.0403 52.913 48.7714 52.913H4.95027C2.68135 52.913 0.842041 51.0737 0.842041 48.8048V4.98371Z" fill="#3BDA4B" fill-opacity="0.12"/>
                  <path d="M39.2499 23.0151C38.9683 22.696 38.6221 22.4404 38.2342 22.2654C37.8462 22.0905 37.4255 22 36.9999 22.0001H29.9999V20.0001C29.9999 18.674 29.4732 17.4022 28.5355 16.4645C27.5978 15.5269 26.326 15.0001 24.9999 15.0001C24.8142 14.9999 24.632 15.0516 24.4739 15.1492C24.3158 15.2467 24.1881 15.3864 24.1049 15.5526L19.3824 25.0001H13.9999C13.4695 25.0001 12.9608 25.2108 12.5857 25.5859C12.2106 25.9609 11.9999 26.4696 11.9999 27.0001V38.0001C11.9999 38.5305 12.2106 39.0392 12.5857 39.4143C12.9608 39.7894 13.4695 40.0001 13.9999 40.0001H35.4999C36.2308 40.0003 36.9367 39.7338 37.4849 39.2504C38.0331 38.7671 38.3861 38.1002 38.4774 37.3751L39.9774 25.3751C40.0306 24.9526 39.9932 24.5237 39.8678 24.1167C39.7424 23.7098 39.5317 23.3343 39.2499 23.0151ZM13.9999 27.0001H18.9999V38.0001H13.9999V27.0001Z" fill="#3BDA4B"/>
              </svg>              
              </div>
              <div class="notify-text">
                  <h2> ${this.info.success} </h2>
                  <p> ${text} </p>
              </div>
          </div>
      </div>
          `
        )
        // Delete İtem And Anim
        let item = document.getElementById("notify-" + number)
        gsap.to(item, { left: "-2vw", duration: 0.5, ease: "power2.out" })
        gsap.to(item, { left: "20vw", duration: 0.5, ease: "power2.out", delay: delayA })
        setTimeout(() => {
          item.remove()
        }, this.notifyDelay)
      }
    },
  },
  computed: {
    sortedMessageList: function () {
      return this.mdt.messageList.slice().sort((a, b) => {
        const dateA = new Date(a.date + " " + a.time).getTime()
        const dateB = new Date(b.date + " " + b.time).getTime()

        return dateA - dateB // Compare timestamps in reverse order
      })
    },
    searchCommandList: function () {
      return this.mdt.commandsList.filter((item) => {
        return item.code.toLowerCase().includes(this.mdt.commandSearch.toLowerCase()) || item.user.toLowerCase().includes(this.mdt.commandSearch.toLowerCase())
      })
    },
    searchCrimesList: function () {
      return this.mdt.crimesList.filter((item) => {
        return item.name.toLowerCase().includes(this.mdt.crimeSearch.toLowerCase()) || item.code.toLowerCase().includes(this.mdt.crimeSearch.toLowerCase())
      })
    },
    onlinePoliceCount: function () {
      return this.mdt.policeList.filter((x) => x.status === "Online").length
    },
    offlinePoliceCount: function () {
      return this.mdt.policeList.filter((x) => x.status === "Offline").length
    },
    sortedFormsList: function () {
      return this.mdt.formsList.slice().sort((a, b) => {
        const dateA = new Date(a.date + " " + a.time).getTime()
        const dateB = new Date(b.date + " " + b.time).getTime()

        return dateB - dateA // Compare timestamps in reverse order
      })
    },
    // Yeni eklendi
    searchBolosList: function () {
      return this.mdt.bolosList.filter((item) => {
        return item.boloName.toLowerCase().includes(this.mdt.bolosSearch.toLowerCase()) || item.showId.toLowerCase().includes(this.mdt.bolosSearch.toLowerCase())
      })
    },
    searchReportsList: function () {
      return this.mdt.reportList.filter((item) => {
        return item.name.toLowerCase().includes(this.mdt.searchReports.toLowerCase()) || item.type.toLowerCase().includes(this.mdt.searchReports.toLowerCase())
      })
    },
    // --------------------------------------
    searchUserList: function () {
      return this.mdt.userList.filter((item) => {
        return item.user.toLowerCase().includes(this.mdt.userSearch.toLowerCase()) || item.citizen.toLowerCase().includes(this.mdt.userSearch.toLowerCase())
      })
    },
    searchWantedList: function () {
      return this.mdt.userList.filter((item) => {
        return item.wanted === true
      })
    },
    searchAllCars: function () {
      return this.mdt.carsList.filter((item) => {
        return (
          item.plate.toLowerCase().includes(this.mdt.carsAllSearch.toLowerCase())
        )
      })
    },
    searchWantedCars: function () {
      return this.mdt.carsList.filter((item) => {
        if (item.wanted) {
          if (this.getUserInfo(item.citizen, "name") == undefined || this.getUserInfo(item.citizen, "name") == null || this.getUserInfo(item.citizen, "name") == 'null') return
          return (
            this.getUserInfo(item.citizen, "name").toLowerCase().includes(this.mdt.carsWantedSearch.toLowerCase()) ||
            item.plate.toLowerCase().includes(this.mdt.carsWantedSearch.toLowerCase())
          )
        }
      })
    },
    searchHouseList: function () {
      return this.mdt.housesList.filter((item) => {
        return (
          item.address.toLowerCase().includes(this.mdt.houseSearch.toLowerCase()) ||
          item.name.toLowerCase().includes(this.mdt.houseSearch.toLowerCase())
        )
      })
    },
    searchLicanseList: function () {
      if (this.mdt.userDetail == "") return
      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.userDetail)
      return this.mdt.userList[index].licanse.filter((item) => {
        return item.name.toLowerCase().includes(this.mdt.licanseSearch.toLowerCase())
      })
    },
    searchIndicentList: function () {
      return this.mdt.incidentsList.filter((item) => {
        return (
          item.name.toLowerCase().includes(this.mdt.incidentsSearch.toLowerCase()) ||
          item.id.toLowerCase().includes(this.mdt.incidentsSearch.toLowerCase()) ||
          this.getUserInfo(item.userCitizen, "name").toLowerCase().includes(this.mdt.incidentsSearch.toLowerCase())
        )
      })
    },
    searchIncidentUserList: function () {
      if (this.mdt.incidentsDetail == "") return
      // if(this.mdt.incidentsUserSearch == "") return
      return this.mdt.userList.filter((item) => {
        let findIndex = this.mdt.incidentsList.findIndex((x) => x.id === this.mdt.incidentsDetail)
        let data = this.mdt.incidentsList[findIndex]
        let findUser = data.addedCitizen.find((x) => x === item.citizen)
        if (findUser) return
        return item.user.toLowerCase().includes(this.mdt.incidentsUserSearch.toLowerCase()) || item.citizen.toLowerCase().includes(this.mdt.incidentsUserSearch.toLowerCase())
      })
    },
    searchNewIncidentUserList: function () {
      return this.mdt.userList.filter((item) => {
        let findIndex = this.mdt.incidentsAddedCitizen.findIndex((x) => x === item.citizen)
        if (findIndex !== -1) return
        return item.user.toLowerCase().includes(this.mdt.incidentsUserSearchNew.toLowerCase()) || item.citizen.toLowerCase().includes(this.mdt.incidentsUserSearchNew.toLowerCase())
      })
    },
    searchEvidenceList: function () {
      return this.mdt.evidencesList.filter((item) => {
        return (
          item.name.toLowerCase().includes(this.mdt.evidencesSearch.toLowerCase()) ||
          item.id.toLowerCase().includes(this.mdt.evidencesSearch.toLowerCase()) ||
          this.getUserInfo(item.userCitizen, "name").toLowerCase().includes(this.mdt.evidencesSearch.toLowerCase())
        )
      })
    },
    searchEvidenceUserList: function () {
      if (this.mdt.evidencesDetail == "") return
      return this.mdt.userList.filter((item) => {
        let findIndex = this.mdt.evidencesList.findIndex((x) => x.id === this.mdt.evidencesDetail)
        let data = this.mdt.evidencesList[findIndex]
        let findUser = data.addedCitizen.find((x) => x === item.citizen)
        if (findUser) return
        return item.user.toLowerCase().includes(this.mdt.evidencesUserSearch.toLowerCase()) || item.citizen.toLowerCase().includes(this.mdt.evidencesUserSearch.toLowerCase())
      })
    },
    searchNewEvidenceUserList: function () {
      return this.mdt.userList.filter((item) => {
        let findIndex = this.mdt.evidencesAddedCitizen.findIndex((x) => x === item.citizen)
        if (findIndex !== -1) return
        return item.user.toLowerCase().includes(this.mdt.evidencesUserSearchNew.toLowerCase()) || item.citizen.toLowerCase().includes(this.mdt.evidencesUserSearchNew.toLowerCase())
      })
    },
    
    licanseAddList: function () {

      if(this.mdt.userDetail == "") return

      let index = this.mdt.userList.findIndex((x) => x.citizen === this.mdt.userDetail)

      return this.mdt.licanseList.filter((item) => {

        let findLicanse = this.mdt.userList[index].licanse.find((x) => x.type === item.type)

        if(findLicanse) return

        return item

      })

    },

    searchNearList: function () {
      return this.mdt.nearList.filter((item) => {
        return item.citizen.toLowerCase().includes(this.mdt.chargesUserSearch.toLowerCase())

      })

    },

    // Yeni Eklendi
    getActiveLanguageName(){
      let index = this.mdt.languageList.findIndex(x => x.code === this.mdt.mdtLanguage)
      if(index == -1) return this.info.select
      return this.mdt.languageList[index].name
    },
    //----------------------------

  },
  watch: {
    "mdt.messageList": {
      handler: function (val, oldVal) {
        this.$nextTick(function () {
          let messageList = document.querySelector(".chat-screen")
          messageList.scrollTop = messageList.scrollHeight
        })
      },
      deep: true,
    },
    "mdt.wantedAddCrimes": {
      handler: function () {
        let container = document.getElementById("wanted-add")
        // scroll bottom
        setTimeout(() => {
          container.scrollTop = container.scrollHeight
        }, 100)
      },
      deep: true,
    },
    "mdt.wantedAddEvidence": {
      handler: function () {
        let container = document.getElementById("evidence-input")
        // scroll bottom
        setTimeout(() => {
          container.focus()
        }, 100)
      },
      deep: true,
    },
    "mdt.mdtLanguage": {
      handler: function () {
        fetch(`./locales/${this.mdt.mdtLanguage}.json`)
          .then((response) => response.json())
          .then((data) => {
            for (let key in data) {
              this.info[key] = data[key];
            }
          })
      },
      deep: true,
    },
    "mdt.mdtRouter": {
      handler: function () {
        if (this.mdt.mdtRouter == "dashboard") {
          setTimeout(() => {
            let messageList = document.querySelector(".chat-screen")
            messageList.scrollTop = messageList.scrollHeight
            fetch(`https://dusa_mdt/getChat`, {
              method: "POST",
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
              },
              body: JSON.stringify({}),
            })
            .then((chat) => chat.json())
            .then((chat) => {
              if (chat === false) {
                return;
              }
              this.mdt.messageList = JSON.parse(chat);
            });
          }, 100)
        }
        if (this.mdt.mdtRouter == "livemap" && !this.mdt.firsInstallMap) {
          setTimeout(() => {
            installMap()
            this.mdt.firsInstallMap = true
          }, 150)
        }
        if (this.mdt.mdtRouter == "dispatch") {
          fetch(`https://dusa_mdt/getDispatch`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({})
          })
          .then((dispatch) => dispatch.json())
          .then((dispatch) => {
            this.mdt.dispatchList = []
            if (dispatch === false) {
              return;
            }
            if (typeof dispatch === "string") { dispatch = JSON.parse(dispatch); }
            dispatch.forEach((alert) => {
              alert.time = Date.now()
              if (!this.mdt.dispatchList.some((item) => item.id === alert.id)) {
                this.mdt.dispatchList.push({
                  id: alert.id,
                  gameId: alert.gameId,
                  code: alert.code,
                  menu: false,
                  iconList: alert.iconList,
                  location: alert.location,
                  time: alert.time,
                  img: alert.img,
                  message: alert.message,
                  imgOpen: false,
                });
              }
            })
          });
        }
        this.mdt.userList.forEach((element) => {
          element.selected = false
        })
        this.mdt.wantedDetail = ""
        this.mdt.wantedDetails = false
        this.mdt.wantedAddCrimes = false
        this.mdt.wantedAddCrimesValue = ""
        this.mdt.userDetail = ""
        this.mdt.userSearch = ""
        this.mdt.userDetails = false
      },
      deep: true,
    },
    
    "mdt.jailTime": {

      handler: function () {

        if (this.mdt.jailTime < 0) {

          this.mdt.jailTime = 0

        }

      },

      deep: true,

    },

    "mdt.crimePrice":{

      handler: function () {

        if (this.mdt.crimePrice < 0) {

          this.mdt.crimePrice = 0

        }

      },

      deep: true,

    },

    "mdt.publicAmount": {

      handler: function () {

        if (this.mdt.publicAmount < 0) {

          this.mdt.publicAmount = 0

        }

      },

      deep: true,

    },

    "mdt.chargesRouter": {

      handler: function () {

        this.chargesUserClearData()

      },

      deep: true,

    },

    "mdt.formRouter": {
      handler: function () {
        if(this.mdt.formRouter == "detailForm"){
          return
        } else{
          this.mdt.formDetail = ""
        }
      },
      deep: true,
    },
    "mdt.userSearch": {
      handler: function () {
        // Yeni eklendi 
        // Eğer arama yeri boşa datayı boşaltır hiç bir şey gözükmez
        if(this.mdt.userSearch == ""){
          this.mdt.citizenList = []
        }
      },
      deep: true,
    },
    "mdt.searchFingerList": {
      handler: function () {
        // Yeni eklendi 
        // Eğer arama yeri boşa datayı boşaltır hiç bir şey gözükmez
        if(this.mdt.searchFingerList == ""){
          this.mdt.serialNumberDetail = false
          this.mdt.serialNumberActive = ""
          this.mdt.serialNumberTypes = ""
          this.mdt.fingerList = []
        }
      },
      deep: true,
    },
    "mdt.searchGunList": {
      handler: function () {
        // Yeni eklendi 
        // Eğer arama yeri boşa datayı boşaltır hiç bir şey gözükmez
        if(this.mdt.searchGunList == ""){
          this.mdt.serialNumberDetail = false
          this.mdt.serialNumberActive = ""
          this.mdt.serialNumberTypes = ""
          this.mdt.gunList = []
        }
      },
      deep: true,
    },
    "mdt.carsAllSearch": {
      handler: function () {
        // Yeni eklendi 
        // Eğer arama yeri boşa datayı boşaltır hiç bir şey gözükmez
        if(this.mdt.carsAllSearch == ""){
          this.mdt.carDetails = false
          this.mdt.carsList.forEach((element) => {
            if(!element.wanted){
              // Wanted olmayanları siler
              this.mdt.carsList = this.mdt.carsList.filter((x) => x.plate !== element.plate)
            }
          })
        }
      },
      deep: true,
    },
  },
})

// how to use xhrPost
// xhrPost("https://api.example.com", { name: "John", time: "2pm" }, function (response) {})


window.addEventListener("message", function (event) {
  let eventData = event.data;
  if (eventData.type == "openmdt") {
    app.framework = eventData.framework;
    app.mdt.defaultTheme = eventData.defaultTheme;
    app.setup('profile', eventData.profile)
    app.setup('grade')
    app.setup('camera', eventData.camera)
    app.setup('fines', eventData.fines)
    app.setup('commands', eventData.commands)
    app.setup('forms', eventData.forms)
    app.setup('bolos', eventData.bolos)
    app.setup('reports', eventData.reports)
    app.setup('users', eventData.users)
    app.setup('vehicles', eventData.wantedVehicles)
    app.setup('nearby', eventData.nearby)
    app.setup('police', eventData.police)
    app.setup('license', eventData.license)
    app.setup('house', eventData.house)
    app.setup('incident', eventData.incident)
    app.setup('evidence', eventData.evidence)
    app.setup('config', eventData.config)
    app.setup('settings', eventData.settings)
    app.mdt.enabled = true;
  } else if (eventData.type == "closemdt") {
    post("updateSettings", {language: app.mdt.mdtLanguage, theme: app.mdt.themeMode})
    post("close", JSON.stringify({}))
    app.mdt.enabled = false;
  } else if (eventData.type == "hidemdt") {
    let mdtclass = document.querySelector(".mdt")
    gsap.to(mdtclass, { opacity: 0, duration: 0.2, ease: "power2.out" })
  } else if (eventData.type == "showmdt") {
    let mdtclass = document.querySelector(".mdt")
    gsap.to(mdtclass, { opacity: 1, duration: 0.2, ease: "power2.out" })
  } else if (eventData.type == "disablecam") {
    app.camera.enabled = false
  } else if (eventData.type == "notify") {
    app.notify(eventData.ntype, eventData.message)
  }
});

// Yeni Eklendi
Vue.use(DropdownMenu);
// ----------------------------