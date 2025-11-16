import React from "react";
import { useSettings } from "../../../contexts/SettingsContext";
import { fetchNui } from "../../../utils/fetchNui";
import { HideIcon } from "../../icons/hide-icon";
import ListItem from "./settings-item";
import ServerInfoStyleSettingItem from "./server-info-style-setting-item";
import { ServerInfo1 } from "../../icons/server-info-1";
import { ServerInfo2 } from "../../icons/server-info-2";
import { ServerInfo3 } from "../../icons/server-info-3";
import { ServerInfo4 } from "../../icons/server-info-4";
import { ServerInfo5 } from "../../icons/server-info-5";
import { ServerInfo6 } from "../../icons/server-info-6";
import { ServerInfo7 } from "../../icons/server-info-7";
import { ServerInfo8 } from "../../icons/server-info-8";

const ServerInfoSettings = () => {
  const { settings, updateSettings } = useSettings();

  const toggleSetting = (settingKey) => {
    updateSettings("serverInfoSettings", {
      [settingKey]: !settings.serverInfoSettings[settingKey],
    });

    fetchNui("toggleSetting", {
      key: settingKey,
      status: !settings.serverInfoSettings[settingKey],
    });
  };

  return (
    <div className="flex flex-col gap-y-2">
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.hideQuickInfo}
        icon={<HideIcon />}
        isOn={settings.serverInfoSettings.hideQuickInfo}
        handleToggle={() => toggleSetting("hideQuickInfo")}
      />
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.hideCashMoney}
        icon={<HideIcon />}
        isOn={settings.serverInfoSettings.hideCashMoney}
        handleToggle={() => toggleSetting("hideCashMoney")}
      />
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.hideBlackMoney}
        icon={<HideIcon />}
        isOn={settings.serverInfoSettings.hideBlackMoney}
        handleToggle={() => toggleSetting("hideBlackMoney")}
      />
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.hideCoin}
        icon={<HideIcon />}
        isOn={settings.serverInfoSettings.hideCoin}
        handleToggle={() => toggleSetting("hideCoin")}
      />
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.hideUserMoney}
        icon={<HideIcon />}
        isOn={settings.serverInfoSettings.hideUserMoney}
        handleToggle={() => toggleSetting("hideUserMoney")}
      />

      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.hideServerLogo}
        icon={<HideIcon />}
        isOn={settings.serverInfoSettings.hideServerLogo}
        handleToggle={() => toggleSetting("hideServerLogo")}
      />

      <div className="grid grid-cols-3 gap-3 justify-between">
        {[
          ServerInfo1,
          ServerInfo2,
          ServerInfo3,
          ServerInfo4,
          ServerInfo5,
          ServerInfo6,
          ServerInfo7,
          ServerInfo8,
        ].map((StatusStyle, index) => (
          <ServerInfoStyleSettingItem
            key={index + 1}
            serverInfoStyleNumber={(index + 1).toString()}
          >
            <StatusStyle />
          </ServerInfoStyleSettingItem>
        ))}
      </div>
    </div>
  );
};
export default ServerInfoSettings;
