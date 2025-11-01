import { useSettings } from "../../../contexts/SettingsContext";
import { SpeedTypeIcon } from "../../icons/speed-type-icon";
import SpeedometerSettingsItem from "./speedometer-setting-item";
import SpeedUnitSwitch from "../../ui/core/speed-unit-switch";
import { useState } from "react";
import { fetchNui } from "../../../utils/fetchNui";
import { Background } from "../../icons/background";

import Speedometer1 from "../../icons/speedometer-1.png";
import Speedometer2 from "../../icons/speedometer-2.png";
import Speedometer3 from "../../icons/speedometer-3.png";
import Speedometer4 from "../../icons/speedometer-4.png";
import Speedometer5 from "../../icons/speedometer-5.png";
import Speedometer6 from "../../icons/speedometer-6.png";
import Speedometer7 from "../../icons/speedometer-7.png";
import Speedometer8 from "../../icons/speedometer-8.png";
import Speedometer9 from "../../icons/speedometer-9.png";
import Speedometer10 from "../../icons/speedometer-10.png";

const speedometerComponents = [
  Speedometer1,
  Speedometer2,
  Speedometer3,
  Speedometer4,
  Speedometer5,
  Speedometer6,
  Speedometer7,
  Speedometer8,
  Speedometer9,
  Speedometer10,
];

const SpeedometerSettings = () => {
  const { settings, updateSettings } = useSettings();
  const [tranformValue, setTransformValue] = useState(
    settings.carSettings.tranform
  );

  const toggleUnits = () => {
    const newUnit = settings.speedometers.units === "kmh" ? "mph" : "kmh";
    updateSettings("speedometers", { units: newUnit });
    fetchNui("toggleSetting", { key: "speedo", status: newUnit });
  };

  const handleTransformChange = (e) => {
    setTransformValue(Number(e));
    updateSettings("speedometers", { transform: Number(e) });
  };

  const SpeedoMeterComponent =
    speedometerComponents[
      parseInt(settings.speedometers.speedometerType, 10) - 1
    ];

  return (
    <div className="flex flex-col gap-y-2">
      <div
        style={{
          background:
            "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
        }}
        className="flex items-center justify-between px-8 py-4 rounded-[5px]"
      >
        <div className="flex items-center gap-x-8">
          <SpeedTypeIcon />
          <div className="flex flex-col gap-y-2 items-start justify-start">
            <div className="text-center text-neutral-400 text-[21.25px] font-semibold font-['Qanelas Soft']">
              {settings.language.units}
            </div>
            <div className="text-center text-zinc-500 text-xs font-semibold font-['Qanelas Soft']">
              {settings.language.onOffSettings}
            </div>
          </div>
        </div>

        <SpeedUnitSwitch
          isOn={settings.speedometers.units === "kmh"}
          onToggle={() => toggleUnits()}
        />
      </div>
      <div
        style={{
          background:
            "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
        }}
        className="flex items-center justify-between px-8 py-4 rounded-[5px]"
      >
        <div className="flex items-center gap-x-8">
          <SpeedTypeIcon />
          <div className="flex flex-col gap-y-2 items-start justify-start">
            <div className="text-center text-neutral-400 text-[21.25px] font-semibold font-['Qanelas Soft']">
              {settings.language.transform}
            </div>
            <div className="text-center text-zinc-500 text-xs font-semibold font-['Qanelas Soft']">
              Number
            </div>
          </div>
        </div>

        <input
          value={tranformValue}
          type="range"
          min={0}
          max={200}
          className="slider rounded-full "
          onChange={(e) => handleTransformChange(e.target.value)}
        ></input>
      </div>

      <div className="lg:flex lg:flex-col lg:items-center lg:justify-between w-full lg:gap-y-10">
        <div className="lg:block hidden relative h-96 w-[720px]">
          <Background />
          <div className="absolute right-0 -bottom-4 z-10">
            {SpeedoMeterComponent && (
              <img
                src={SpeedoMeterComponent}
                alt={`Speedometer ${settings.speedometers.speedometerType}`}
              />
            )}
          </div>
        </div>
        <div className="grid grid-cols-5 gap-4  lg:grid-cols-5 max-lg:grid-cols-8 mega-lg:grid-cols-10">
          {speedometerComponents.map((speedo, index) => (
            <SpeedometerSettingsItem key={index} speedometerNumber={index + 1}>
              <img src={speedo} alt={`Speedometer ${index + 1}`} />
            </SpeedometerSettingsItem>
          ))}
        </div>
      </div>
    </div>
  );
};

export default SpeedometerSettings;
