import { useState, useEffect, useRef } from "react";
import Tabs from "../../ui/core/menu-tab";
import VehicleMenu from "./vehicle/vehicle-menu";
import MediaMenu from "./media/media-menu";
import LogoAndLocation from "./media/menu-header";
import { useSettings } from "../../../contexts/SettingsContext";
import { useNuiEvent } from "../../../hooks/useNuiEvent";
import Draggable from "react-draggable";

import StatusStyle1 from "../../ui/status-styles/status-style-1";
import StatusStyle2 from "../../ui/status-styles/status-style-2";
import StatusStyle3 from "../../ui/status-styles/status-style-3";
import StatusStyle4 from "../../ui/status-styles/status-style-4";
import StatusStyle8 from "../../ui/status-styles/status-style-8";
import StatusStyle10 from "../../ui/status-styles/status-style-10";
import StatusStyle5 from "../../ui/status-styles/status-style-5";
import StatusStyle9 from "../../ui/status-styles/status-style-9";
import StatusStyle7 from "../../ui/status-styles/status-style-7";
import StatusStyle6 from "../../ui/status-styles/status-style-6";
import clsx from "clsx";
import { fetchNui } from "../../../utils/fetchNui";

const statusComponents = [
  StatusStyle1,
  StatusStyle2,
  StatusStyle3,
  StatusStyle4,
  StatusStyle5,
  StatusStyle6,
  StatusStyle7,
  StatusStyle8,
  StatusStyle9,
  StatusStyle10,
];

const Menu = ({ ref }) => {
  const { settings, updateSettings } = useSettings();
  // const [cursor, setCursor] = useState(settings.general.hideFocus);
  // useNuiEvent("setCursor", setCursor);
  const [tabs, setTabs] = useState([
    { label: settings.language.media },
    { label: settings.language.vehicle },
    { label: settings.language.map },
  ]);
  const [activeTab, setActiveTab] = useState(
    tabs.find(tab => tab.label === settings.language.map) ? settings.language.map : tabs[0].label
  );

  const [positions, setPositions] = useState(settings.defaultPositions);

  // Sync positions when settings change
  useEffect(() => {
    setPositions(settings.defaultPositions);
  }, [settings.defaultPositions]);

  const handleStop = (e, data, key) => {
    const newPositions = {
      ...positions,
      [key]: { x: data.x, y: data.y },
    };
    console.log(`[Dusa HUD] Position updated for ${key}:`, { x: data.x, y: data.y });
    setPositions(newPositions);
    // Save positions immediately when dragging stops
    fetchNui("savePositions", newPositions);
  };

  // Debug log when freeform mode changes
  useEffect(() => {
    console.log(`[Dusa HUD] Freeform Edit Mode:`, settings.general.freeformEditMode);
    console.log(`[Dusa HUD] Current positions:`, positions);
  }, [settings.general.freeformEditMode, positions]);

  useNuiEvent("setTabs", (data) => {
    setTabs(data);
  });
  useNuiEvent("setPositions", setPositions);

  useEffect(() => {
    const handleKeyDown = (event) => {
      if (event.key === "CapsLock") {
        fetchNui("closeUI");
      }
    };

    document.addEventListener("keydown", handleKeyDown);

    return () => {
      document.removeEventListener("keydown", handleKeyDown);
    };
  }, []);

  const [status, setStatus] = useState({
    armor: 30,
    energy: 40,
    health: 100,
    hunger: 10,
    thirst: 40,
    stress: 100,
    oxygen: 100,
  });

  const [map, setMap] = useState(true);

  useNuiEvent("changeStatusVisibility", (data) => {
    updateSettings("status", {
      ...settings.status,
      [data.type]: data.value,
    });
  });

  useNuiEvent("setOxygen", (e) => {
    setStatus({
      ...status,
      oxygen: e,
    });
  });

  //status için değerler
  useNuiEvent("setHealth", (e) => {
    setStatus({
      ...status,
      health: e,
    });
  });
  useNuiEvent("setStamina", (e) => {
    setStatus({
      ...status,
      energy: e,
    });
  });
  useNuiEvent("setArmor", (e) => {
    setStatus({
      ...status,
      armor: e,
    });
  });
  useNuiEvent("setStress", (e) => {
    setStatus({
      ...status,
      stress: e,
    });
  });

  useNuiEvent("setThirst", (e) => {
    setStatus({
      ...status,
      thirst: e,
    });
  });
  useNuiEvent("setHunger", (e) => {
    setStatus({
      ...status,
      hunger: e,
    });
  });

  const StatusComponent =
    statusComponents[parseInt(settings.status.statusStyleType, 10) - 1];

  const [showStatus, setShowStatus] = useState(false);
  // useNuiEvent("hideHud", setShowStatus);

  const containerRef = useRef(null);

  // CSS transition end handler
  useEffect(() => {
    const container = containerRef.current;
    const transitionEndHandler = () => {
      if (map) container.style.height = "auto";
    };

    container.addEventListener("transitionend", transitionEndHandler);
    return () => {
      container.removeEventListener("transitionend", transitionEndHandler);
    };
  }, [map]);

  const toggleVisibility = (e) => {
    setMap((prevMap) => e);
  };
  useNuiEvent("toggleMap", toggleVisibility);

  const maxHeight = map ? `${containerRef?.current?.scrollHeight}px` : "0px";

  return (
    <>
      <Draggable
        position={positions.menu}
        onStop={(e, data) => handleStop(e, data, "menu")}
        disabled={!settings.general.freeformEditMode}
      >
        <div className="flex flex-col absolute bottom-[85px] left-4">
          {settings.general.showLocation && (
            <div className="w-[369px] opacity-80 custom:w-[600px] px-2 flex items-center justify-between custom:h-20 h-[58px] bg-gradient-to-r from-neutral-950/80 via-neutral-900/80 to-neutral-950/80 rounded rounded-b-none">
              <LogoAndLocation />
            </div>
          )}
          <div
            ref={containerRef}
            className="overflow-hidden"
            style={{ maxHeight, transition: "max-height 200ms ease-in-out" }}
          >
            {activeTab === settings.language.map && (
              <div className="w-[369px] custom:w-[600px] custom:h-96 h-[234.95px]" />
            )}
            {activeTab === settings.language.vehicle && <VehicleMenu />}
            {activeTab === settings.language.media && <MediaMenu ref={ref} />}

            <Tabs
              tabs={tabs}
              activeTab={activeTab}
              setActiveTab={setActiveTab}
            />
          </div>
        </div>
      </Draggable>

      {/* DEBUG: Test if freeform mode is working */}
      {settings.general.freeformEditMode && (
        <div className="fixed top-4 right-4 bg-green-500 text-white px-4 py-2 rounded z-50 text-sm">
          ✅ FREEFORM MODE ACTIVE<br/>
          showStatus: {showStatus ? 'true' : 'false'}<br/>
          allStatus: {settings.status.allStatus ? 'true' : 'false'}<br/>
          Health hidden: {settings.status.health ? 'true' : 'false'}
        </div>
      )}

      {/* Individual draggable status bars */}
      {!showStatus && (!settings.status.allStatus || settings.general.freeformEditMode) && (
        <>
          {/* Health */}
          {!settings.status.health && (
            <Draggable
              position={positions.health || { x: 16, y: 500 }}
              onStop={(e, data) => handleStop(e, data, "health")}
              disabled={!settings.general.freeformEditMode}
            >
              <div className={`absolute ${settings.general.freeformEditMode ? 'outline outline-2 outline-dashed outline-red-500/70' : ''}`}>
                <StatusComponent status={status} single="health" />
              </div>
            </Draggable>
          )}
          
          {/* Hunger */}
          {!settings.status.hunger && (
            <Draggable
              position={positions.hunger || { x: 80, y: 500 }}
              onStop={(e, data) => handleStop(e, data, "hunger")}
              disabled={!settings.general.freeformEditMode}
            >
              <div className={`absolute ${settings.general.freeformEditMode ? 'outline outline-2 outline-dashed outline-orange-500/70' : ''}`}>
                <StatusComponent status={status} single="hunger" />
              </div>
            </Draggable>
          )}
          
          {/* Thirst */}
          {!settings.status.thirst && (
            <Draggable
              position={positions.thirst || { x: 144, y: 500 }}
              onStop={(e, data) => handleStop(e, data, "thirst")}
              disabled={!settings.general.freeformEditMode}
            >
              <div className={`absolute ${settings.general.freeformEditMode ? 'outline outline-2 outline-dashed outline-blue-500/70' : ''}`}>
                <StatusComponent status={status} single="thirst" />
              </div>
            </Draggable>
          )}
          
          {/* Armor */}
          {!settings.status.armor && (
            <Draggable
              position={positions.armor || { x: 208, y: 500 }}
              onStop={(e, data) => handleStop(e, data, "armor")}
              disabled={!settings.general.freeformEditMode}
            >
              <div className={`absolute ${settings.general.freeformEditMode ? 'outline outline-2 outline-dashed outline-cyan-500/70' : ''}`}>
                <StatusComponent status={status} single="armor" />
              </div>
            </Draggable>
          )}
          
          {/* Energy */}
          {!settings.status.energy && (
            <Draggable
              position={positions.energy || { x: 272, y: 500 }}
              onStop={(e, data) => handleStop(e, data, "energy")}
              disabled={!settings.general.freeformEditMode}
            >
              <div className={`absolute ${settings.general.freeformEditMode ? 'outline outline-2 outline-dashed outline-green-500/70' : ''}`}>
                <StatusComponent status={status} single="energy" />
              </div>
            </Draggable>
          )}
          
          {/* Stress */}
          {!settings.status.stress && (
            <Draggable
              position={positions.stress || { x: 336, y: 500 }}
              onStop={(e, data) => handleStop(e, data, "stress")}
              disabled={!settings.general.freeformEditMode}
            >
              <div className={`absolute ${settings.general.freeformEditMode ? 'outline outline-2 outline-dashed outline-purple-500/70' : ''}`}>
                <StatusComponent status={status} single="stress" />
              </div>
            </Draggable>
          )}
          
          {/* Oxygen */}
          {!settings.status.oxygen && (
            <Draggable
              position={positions.oxygen || { x: 400, y: 500 }}
              onStop={(e, data) => handleStop(e, data, "oxygen")}
              disabled={!settings.general.freeformEditMode}
            >
              <div className={`absolute ${settings.general.freeformEditMode ? 'outline outline-2 outline-dashed outline-teal-500/70' : ''}`}>
                <StatusComponent status={status} single="oxygen" />
              </div>
            </Draggable>
          )}
        </>
      )}
      {!settings.general.hideFocus && (
        <Draggable
          position={positions.caps || { x: 16, y: 600 }}
          onStop={(e, data) => handleStop(e, data, "caps")}
          disabled={!settings.general.freeformEditMode}
        >
          <div className={`absolute w-[63.75px] h-[21px] bg-neutral-800 rounded border border-white border-opacity-20 flex items-center justify-center gap-x-2 ${settings.general.freeformEditMode ? 'outline outline-2 outline-dashed outline-yellow-500/70' : ''}`}>
            <svg
              width="10"
              height="9"
              viewBox="0 0 10 9"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M9.05236 7.56317C9.09652 7.60717 9.13155 7.65945 9.15545 7.71702C9.17936 7.77459 9.19166 7.83631 9.19166 7.89864C9.19166 7.96097 9.17936 8.02269 9.15545 8.08026C9.13155 8.13783 9.09652 8.19011 9.05236 8.23411L8.55153 8.73376C8.50753 8.77791 8.45525 8.81294 8.39768 8.83685C8.34011 8.86075 8.27839 8.87306 8.21606 8.87306C8.15373 8.87306 8.09201 8.86075 8.03444 8.83685C7.97687 8.81294 7.92459 8.77791 7.88059 8.73376L5.64834 6.50112L4.889 8.48117C4.889 8.48512 4.88584 8.48946 4.88387 8.4938C4.83555 8.60646 4.75515 8.70242 4.65269 8.76972C4.55023 8.83702 4.43024 8.87269 4.30765 8.87229H4.27647C4.14863 8.86688 4.02553 8.82234 3.92381 8.74469C3.8221 8.66705 3.74668 8.56005 3.70776 8.43815L1.64482 2.12029C1.60941 2.0098 1.60512 1.89169 1.63243 1.77892C1.65974 1.66615 1.7176 1.56308 1.79964 1.48104C1.88169 1.39899 1.98475 1.34114 2.09752 1.31383C2.21029 1.28652 2.3284 1.2908 2.43889 1.32622L8.75676 3.38915C8.8775 3.42954 8.98322 3.5055 9.06004 3.60704C9.13685 3.70858 9.18118 3.83098 9.18719 3.95816C9.19321 4.08534 9.16064 4.21137 9.09376 4.31972C9.02687 4.42806 8.9288 4.51365 8.81241 4.56527L8.79978 4.5704L6.81972 5.33092L9.05236 7.56317ZM4.13913 1.29464C4.22287 1.29464 4.30318 1.26138 4.36239 1.20217C4.4216 1.14296 4.45486 1.06265 4.45486 0.978909V0.663173C4.45486 0.579435 4.4216 0.499127 4.36239 0.439915C4.30318 0.380703 4.22287 0.347438 4.13913 0.347438C4.05539 0.347438 3.97508 0.380703 3.91587 0.439915C3.85666 0.499127 3.82339 0.579435 3.82339 0.663173V0.978909C3.82339 1.06265 3.85666 1.14296 3.91587 1.20217C3.97508 1.26138 4.05539 1.29464 4.13913 1.29464ZM0.981777 4.13626H1.29751C1.38125 4.13626 1.46156 4.103 1.52077 4.04378C1.57998 3.98457 1.61325 3.90426 1.61325 3.82053C1.61325 3.73679 1.57998 3.65648 1.52077 3.59727C1.46156 3.53806 1.38125 3.50479 1.29751 3.50479H0.981777C0.898039 3.50479 0.81773 3.53806 0.758518 3.59727C0.699306 3.65648 0.666042 3.73679 0.666042 3.82053C0.666042 3.90426 0.699306 3.98457 0.758518 4.04378C0.81773 4.103 0.898039 4.13626 0.981777 4.13626ZM5.26078 1.57723C5.29788 1.59581 5.33829 1.60689 5.37968 1.60985C5.42107 1.6128 5.46264 1.60757 5.502 1.59445C5.54137 1.58133 5.57777 1.56057 5.60911 1.53337C5.64045 1.50617 5.66612 1.47306 5.68465 1.43594L6.00039 0.804465C6.03786 0.729571 6.04405 0.64286 6.01759 0.563405C5.99113 0.48395 5.93419 0.41826 5.85929 0.380788C5.7844 0.343315 5.69769 0.337128 5.61823 0.363588C5.53878 0.390049 5.47309 0.446988 5.43562 0.521882L5.11988 1.15335C5.10129 1.19043 5.09018 1.23081 5.0872 1.27219C5.08421 1.31356 5.08941 1.35512 5.1025 1.39449C5.11558 1.43385 5.1363 1.47025 5.16345 1.50161C5.19061 1.53296 5.22368 1.55866 5.26078 1.57723ZM1.47196 4.80128L0.840485 5.11701C0.765592 5.15449 0.708652 5.22018 0.682192 5.29963C0.655732 5.37909 0.661918 5.4658 0.699391 5.54069C0.736864 5.61558 0.802553 5.67252 0.882008 5.69898C0.961463 5.72544 1.04817 5.71926 1.12307 5.68178L1.75454 5.36605C1.79162 5.34749 1.82469 5.32182 1.85185 5.29048C1.87901 5.25915 1.89973 5.22277 1.91283 5.18343C1.92593 5.14409 1.93116 5.10255 1.92821 5.06119C1.92526 5.01983 1.91419 4.97946 1.89563 4.94237C1.87708 4.90529 1.8514 4.87222 1.82007 4.84506C1.78873 4.8179 1.75236 4.79718 1.71302 4.78408C1.67367 4.77098 1.63214 4.76575 1.59078 4.7687C1.54941 4.77165 1.50904 4.78272 1.47196 4.80128Z"
                fill="white"
              />
            </svg>

            <div className="text-white text-[7.51px] font-bold font-['Satoshi'] leading-[13.86px] tracking-tight">
              {settings.language.caps}
            </div>
          </div>
        </Draggable>
      )}
    </>
  );
};

export default Menu;
