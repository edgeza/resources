import React, {
  Context,
  createContext,
  useContext,
  useEffect,
  useState,
} from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { randomId } from "../utils/misc";

import { useUiEvent } from "../utils/useUiEvent";

export const DataContext = createContext();

export const DataProvider = ({ children }) => {
  const [data, setData] = useState({
    radar: {
      frontSpeed: 0,
      rearSpeed: 0,
      frontPlate: "34 ABC 34",
      lockSpeed: 0,
      lockSpeed2: 0,
      rearPlate: "40 DKR 55",
      speed: 0,
      toolbar: false,
      menuScale: 100,
      menuPosition: { x: 0, y: 0 },
      menuFırstColor: "#FFC736",
      menuSecondColor: "#FF3667",
      menuThirdColor: "#2CE7BB",
    },
    notify: [],
    notifyDeleteTime: 5000,
    radarSettings: {
      lock: true,
      fast: false,
      frontSame: true,
      frontOpp: false,
      rearSame: true,
      rearOpp: false,
      frontXmıt: true,
      rearXmıt: true,
      toogle: false,
    },
    dispatch: {
      name: "John Doe",
      citizenId: "828djJAd1",
      activeGps: "1H",
      activeRadio: "1900",
      gameId: "1",
      job: "ambulance", // police, ambulance
      jobRank: "Officer",
      callSign: "3914",
      dispatchManager: "",
      alertNot: false, // Bunu DATA DA TUT LÜTFEN MERTCİM LÜTFEN
      alertMute: false,
      alertNewNot: false,
      showAlertNot: true,
      menu: "dispatchList",
      saveData: "",
      alertSettingsKey: "O",
      alerAcceptKey: "G",
      jobColor: {
        police: "#1FA2EC",
        sheriff: "#DFB038",
        bcso: "#DF6A38",
        highway: "#FC5FFF",
        state: "#6AC9FF",
        ranger: "#0EB809",
        ambulance: "#FF3939",
      },
      jobAcces: {
        draw: true,
        bodycam: false,
        unitsEdit: false,
        dispatchEdit: true,
        createUnit: false,
        createGps: false,
        createRadio: false,
        createCamera: false,
        editCamera: false,
        selectManager: true,
      },
      mapFilter: {
        police: false,
        ambulance: true,
        sheriff: true,
        bcso: true,
        highway: true,
        state: false,
        ranger: true,
      },
      icons: [
        {
          name: "John BOTtttttttttttttttttttttttttttttttttttttttttttt",
          citizenId: "828djJAd1",
          id: "1",
          job: "ambulance",
          position: [0, 0],
          icon: "ambulanceBike",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd2",
          id: "2",
          job: "ambulance",
          position: [100, 0],
          icon: "ambulanceCar",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd3",
          id: "3",
          job: "ambulance",
          position: [0, 100],
          icon: "ambulanceCivil",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd4",
          id: "4",
          job: "ambulance",
          position: [200, 0],
          icon: "ambulanceHeli",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd5",
          id: "5",
          job: "police",
          position: [0, 300],
          icon: "policeCar",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd6",
          id: "6",
          job: "police",
          position: [300, 0],
          icon: "policeCivil",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd7",
          id: "7",
          job: "police",
          position: [0, 200],
          icon: "policeHeli",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd8",
          id: "8",
          job: "police",
          position: [200, 200],
          icon: "policeBike",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd8",
          id: "9",
          job: "bcso",
          position: [400, 600],
          icon: "bcsoHeli",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd8",
          id: "10",
          job: "sheriff",
          position: [600, 600],
          icon: "sheriffCar",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd8",
          id: "11",
          job: "highway",
          position: [-600, 600],
          icon: "highwayCar",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd8",
          id: "12",
          job: "state",
          position: [-600, -600],
          icon: "stateCar",
        },
        {
          name: "John Doe",
          citizenId: "828djJAd8",
          id: "13",
          job: "ranger",
          position: [-1000, 100],
          icon: "rangerBike",
        },
      ],
      bodyCamList: [
        { name: "John Dea 1", citizenId: "828djJAd1", gameId: "1" },
        { name: "John Dea 2", citizenId: "828djJAd2", gameId: "2" },
        { name: "John Dea 3", citizenId: "828djJAd3", gameId: "3" },
        { name: "John Dea 4", citizenId: "828djJAd4", gameId: "4" },
        { name: "John Dea 5", citizenId: "828djJAd5", gameId: "5" },
        { name: "John Dea 6", citizenId: "828djJAd6", gameId: "6" },
        { name: "John Dea 7", citizenId: "828djJAd7", gameId: "7" },
        { name: "John Dea 8", citizenId: "828djJAd8", gameId: "8" },
      ],
      gpsCommon: [
        {
          title: "Sheriff GPS",
          job: "sheriff",
          id: "1",
          item: [
            { name: "General 1", channelId: "1S" },
            { name: "General 2", channelId: "2S" },
            { name: "General 3", channelId: "3S" },
            { name: "General 4", channelId: "4S" },
          ],
        },
        {
          title: "Police GPS",
          job: "police",
          id: "2",
          item: [
            { name: "General 1", channelId: "1P" },
            { name: "General 2", channelId: "2P" },
            { name: "General 3", channelId: "3P" },
            { name: "General 4", channelId: "4P" },
          ],
        },
      ],
      gpsHeist: [
        {
          name: "Heist 1",
          everyone: false,
          owner: "John Doe",
          ownerJob: "police",
          ownerJobRank: "Officer",
          ownerCitizen: "828djJAd1",
          channelId: "1H",
          users: [
            {
              name: "John Doe",
              callSign: "3914",
              citizenId: "828djJAd1",
              job: "police",
            },
            {
              name: "John Dea 2",
              callSign: "4957",
              citizenId: "828dqjJAd41",
              job: "sheriff",
            },
            {
              name: "John Dea 3",
              callSign: "5013",
              citizenId: "828djgJAd1445",
              job: "bcso",
            },
            {
              name: "John Dea 4",
              callSign: "6415",
              citizenId: "828djJdAd161",
              job: "highway",
            },
          ],
        },
        {
          name: "Heist 2",
          everyone: false,
          owner: "John Doe",
          ownerJob: "sheriff",
          ownerJobRank: "Officer",
          ownerCitizen: "828djJA2",
          channelId: "2H",
          users: [
            {
              name: "John Doe",
              callSign: "3914",
              citizenId: "828djJAd2",
              job: "police",
            },
            {
              name: "John Dea 2",
              callSign: "0957",
              citizenId: "dqjJAd41",
              job: "sheriff",
            },
            {
              name: "John Dea 3",
              callSign: "1013",
              citizenId: "djgJAd1445",
              job: "bcso",
            },
            {
              name: "John Dea 4",
              callSign: "2415",
              citizenId: "djJdAd161",
              job: "highway",
            },
          ],
        },
      ],
      radioCommon: [
        {
          title: "Sheriff Radio",
          job: "sheriff",
          id: "1",
          item: [
            { name: "General 1", channelId: "1SR" },
            { name: "General 2", channelId: "2SR" },
            { name: "General 3", channelId: "3SR" },
            { name: "General 4", channelId: "4SR" },
          ],
        },
        {
          title: "Police Radio",
          job: "police",
          id: "2",
          item: [
            { name: "General 1", channelId: "1PR" },
            { name: "General 2", channelId: "2PR" },
            { name: "General 3", channelId: "3PR" },
            { name: "General 4", channelId: "4PR" },
          ],
        },
      ],
      cameraList: [
        {
          name: "Camera 1",
          adress: "Los Santos Police Department",
          id: "1",
          position: [0, 0],
          camİd: "1",
          type: "cam_1",
          icon: "camera",
          activeIcon: "cameraActive",
          active: false,
        },
        {
          name: "Camera 2",
          adress: "Los Santos Police Department",
          id: "2",
          position: [100, 0],
          camİd: "2",
          type: "cam_2",
          icon: "camera",
          activeIcon: "cameraActive",
          active: false,
        },
        {
          name: "Camera 3",
          adress: "Los Santos Police Department",
          id: "3",
          position: [0, 100],
          camİd: "3",
          type: "cam_3",
          icon: "camera",
          activeIcon: "cameraActive",
          active: false,
        },
        {
          name: "Camera 4",
          adress: "Los Santos Police Department",
          id: "4",
          position: [200, 0],
          camİd: "4",
          type: "cam_4",
          icon: "camera",
          activeIcon: "cameraActive",
          active: false,
        },
        {
          name: "Camera 5",
          adress: "Los Santos Police Department",
          id: "5",
          position: [0, 200],
          camİd: "5",
          type: "cam_5",
          icon: "camera",
          activeIcon: "cameraActive",
          active: false,
        },
        {
          name: "Camera 6",
          adress: "Los Santos Police Department",
          id: "6",
          position: [300, 0],
          camİd: "6",
          type: "cam_6",
          icon: "camera",
          activeIcon: "cameraActive",
          active: false,
        },
        {
          name: "Camera 7",
          adress: "Los Santos Police Department",
          id: "7",
          position: [0, 300],
          camİd: "7",
          type: "cam_7",
          icon: "camera",
          activeIcon: "cameraActive",
          active: false,
        },
        {
          name: "Camera 8",
          adress: "Los Santos Police Department",
          id: "8",
          position: [200, 200],
          camİd: "8",
          type: "cam_8",
          icon: "camera",
          activeIcon: "cameraActive",
          active: false,
        },
      ],
      cameraType: [
        { label: "cam_1", value: "cam_1" },
        { label: "cam_2", value: "cam_2" },
        { label: "cam_3", value: "cam_3" },
        { label: "cam_4", value: "cam_4" },
        { label: "cam_5", value: "cam_5" },
        { label: "cam_6", value: "cam_6" },
        { label: "cam_7", value: "cam_7" },
        { label: "cam_8", value: "cam_8" },
      ],
      alertNotif: [
        // {
        //   event: "SHOTSH FIRED",
        //   title: "Alert 1",
        //   description: "Alert 1 Description",
        //   img: "https://miro.medium.com/v2/resize:fit:700/0*A8oH-_FxDCbmZWCw.jpg",
        //   priority: "0",
        //   unitCount: "2",
        //   time: "12:00",
        //   code: "22-16",
        // },
        // {
        //   event: "SHOTSH FIRED",
        //   title: "Alert 2",
        //   description: "Alert 2 Description",
        //   img: "",
        //   priority: "1",
        //   unitCount: "1",
        //   time: "12:01",
        //   code: "22-17",
        // },
        // {
        //   event: "SHOTSH FIRED",
        //   title: "Alert 3",
        //   description: "Alert 3 Description",
        //   img: "",
        //   priority: "2",
        //   unitCount: "4",
        //   time: "12:02",
        //   code: "22-18",
        // },
      ],
      userList: [
        {
          name: "John Doee",
          citizenId: "828djJAd1",
          gameId: "1",
          job: "police",
          jobRank: "Officer",
        },
        {
          name: "John Dea 2",
          citizenId: "828djJAd2",
          gameId: "2",
          job: "sheriff",
          jobRank: "Officer",
        },
        {
          name: "John Dea 3",
          citizenId: "828djJAd3",
          gameId: "3",
          job: "bcso",
          jobRank: "Officer",
        },
        {
          name: "John Dea 4",
          citizenId: "828djJAd4",
          gameId: "4",
          job: "highway",
          jobRank: "Officer",
        },
        {
          name: "John Dea 5",
          citizenId: "828djJAd5",
          gameId: "5",
          job: "police",
          jobRank: "Officer",
        },
        {
          name: "John Dea 6",
          citizenId: "828djJAd6",
          gameId: "6",
          job: "police",
          jobRank: "Officer",
        },
        {
          name: "John Dea 7",
          citizenId: "828djJAd7",
          gameId: "7",
          job: "police",
          jobRank: "Officer",
        },
        {
          name: "John Dea 8",
          citizenId: "828djJAd8",
          gameId: "8",
          job: "police",
          jobRank: "Officer",
        },
      ],
      dispatchList: [],
      unitUserList: [
        {
          name: "John Doe",
          citizenId: "828djJAd1",
          gameId: "1",
          job: "police",
          jobRank: "Officer",
        },
        {
          name: "John Dea 2",
          citizenId: "828djJAd2",
          gameId: "2",
          job: "sheriff",
          jobRank: "Officer",
        },
        {
          name: "John Dea 3",
          citizenId: "828djJAd3",
          gameId: "3",
          job: "bcso",
          jobRank: "Officer",
        },
        {
          name: "John Dea 4",
          citizenId: "828djJAd4",
          gameId: "4",
          job: "highway",
          jobRank: "Officer",
        },
        {
          name: "John Dea 5",
          citizenId: "828djJAd5",
          gameId: "5",
          job: "police",
          jobRank: "Officer",
        },
        {
          name: "John Dea 6",
          citizenId: "828djJAd6",
          gameId: "6",
          job: "police",
          jobRank: "Officer",
        },
        {
          name: "John Dea 7",
          citizenId: "828djJAd7",
          gameId: "7",
          job: "police",
          jobRank: "Officer",
        },
        {
          name: "John Dea 8",
          citizenId: "828djJAd8",
          gameId: "8",
          job: "police",
          jobRank: "Officer",
        },
      ],
      unitList: [
        {
          name: "H-41",
          maxCount: 5,
          id: "1",
          dropId: "99131",
          active: false,
          userList: [],
        },
        {
          name: "H-42",
          maxCount: 5,
          id: "2",
          dropId: "99132",
          active: false,
          userList: [],
        },
        {
          name: "H-43",
          maxCount: 5,
          id: "3",
          dropId: "99133",
          active: false,
          userList: [],
        },
        {
          name: "H-44",
          maxCount: 5,
          id: "4",
          dropId: "99134",
          active: false,
          userList: [],
        },
        {
          name: "H-45",
          maxCount: 5,
          id: "5",
          dropId: "99135",
          active: false,
          userList: [],
        },
      ],
      radioHeist: [
        {
          name: "Heist 1RR",
          owner: "John Doe",
          ownerJob: "police",
          ownerJobRank: "Officer",
          ownerCitizen: "828djJAd1",
          channelId: "1900",
          users: [
            {
              name: "John Doe",
              callSign: "3914",
              citizenId: "828djJAd1",
              job: "police",
            },
            {
              name: "John Dea 2",
              callSign: "4957",
              citizenId: "828dqjJAd41",
              job: "sheriff",
            },
            {
              name: "John Dea 3",
              callSign: "5013",
              citizenId: "828djgJAd1445",
              job: "bcso",
            },
            {
              name: "John Dea 4",
              callSign: "6415",
              citizenId: "828djJdAd161",
              job: "highway",
            },
          ],
        },
        {
          name: "Heist 2R",
          owner: "John Doe",
          ownerJob: "sheriff",
          ownerJobRank: "Officer",
          ownerCitizen: "828djJA2",
          channelId: "2PR",
          users: [
            {
              name: "John Doe",
              callSign: "3914",
              citizenId: "828djJAd2",
              job: "police",
            },
            {
              name: "John Dea 2",
              callSign: "0957",
              citizenId: "dqjJAd41",
              job: "sheriff",
            },
            {
              name: "John Dea 3",
              callSign: "1013",
              citizenId: "djgJAd1445",
              job: "bcso",
            },
            {
              name: "John Dea 4",
              callSign: "2415",
              citizenId: "djJdAd161",
              job: "highway",
            },
          ],
        },
      ],
      draw: {
        drawnItems: [],
      },
      settingsUserList: [
        {
          label: "John Doee",
          value: "828djJAd1",
        },
        {
          label: "John Dea 2",
          value: "828djJAd2",
        },
        {
          label: "John Dea 3",
          value: "828djJAd3",
        },
        {
          label: "John Dea 4",
          value: "828djJAd4",
        },
        {
          label: "John Dea 5",
          value: "828djJAd5",
        },
        {
          label: "John Dea 6",
          value: "828djJAd6",
        },
        {
          label: "John Dea 7",
          value: "828djJAd7",
        },
        {
          label: "John Dea 8",
          value: "828djJAd8",
        },
      ],
    },
    bodyCam: {
      enable: false,
      name: "John Doe",
      code: "22-16",
      adress: "Los Santos Police Department",
      callSign: "3914",
      clock: "12:00",
      job: "Police",
      rank: "Officer",
      theme: "sheriff", //police, ambulance, sheriff
    },
  });
  const [uiData, setUiData] = useState({
    dispatch: {
      groupTitle: "",
      groupDescription: "",
      layerItems: [],
      selectGps: "",
      selectRadio: "",
      menuVisible: {
        settingsMenu: true,
        unitsMenu: true,
        unitsPlayers: true,
        cameraMenu: true,
        radioMenu: true,
        bodyCamMenu: true,
        gpsMenu: true,
        drawMenu: true,
        dispatchMenu: true,
        dispatchPlayers: true,
      },
      dispatchAlertCoord: { x: 0, y: 0 },
    },
  });

  useNuiEvent("data", (newData) => {
    setData(newData);
  });

  useNuiEvent("SET_CONFIG", (newData) => {
    // jobColor: {
    //   police: "#1FA2EC",
    //   sheriff: "#DFB038",
    //   bcso: "#DF6A38",
    //   highway: "#FC5FFF",
    //   state: "#6AC9FF",
    //   ranger: "#0EB809",
    //   ambulance: "#FF3939",
    // },
    setData((prev) => ({
      ...prev,
      dispatch: {
        ...prev.dispatch,
        callSign: newData.defaultCallsign,
        alertSettingsKey: newData.OpenDispatchSettings,
        alerAcceptKey: newData.RespondKeybind,
        jobColor: newData.JobColors,
      },
    }));
  });

  useNuiEvent("SET_MANAGER", (newData) => {
    let manager = newData?.name || "";
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          dispatchManager: manager,
        },
      };
    });
  });

  useNuiEvent("SHOW_ALERT", (e) => {
    setData((prev) => ({
      ...prev,
      dispatch: {
        ...prev.dispatch,
        showAlertNot: e,
        alertNot: e,
      },
    }));
  });

  useNuiEvent("NEW_ALERT", (newData) => {
    // Play a notification sound
    if (window && typeof window.Audio === 'function') {
      try {
        const audio = new window.Audio('sounds/notification.wav');
        audio.volume = 1;
        audio.currentTime = 0;
        audio.play();
      } catch (e) {}
    }
    newData.coords = [newData.coords.y, newData.coords.x];
    newData.userList = newData.units;
    newData.dropId = randomId();
    newData.activeIcon = "active" + newData.icon;
    newData.active = false;
    newData.unitCount = 0;
    newData.priority = newData.priority.toString();
    // alertNotif: [newData, ...prev.dispatch.alertNotif.slice(0, prev.dispatch.alertNotif.length - 1)],
    setData((prev) => ({
      ...prev,
      dispatch: {
        ...prev.dispatch,
        alertNotif: [newData, ...prev.dispatch.alertNotif.slice(0, prev.dispatch.alertNotif.length)],

        dispatchList: [newData, ...prev.dispatch.dispatchList],
      },
    }));
  });

  useNuiEvent("REMOVE_ALERT", (newData) => {
    setData((prev) => ({
      ...prev,
      dispatch: {
        ...prev.dispatch,
        dispatchList: prev.dispatch.dispatchList.filter(
          (item) => item.id !== newData
        ),
        alertNotif: prev.dispatch.alertNotif.filter(
          (item) => item.id !== newData
        ),
      },
    }));
  });

  useNuiEvent("UPDATE_ALERT", (newData) => {
    newData.coords = [newData.coords.y, newData.coords.x];
    newData.userList = newData.units;
    newData.dropId = randomId();
    newData.activeIcon = "active" + newData.icon;
    newData.active = false;
    newData.priority = newData.priority.toString();

    setData((prev) => ({
      ...prev,
      dispatch: {
        ...prev.dispatch,
        dispatchList: prev.dispatch.dispatchList.map((item) =>
          item.id === newData.id ? newData : item
        ),
        alertNotif: [
          newData,
          ...prev.dispatch.alertNotif.slice(
            0,
            prev.dispatch.alertNotif.length - 1
          ),
        ],
      },
    }));
  });

  useNuiEvent("ACTIVE_CHANNEL", (newData) => {
    "ACTIVE_CHANNEL", newData;
    setData((prev) => ({
      ...prev,
      dispatch: {
        ...prev.dispatch,
        activeRadio: newData.radio,
        activeGps: newData.gps,
      },
    }));
  });

  // GPS ICON
  useNuiEvent("SETUP_GPS_ICONS", (icondata) => {
    if (!icondata.list) return;
    icondata.list.forEach((icon) => {
      icon.position = [icon.position.coords.y, icon.position.coords.x];
    });
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          icons: icondata.list,
        },
      };
    });
  });

  useNuiEvent("openBodycam", function (newData) {
    setData((prev) => ({
      ...prev,
      bodyCam: {
        ...prev.bodyCam,
        enable: newData,
      },
    }));
  });

  return (
    <DataContext.Provider value={{ data, setData, uiData, setUiData }}>
      {children}
    </DataContext.Provider>
  );
};
