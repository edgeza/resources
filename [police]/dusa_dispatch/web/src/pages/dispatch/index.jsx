import style from "./style.module.scss";
import DispatchMap from "../../components/dispatch/map";
import DispatchMenu from "../../components/dispatch/menu";
import DispatchTab from "../../components/dispatch/tabMenu";
import { useEffect } from "react";
import { useData } from "../../hooks/useData";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { randomId } from "../../utils/misc";
import { postNui } from "../../utils/postNui";

function PoliceDispatch() {
  const { data, setData } = useData();

  useNuiEvent("LIST_OFFICER", (newData) => {
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          unitUserList: newData,
          userList: newData,
        },
      };
    });
  });

  useNuiEvent("LIST_MANAGER", (newData) => {
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          settingsUserList: newData,
        },
      };
    });
  });

  useNuiEvent("LIST_DRAWINGS", (newData) => {
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          draw: {
            drawnItems: newData,
          },
        },
      };
    });
  });

  useNuiEvent("LIST_CAMERA", (newData) => {
    newData.forEach((e) => {
      e.camİd = e.camId;
      e.icon = "camera";
      e.activeIcon = "cameraActive";
    });
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          cameraList: newData,
        },
      };
    });
  });

  useNuiEvent("BODYCAM_LIST", (newData) => {
    newData.data.forEach((e, index) => {
      if (e.gameId === newData.source) {
        newData.data.splice(index, 1);
      }
    });

    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          bodyCamList: newData.data,
        },
      };
    });
  });

  useNuiEvent("LIST_UNIT", (newData) => {
    data.dispatch.dispatchList.forEach((alert) => {
      alert.units.forEach((unit) => {
        newData.forEach((currentUnit) => {
          if (unit.id === currentUnit.id) {
            currentUnit.active = true;
          }
        });
      });
    });

    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          unitList: newData,
        },
      };
    });
  });

  useNuiEvent("LIST_RADIO_COMMON", (newData) => {
    newData.forEach((channel) => {
      if (channel.item && channel.item.length > 0) {
        channel.item.forEach((e) => {
          e.channelId = e.frequency;
        });
      }
    });

    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          radioCommon: newData,
        },
      };
    });
  });

  useNuiEvent("LIST_RADIO_HEIST", (newData) => {
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          radioHeist: newData,
        },
      };
    });
  });

  useNuiEvent("LIST_GPS_COMMON", (newData) => {
    newData.forEach((channel) => {
      if (channel.item && channel.item.length > 0) {
        channel.item.forEach((e) => {
          e.channelId = e.code;
        });
      }
    });

    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          gpsCommon: newData,
        },
      };
    });
  });

  useNuiEvent("LIST_GPS_HEIST", (newData) => {
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          gpsHeist: newData,
        },
      };
    });
  });

  useNuiEvent("GPS_PLAYER", (newData) => {
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          name: newData.name,
          job: newData.job,
          jobRank: newData.jobRank,
          citizenId: newData.citizenId,
        },
      };
    });
  });

  useNuiEvent("SET_SETTINGS", (newData) => {
    if (!newData.callsign || !newData.filters) {
      return;
    }
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          callSign: newData.callsign,
          alertNot: newData.alertEnabled,
          mapFilter: newData.filters,
        },
      };
    });
  })

  useNuiEvent("SET_PERMISSIONS", (newData) => {
    setData((prevData) => {
      return {
        ...prevData,
        dispatch: {
          ...prevData.dispatch,
          jobAcces: newData,
        },
      };
    });
  });

  useEffect(() => {
    window.addEventListener("keydown", (e) => {
      if (e.key === "Escape") {
        postNui("closeDispatch");
      }
    });
    return () => {
      window.removeEventListener("keydown", (e) => {
        if (e.key === "Escape") {
          postNui("closeDispatch");
        }
      });
    };
  }, []);

  return (
    <div className={style.Dispatch}>
      <DispatchMap />
      <DispatchMenu />
      <DispatchTab />
    </div>
  );
}

export default PoliceDispatch;
