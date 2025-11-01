import { useEffect, useRef, useState, useCallback, useMemo } from "react";
import SettingsModal from "../settings/settings-modal";
import { useSettings } from "../../../contexts/SettingsContext";
import { motion } from "framer-motion";

import Menu from "../menu";
import SpeedoMeter1 from "../../ui/speedometer-styles/speedometer-1";
import SpeedoMeter2 from "../../ui/speedometer-styles/speedometer-2";
import SpeedoMeter3 from "../../ui/speedometer-styles/speedometer-3";
import SpeedoMeter4 from "../../ui/speedometer-styles/speedometer-4";
import SpeedoMeter5 from "../../ui/speedometer-styles/speedometer-5";
import SpeedoMeter6 from "../../ui/speedometer-styles/speedometer-6";
import SpeedoMeter7 from "../../ui/speedometer-styles/speedometer-7";
import SpeedoMeter8 from "../../ui/speedometer-styles/speedometer-8";
import SpeedoMeter9 from "../../ui/speedometer-styles/speedometer-9";
import SpeedoMeter10 from "../../ui/speedometer-styles/speedometer-10";

import QuickInfo from "./quick-info";
import { useMusicPlayer } from "../../../contexts/MediaContext";
import ReactPlayer from "react-player";
import Draggable from "react-draggable";

import { useNuiEvent } from "../../../hooks/useNuiEvent";
import { fetchNui } from "../../../utils/fetchNui";
import BicycleSpeedometer from "../../ui/speedometer-styles/bicycle-speedometer";
import AirplaneSpeedometer from "../../ui/speedometer-styles/airplane-speedometer";
import ShipSpeedometer from "../../ui/speedometer-styles/ship-speedometer";
import clsx from "clsx";

const speedometerComponents = [
  SpeedoMeter1,
  SpeedoMeter2,
  SpeedoMeter3,
  SpeedoMeter4,
  SpeedoMeter5,
  SpeedoMeter6,
  SpeedoMeter7,
  SpeedoMeter8,
  SpeedoMeter9,
  SpeedoMeter10,
];

const Hud = () => {
  const { settings, updateSettings, setupSettings } = useSettings();
  const playerRef = useRef(null);

  const {
    musicList,
    playing,
    setPlaying,
    setProgress,
    playNextTrack,
    currentTrackIndex,
    volume,
  } = useMusicPlayer();

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [speed, setSpeed] = useState(0);
  const [maxSpeed, setMaxSpeed] = useState(500);
  const [showHud, setShowHud] = useState(true);
  const [gear, setGear] = useState(7);
  const [maxGear, setMaxGear] = useState(7);
  const [fuel, setFuel] = useState(100);
  const [showSpeedo, setShowSpeedo] = useState(false);
  const [showVehicleMenu, setShowVehicleMenu] = useState(false);
  const [showOpenInfo, setShowOpenInfo] = useState(false);

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
    setPositions(newPositions);
    // Save positions immediately when dragging stops
    fetchNui("savePositions", newPositions);
  };

  const changeSpeedo = (type) => {
    if (type === "car") {
      updateSettings("speedometers", {
        speedometerType: settings.speedometers.speedometerType,
      });
    } else if (type === "ship") {
      updateSettings("speedometers", {
        speedometerType: "11",
      });
    } else if (type === "plane") {
      updateSettings("speedometers", {
        speedometerType: "12",
      });
    } else if (type === "bike") {
      updateSettings("speedometers", {
        speedometerType: "13",
      });
    }
  };

  const variants = {
    open: { opacity: 1 },
    closed: { opacity: 0 },
  };

  useNuiEvent("setPositions", setPositions);
  useNuiEvent("disableMinimap", (e) => {
    updateSettings("general", { ["disableMinimap"]: e });
  });
  useNuiEvent("visibleHud", setShowHud);
  useNuiEvent("setMaxSpeed", setMaxSpeed);
  useNuiEvent("setMaxGear", setMaxGear);
  useNuiEvent("openSpeedo", setShowSpeedo);
  useNuiEvent("openMap", setShowVehicleMenu);
  useNuiEvent("openInfo", setShowOpenInfo);
  useNuiEvent("setCarType", changeSpeedo);
  useNuiEvent("clearSpeedoType", (e) => {
    updateSettings("speedometers", {
      speedometerType: e,
    });
  });
  useNuiEvent("hideHud", (e) => {
    updateSettings("general", { ["hideAllHud"]: e });
  });

  //Hud ve speedometer seçme menüsünü açma
  useNuiEvent("openSettingsMenu", (data) => {
    if (Array.isArray(data.settings) && data.settings.length > 0) {
      if (data.vehicleType === "car") {
        setupSettings(data.settings[0]);
      }
      changeSpeedo(data.vehicleType);
    }
    setIsModalOpen(data.isOpen);
  });
  //Speedometerler için hız seviyesi değiştirme
  useNuiEvent("setSpeed", setSpeed);
  //Benzin seviyesi ayarlama
  useNuiEvent("setFuel", setFuel);
  //Vites seviyesi değiştirme (1-5)
  useNuiEvent("setGear", setGear);
  //Araç bozulma durumu
  useNuiEvent("setEngineBroken", (e) => {
    updateSettings("carSettings", { ["engineHasProblem"]: e });
  });
  //Kapı açık durumu
  useNuiEvent("setDoorOpen", (e) => {
    updateSettings("carSettings", { ["doorIsOpen"]: e });
  });

  useNuiEvent("translate", (locale) => {
    for (const key in locale) {
      const value = locale[key];
      updateSettings("language", { [key]: value });
    }
  });

  useEffect(() => {
    fetchNui(
      "startMusic",
      musicList[currentTrackIndex] ? musicList[currentTrackIndex].url : null
    );
  }, []);

  // useEffect(() => {
  //   fetchNui("setPositions", positions);
  // }, []);

  const closeSettings = () => {
    fetchNui("changeSettings", [settings]);
    fetchNui("closeUI");
    setIsModalOpen(false);
  };

  useNuiEvent("saveSettings", () => {
    fetchNui("saveLastSettings", [settings]);
  });

  const SpeedoMeterComponent =
    speedometerComponents[
      parseInt(settings.speedometers.speedometerType, 10) - 1
    ];

  return (
    <>
      <SettingsModal
        isOpen={isModalOpen}
        onClose={() => {
          closeSettings();
        }}
      />
      {!settings.general.hideAllHud && (
        <motion.div
          animate={showHud ? "open" : "closed"}
          transition={{ duration: 0.5 }}
          variants={variants}
        >
          <ReactPlayer
            ref={playerRef}
            loop={true}
            onProgress={(state) => setProgress(state.playedSeconds)}
            url={musicList.length > 0 ? musicList[currentTrackIndex].url : ""}
            playing={playing}
            controls={true}
            onPause={() => setPlaying(false)}
            onEnded={playNextTrack}
            style={{ visibility: "hidden", display: "none" }}
            width="96%"
            height="180px"
            volume={volume}
          />

          {!showOpenInfo && (
            <Draggable
              position={positions.server}
              onStop={(e, data) => handleStop(e, data, "server")}
              disabled={!settings.general.freeformEditMode}
            >
              <div className="absolute right-4 top-4">
                <QuickInfo />
              </div>
            </Draggable>
          )}

          {!showVehicleMenu && <Menu ref={playerRef} />}

          {showSpeedo && (
            <Draggable
              position={positions.speedo}
              onStop={(e, data) => handleStop(e, data, "speedo")}
              disabled={!settings.general.freeformEditMode}
            >
              <div className="absolute right-4 bottom-4">
                {SpeedoMeterComponent && (
                  <SpeedoMeterComponent
                    speed={speed}
                    fuel={fuel}
                    gear={gear}
                    maxSpeed={maxSpeed}
                    maxGear={maxGear}
                  />
                )}
                {settings.speedometers.speedometerType === "13" && (
                  <BicycleSpeedometer
                    speed={speed}
                    fuel={fuel}
                    gear={gear}
                    maxSpeed={maxSpeed}
                    maxGear={maxGear}
                  />
                )}
                {settings.speedometers.speedometerType === "12" && (
                  <AirplaneSpeedometer
                    activeColor="#FF4343"
                    speed={speed}
                    fuel={fuel}
                    gear={gear}
                    maxSpeed={maxSpeed}
                    maxGear={maxGear}
                  />
                )}
                {settings.speedometers.speedometerType === "11" && (
                  <ShipSpeedometer
                    speed={speed}
                    fuel={fuel}
                    gear={gear}
                    maxSpeed={maxSpeed}
                    maxGear={maxGear}
                  />
                )}
              </div>
            </Draggable>
          )}
        </motion.div>
      )}
    </>
  );
};

export default Hud;
