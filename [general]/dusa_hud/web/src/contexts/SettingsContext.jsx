import { createContext, useContext, useState } from "react";
import {
  getStatusSettingForStyleFromLocalStorage,
  updateStatusSettingForStyleInLocalStorage,
  clearSettingsInLocalStorage,
} from "../helper/settings";
import { defaultSettings } from "./default";
import { useNuiEvent } from "../hooks/useNuiEvent";

const SettingsContext = createContext({
  settings: defaultSettings,
  openSettings: null,
  getStatusSettingForStyle: () => null,
  updateStatusSettingForStyle: () => {},
  updateSettings: (key, newSettings) => {},
  setupSettings: () => {},
  setOpenSettings: () => {
    throw new Error("Function not implemented.");
  },
  restoreDefaults: function () {
    throw new Error("Function not implemented.");
  },
  updateCarSettings: function () {
    throw new Error("Function not implemented.");
  },
});

export const useSettings = () => useContext(SettingsContext);

export const SettingsProvider = ({ children }) => {
  const [settings, setSettings] = useState(defaultSettings);
  //Hud ve speedometer seçme menüsünü açma
  useNuiEvent("openSettingsMenu", (data) => {
    if (Array.isArray(data.settings) && data.settings.length > 0) {
      if (data.vehicleType == 'car') {
        setupSettings(data.settings[0]);
      }
    }
  });

  useNuiEvent("setupSettings", (data) => {
    if (data.settings && Array.isArray(data.settings)) {
      setupSettings(data.settings[0]);
    }
  });

  useNuiEvent("applyDefaultSettings", (data) => {
    updateSettings("speedometers", {
      speedometerType: data.speedometer,
    });
    updateSettings("status", {
      statusStyleType: data.status,
    });
  });

  const [openSettings, setOpenSettings] = useState(null);
  useNuiEvent("setOpenSettings", setOpenSettings);

  const updateCarSettings = (newCarSettings) => {
    setSettings((prevSettings) => ({
      ...prevSettings,
      carSettings: {
        ...prevSettings.carSettings,
        ...newCarSettings,
      },
    }));
  };

  const updateSettings = (category, newSettings) => {
    if (category === "styleVisibility") {
      const updatedVisibility = {
        ...settings.styleVisibility,
        ...newSettings,
      };
      setSettings((prevSettings) => ({
        ...prevSettings,
        styleVisibility: updatedVisibility,
      }));
    } else {
      setSettings((prevSettings) => ({
        ...prevSettings,
        [category]: {
          ...prevSettings[category],
          ...newSettings,
        },
      }));
    }
  };

  const setupSettings = (newSettings) => {
    if (Object.keys(newSettings).length > 0) {
      setSettings((prevSettings) => ({
        ...prevSettings,
        ...newSettings,
      }));
    }
  };

  const getStatusSettingForStyle = (styleType) => {
    return getStatusSettingForStyleFromLocalStorage(styleType);
  };

  const updateStatusSettingForStyle = (styleType, setting) => {
    updateStatusSettingForStyleInLocalStorage(styleType, setting);
  };

  const restoreDefaults = () => {
    setSettings(defaultSettings);
    clearSettingsInLocalStorage();
  };

  return (
    <SettingsContext.Provider
      value={{
        settings,
        openSettings,

        getStatusSettingForStyle,
        updateStatusSettingForStyle,
        updateSettings,
        setupSettings,
        updateCarSettings,
        setOpenSettings,
        restoreDefaults,
      }}
    >
      {children}
    </SettingsContext.Provider>
  );
};
