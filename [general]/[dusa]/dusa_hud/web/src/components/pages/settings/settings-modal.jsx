import { useState } from "react";
import Modal from "../../ui/core/modal";
import GeneralSettings from "./general-settings";
import SpeedometerSettings from "./speedometer-settings";
import StatusSettings from "./status-settings";
import TabBar from "../../ui/core/tab";
import SettingsHeader from "./settings-header";
import { useSettings } from "../../../contexts/SettingsContext";
import ServerInfoSettings from "./server-info-settings";

const SettingsModal = ({ isOpen, onClose }) => {
  const [activeTab, setActiveTab] = useState("General");

  const { restoreDefaults, settings } = useSettings();

  const tabs = [
    { id: "General", label: settings.language.generalSettings, component: GeneralSettings },
    {
      id: "Speedometers",
      label: settings.language.speedometers,
      component: SpeedometerSettings,
    },
    { id: "Status", label: settings.language.statusSettings, component: StatusSettings },
    {
      id: "ServerInfo",
      label: settings.language.serverInfoSettings,
      component: ServerInfoSettings,
    },
  ];

  const ActiveTabComponent =
    tabs.find((tab) => tab.id === activeTab)?.component || GeneralSettings;

  return (
    <Modal isOpen={isOpen} onClose={onClose}>
      <div className="overflow-hidden relative">
        <div className="sticky w-full top-0 z-10 mb-2 bg-black">
          <SettingsHeader />

          <TabBar
            tabs={tabs.map(({ id, label }) => ({ id, label }))}
            activeTab={activeTab}
            setActiveTab={setActiveTab}
          />
        </div>
        <div className="flex flex-col px-4 gap-y-8 h-[63vh] pb-20 overflow-y-auto">
          <ActiveTabComponent />
        </div>
        <div className="absolute w-full bottom-0 bg-black py-4 px-4 z-50">
          <div className="flex items-center w-full justify-end h-full">
            <button
              onClick={() => restoreDefaults()}
              className="py-2 px-6 bg-neutral-200 bg-opacity-10 rounded-sm border border-neutral-200 flex items-center justify-center"
            >
              <div className="text-center text-neutral-200 text-sm font-bold leading-none tracking-tight">
                {settings.language.restoreDefaults}
              </div>
            </button>
          </div>
        </div>
      </div>
    </Modal>
  );
};

export default SettingsModal;
