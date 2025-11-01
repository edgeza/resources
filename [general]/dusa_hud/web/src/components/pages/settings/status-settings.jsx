import { useSettings } from "../../../contexts/SettingsContext";
import { ArmorIcon } from "../../icons/armor-icon";
import { DehydrationIcon } from "../../icons/dehydration-icon";
import { EnergyIcon } from "../../icons/energy-icon";
import { HealthIcon } from "../../icons/health-icon";
import { HideIcon } from "../../icons/hide-icon";
import { HungryIcon } from "../../icons/hungry-icon";
import { StatusStyle1 } from "../../icons/status-style-1";
import { StatusStyle2 } from "../../icons/status-style-2";
import { StatusStyle3 } from "../../icons/status-style-3";
import { StatusStyle4 } from "../../icons/status-style-4";
import { StatusStyle5 } from "../../icons/status-style-5";
import { StatusStyle6 } from "../../icons/status-style-6";
import { StatusStyle7 } from "../../icons/status-style-7";
import { StatusStyle8 } from "../../icons/status-style-8";
import { StatusStyle9 } from "../../icons/status-style-9";
import { StressIcon } from "../../icons/stress-icon";
import { Status10 } from "./settings-10-edit";

import ListItem from "./settings-item";
import StatusStyleSettingItem from "./status-style-setting-item";
import StatusStyleVisibilitySetting from "./status-style-visibility-setting";

const StatusSettings = () => {
  const { settings, updateSettings, openSettings, setOpenSettings } =
    useSettings();

  const toggleSetting = (settingKey) => {
    updateSettings("status", { [settingKey]: !settings.status[settingKey] });
  };

  return (
    <div className="flex flex-col gap-y-2">
      <ListItem
        handleToggle={() => toggleSetting("allStatus")}
        isOn={settings.status.allStatus}
        description={settings.language.onOffSettings}
        icon={<HideIcon />}
        title={settings.language.allStatus}
      />

      <div className="grid grid-cols-3 gap-2">
        <ListItem
          handleToggle={() => toggleSetting("health")}
          isOn={settings.status.health}
          description={settings.language.onOffSettings}
          icon={<HealthIcon />}
          title={settings.language.health}
        />
        <ListItem
          handleToggle={() => toggleSetting("thirst")}
          isOn={settings.status.thirst}
          description={settings.language.onOffSettings}
          icon={<DehydrationIcon />}
          title={settings.language.thirst}
        />
        <ListItem
          handleToggle={() => toggleSetting("hunger")}
          isOn={settings.status.hunger}
          description={settings.language.onOffSettings}
          icon={<HungryIcon />}
          title={settings.language.hunger}
        />
        <ListItem
          handleToggle={() => toggleSetting("energy")}
          isOn={settings.status.energy}
          description="Off-On Energy"
          icon={<EnergyIcon />}
          title={settings.language.energy}
        />
        <ListItem
          handleToggle={() => toggleSetting("armor")}
          isOn={settings.status.armor}
          description={settings.language.onOffSettings}
          icon={<ArmorIcon />}
          title={settings.language.armor}
        />
        <ListItem
          handleToggle={() => toggleSetting("stress")}
          isOn={settings.status.stress}
          description={settings.language.onOffSettings}
          icon={<StressIcon />}
          title={settings.language.stress}
        />
      </div>

      <div className="grid grid-cols-3 gap-3 justify-between">
        {[
          StatusStyle1,
          StatusStyle2,
          StatusStyle3,
          StatusStyle4,
          StatusStyle5,
          StatusStyle6,
          StatusStyle7,
          StatusStyle8,
          StatusStyle9,
          Status10,
        ].map((StatusStyle, index) =>
          openSettings === (index + 1).toString() ? (
            <StatusStyleVisibilitySetting key={index + 1} />
          ) : (
            <StatusStyleSettingItem
              key={index + 1}
              statusStyleNumber={(index + 1).toString()}
            >
              <StatusStyle />
            </StatusStyleSettingItem>
          )
        )}
      </div>
    </div>
  );
};

export default StatusSettings;
