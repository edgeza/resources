import { useSettings } from "../../../contexts/SettingsContext";
import { FreeFormEditModeIcon } from "../../icons/free-form-edit-mode-icon";
import { HideIcon } from "../../icons/hide-icon";
import { MinimapIcon } from "../../icons/minimap-icon";
import { ShowLocationIcon } from "../../icons/show-location-icon";
import { SinematicModeIcon } from "../../icons/sinematic-mode-icon";
import { fetchNui } from "../../../utils/fetchNui";
import ListItem from "./settings-item";
import Switch from "../../ui/core/switch";
import { useEffect, useState } from "react";
import { useNuiEvent } from "../../../hooks/useNuiEvent";
import clsx from "clsx";

const GeneralSettings = () => {
  const { settings, updateSettings } = useSettings();

  const toggleSetting = (settingKey) => {
    updateSettings("general", { [settingKey]: !settings.general[settingKey] });
    fetchNui("toggleSetting", {
      key: settingKey,
      status: !settings.general[settingKey],
    });
  };

  const [openStreamModeSetting, setOpenStreamModeSetting] = useState(false);

  const [streamerMode, setStreamerMode] = useState(true);
  useNuiEvent("enableStreamer", setStreamerMode);

  const [playMediaSongs, setPlayMediaSongs] = useState(true);
  useNuiEvent("disableSongs", setPlayMediaSongs);

  const [hidePlayerId, setHidePlayerId] = useState(
    settings.general.hidePlayerId
  );
  useNuiEvent("hidePlayerId", setHidePlayerId);

  const [refreshRate, setRefreshRate] = useState(settings.general.refreshRate);
  fetchNui("setRefreshRate", { rate: refreshRate });

  useEffect(() => {
    updateSettings("general", {
      refreshRate,
    });
  }, [refreshRate]);

  const switchBaseClass = "pl-[17.02px] pr-[18.53px]";
  const activeClass =
    "py-[7.01px] bg-neutral-200 bg-opacity-10 rounded-lg shadow shadow-white border-2 border-neutral-200 justify-start items-start inline-flex";
  const textBaseClass = "font-['Qanelas Soft'] leading-normal tracking-tight";

  return (
    <div className="flex flex-col gap-y-2 w-full bg-black">
      <div
        style={{
          background:
            "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
        }}
        className="flex items-center justify-between px-8 py-4 rounded-[5px] font-['Qanelas Soft']"
      >
        <div className="flex items-center gap-x-8">
          <svg
            width="21"
            height="21"
            viewBox="0 0 21 21"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M17.8066 4.47411V8.22411C17.8066 8.38987 17.7408 8.54884 17.6236 8.66605C17.5064 8.78326 17.3474 8.84911 17.1816 8.84911H13.4316C13.308 8.8492 13.187 8.8126 13.0842 8.74393C12.9813 8.67526 12.9011 8.57761 12.8538 8.46335C12.8064 8.34908 12.794 8.22334 12.8182 8.10204C12.8423 7.98074 12.9019 7.86933 12.9895 7.78192L14.4199 6.34911C13.2692 5.24656 11.7386 4.62867 10.1449 4.62332H10.1098C8.47676 4.62012 6.90815 5.26003 5.74336 6.40457C5.624 6.516 5.46578 6.57628 5.30253 6.57254C5.13929 6.5688 4.984 6.50132 4.86988 6.38454C4.75575 6.26776 4.69186 6.11096 4.69187 5.94767C4.69188 5.78439 4.75578 5.62759 4.86992 5.51082C6.26319 4.14956 8.1314 3.38375 10.0793 3.37543C12.0271 3.36712 13.9018 4.11696 15.3066 5.46629L16.741 4.03192C16.8285 3.94495 16.9398 3.88581 17.0608 3.86196C17.1819 3.83811 17.3072 3.85062 17.4212 3.8979C17.5351 3.94518 17.6325 4.02512 17.7011 4.12766C17.7697 4.2302 17.8064 4.35074 17.8066 4.47411ZM14.8699 15.0436C13.7122 16.1744 12.1611 16.812 10.5428 16.8223C8.92459 16.8327 7.36542 16.2149 6.19336 15.0991L7.62383 13.6686C7.71215 13.5814 7.77246 13.4697 7.79709 13.348C7.82171 13.2263 7.80952 13.1001 7.76208 12.9853C7.71464 12.8706 7.63409 12.7725 7.53071 12.7038C7.42733 12.635 7.30581 12.5985 7.18164 12.5991H3.43164C3.26588 12.5991 3.10691 12.665 2.9897 12.7822C2.87249 12.8994 2.80664 13.0583 2.80664 13.2241V16.9741C2.80654 17.0978 2.84315 17.2187 2.91182 17.3216C2.98048 17.4245 3.07813 17.5046 3.1924 17.552C3.30666 17.5993 3.4324 17.6117 3.55371 17.5876C3.67501 17.5634 3.78642 17.5038 3.87383 17.4163L5.30664 15.9819C6.69117 17.3181 8.53874 18.0672 10.4629 18.0725H10.5043C12.4637 18.0776 14.3463 17.3105 15.7441 15.9374C15.8583 15.8206 15.9222 15.6638 15.9222 15.5005C15.9222 15.3373 15.8583 15.1805 15.7442 15.0637C15.6301 14.9469 15.4748 14.8794 15.3115 14.8757C15.1483 14.8719 14.9901 14.9322 14.8707 15.0436H14.8699Z"
              fill="#999999"
            />
          </svg>

          <div className="flex flex-col gap-y-2 items-start justify-start">
            <div className="text-center text-neutral-400 text-[21.25px] font-semibold">
              {settings.language.refreshRateSpeed}
            </div>
            <div className="text-center text-zinc-500 text-xs font-semibold">
              {settings.language.onOffSettings}
            </div>
          </div>
        </div>
        <div className="flex items-center cursor-pointer justify-center px-3 py-2 bg-white bg-opacity-0 rounded-lg border border-white border-opacity-10 backdrop-blur-[12.71px]">
          <div
            onClick={() => setRefreshRate("Low")}
            className={clsx(
              switchBaseClass,
              { [activeClass]: refreshRate === "Low" },
              "justify-start items-start inline-flex"
            )}
          >
            <div
              className={clsx(
                textBaseClass,
                refreshRate === "Low"
                  ? "text-neutral-200 text-[13.02px] font-bold"
                  : "text-zinc-500 text-sm font-medium"
              )}
            >
              {settings.language.low}
            </div>
          </div>
          <div
            onClick={() => setRefreshRate("Medium")}
            className={clsx(
              switchBaseClass,
              { [activeClass]: refreshRate === "Medium" },
              "justify-start items-start inline-flex"
            )}
          >
            <div
              className={clsx(
                textBaseClass,
                refreshRate === "Medium"
                  ? "text-neutral-200 text-[13.02px] font-bold"
                  : "text-zinc-500 text-sm font-medium"
              )}
            >
              {settings.language.medium}
            </div>
          </div>
          <div
            onClick={() => setRefreshRate("High")}
            className={clsx(
              switchBaseClass,
              { [activeClass]: refreshRate === "High" },
              "justify-start items-start inline-flex"
            )}
          >
            <div
              className={clsx(
                textBaseClass,
                refreshRate === "High"
                  ? "text-neutral-200 text-[13.02px] font-bold"
                  : "text-zinc-500 text-sm font-medium"
              )}
            >
              {settings.language.high}
            </div>
          </div>
          <div
            onClick={() => setRefreshRate("Real Time")}
            className={clsx(
              switchBaseClass,
              { [activeClass]: refreshRate === "Real Time" },
              "justify-start items-start inline-flex"
            )}
          >
            <div
              className={clsx(
                textBaseClass,
                refreshRate === "Real Time"
                  ? "text-neutral-200 text-[13.02px] font-bold"
                  : "text-zinc-500 text-sm font-medium"
              )}
            >
              {settings.language.realTime}
            </div>
          </div>
        </div>
      </div>

      <div
        onClick={() => setOpenStreamModeSetting(!openStreamModeSetting)}
        style={{
          background:
            "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
        }}
        className="flex items-center justify-between px-8 py-4 rounded-[5px] font-['Qanelas Soft']"
      >
        <div className="flex items-center gap-x-8">
          <svg
            width="34"
            height="27"
            viewBox="0 0 34 27"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M5.23443 25.769C5.23451 25.9333 5.19943 26.0959 5.13128 26.2472C5.06313 26.3986 4.9633 26.5355 4.8377 26.6499C4.7121 26.7644 4.56329 26.854 4.4001 26.9134C4.23691 26.9729 4.06265 27.001 3.88768 26.9961C3.54482 26.9758 3.223 26.834 2.98748 26.5993C2.75195 26.3645 2.62036 26.0546 2.61938 25.7322C2.60952 25.4194 2.47273 25.122 2.23698 24.9007C2.00123 24.6795 1.68433 24.5511 1.35108 24.5419C1.00754 24.541 0.677238 24.4175 0.427147 24.1964C0.177056 23.9754 0.025897 23.6734 0.0043237 23.3516C-0.000928055 23.1874 0.0290106 23.0238 0.0923646 22.8707C0.155719 22.7175 0.251198 22.5779 0.37314 22.46C0.495082 22.3421 0.641004 22.2484 0.802252 22.1845C0.9635 22.1205 1.13679 22.0876 1.31185 22.0877C2.35218 22.0877 3.34991 22.4755 4.08553 23.1659C4.82116 23.8563 5.23443 24.7926 5.23443 25.769ZM1.31185 17.1793C1.13083 17.1788 0.95165 17.2135 0.785668 17.2813C0.619687 17.3491 0.470516 17.4485 0.347603 17.5732C0.22469 17.6979 0.130712 17.8453 0.0716215 18.0058C0.0125308 18.1664 -0.0103856 18.3368 0.0043237 18.5061C0.0378254 18.8181 0.194723 19.1069 0.444047 19.3156C0.693371 19.5244 1.01701 19.6378 1.35108 19.6335C3.07138 19.6432 4.71831 20.2888 5.93477 21.4304C7.15123 22.5721 7.83919 24.1177 7.84948 25.7322C7.84497 26.0459 7.96605 26.3498 8.18878 26.5839C8.41152 26.8179 8.71969 26.965 9.0524 26.9961C9.2327 27.0096 9.41404 26.988 9.58495 26.9324C9.75586 26.8769 9.91264 26.7886 10.0454 26.6733C10.1781 26.558 10.2839 26.4181 10.356 26.2624C10.4282 26.1067 10.4651 25.9387 10.4645 25.769C10.4619 23.4916 9.4968 21.3082 7.78091 19.6979C6.06501 18.0875 3.7385 17.1818 1.31185 17.1793ZM1.31185 12.2709C1.13157 12.2705 0.953133 12.305 0.787748 12.3723C0.622363 12.4397 0.473603 12.5384 0.350814 12.6623C0.228024 12.7861 0.133858 12.9325 0.0742301 13.0922C0.0146025 13.2518 -0.00919804 13.4214 0.0043237 13.5901C0.0378599 13.9043 0.195857 14.1953 0.447059 14.4055C0.698262 14.6157 1.02437 14.7298 1.36088 14.7251C4.46328 14.7404 7.43402 15.9036 9.62808 17.9621C11.8221 20.0207 13.0624 22.8083 13.0796 25.7199C13.0746 26.0357 13.1962 26.3417 13.4201 26.5775C13.6441 26.8132 13.9542 26.9615 14.289 26.993C14.4688 27.0057 14.6494 26.9834 14.8196 26.9274C14.9897 26.8714 15.1457 26.7831 15.2777 26.6678C15.4097 26.5526 15.5149 26.413 15.5866 26.2578C15.6584 26.1026 15.6951 25.9351 15.6946 25.7659C15.6894 22.1878 14.1723 18.7576 11.4761 16.2278C8.77982 13.698 5.12451 12.275 1.31185 12.2709ZM31.3849 0H2.61938C1.92582 0 1.26067 0.258565 0.770255 0.718815C0.279837 1.17906 0.0043237 1.8033 0.0043237 2.45419V9.21548C0.00426183 9.29802 0.021949 9.37973 0.056326 9.45571C0.0907031 9.53169 0.141063 9.60038 0.204391 9.65766C0.267719 9.71494 0.342713 9.75965 0.424883 9.78909C0.507053 9.81854 0.594709 9.83212 0.682603 9.82902C3.01836 9.75029 5.34635 10.124 7.52142 10.9269C9.6965 11.7297 11.672 12.9445 13.3248 14.4954C14.9775 16.0464 16.2721 17.9003 17.1278 19.9415C17.9835 21.9827 18.3819 24.1674 18.2982 26.3595C18.2949 26.442 18.3094 26.5243 18.3408 26.6014C18.3722 26.6785 18.4198 26.7489 18.4808 26.8083C18.5419 26.8677 18.6151 26.915 18.696 26.9473C18.777 26.9795 18.8641 26.9961 18.952 26.9961H31.3849C32.0785 26.9961 32.7437 26.7375 33.2341 26.2773C33.7245 25.817 34 25.1928 34 24.5419V2.45419C34 1.8033 33.7245 1.17906 33.2341 0.718815C32.7437 0.258565 32.0785 0 31.3849 0Z"
              fill="#888888"
            />
          </svg>

          <div className="flex flex-col gap-y-2 items-start justify-start">
            <div className="text-center text-neutral-400 text-[21.25px] font-semibold">
              {settings.language.streamerMode}
            </div>
            <div className="text-center text-zinc-500 text-xs font-semibold">
              {settings.language.modeOn}
            </div>
          </div>
        </div>
        <div>
          {!openStreamModeSetting && (
            <svg
              width="19"
              height="20"
              viewBox="0 0 19 20"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M9.5 20L4.08108e-07 5.68348e-07L9.5 7.5799L19 2.22938e-06L9.5 20Z"
                fill="#888888"
              />
            </svg>
          )}
          {openStreamModeSetting && (
            <svg
              width="20"
              height="21"
              viewBox="0 0 20 21"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M9.78711 0.339722L19.2871 20.3397L9.78711 12.7598L0.287109 20.3397L9.78711 0.339722Z"
                fill="#888888"
              />
            </svg>
          )}
        </div>
      </div>
      {openStreamModeSetting && (
        <div
          style={{
            background:
              "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
          }}
          className="flex items-center gap-x-10 justify-between px-8 py-4 rounded-[5px] font-['Qanelas Soft']"
        >
          <div className="w-1/3  h-[39.58px] flex items-center gap-x-6">
            <div className=" text-neutral-400 text-[17.15px] font-semibold ">
              {settings.language.enableStreamerMode}
            </div>

            <Switch
              isOn={streamerMode}
              onToggle={() => setStreamerMode(!streamerMode)}
            />
          </div>
          <div className="w-1/3  h-[39.58px] flex items-center gap-x-6">
            <div className=" text-neutral-400 text-[17.15px] font-semibold ">
              {settings.language.playMediaSongs}
            </div>
            <Switch
              isOn={playMediaSongs}
              onToggle={() => setPlayMediaSongs(!playMediaSongs)}
            />
          </div>
          <div className="w-1/3 h-[39.58px] flex items-center gap-x-6">
            <div className="text-neutral-400 text-[17.15px] font-semibold ">
              {settings.language.showMyID}
            </div>

            <Switch
              isOn={!hidePlayerId}
              onToggle={() => {
                toggleSetting("hidePlayerId");
                setHidePlayerId(!hidePlayerId);
              }}
            />
          </div>
        </div>
      )}
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.cinematicMode}
        icon={<SinematicModeIcon />}
        isOn={settings.general.cinematicMode}
        handleToggle={() => toggleSetting("cinematicMode")}
      />
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.showLocation}
        icon={<ShowLocationIcon />}
        isOn={settings.general.showLocation}
        handleToggle={() => toggleSetting("showLocation")}
      />
      {!settings.general.disableMinimap && (
        <ListItem
          description={settings.language.onOffSettings}
          title={settings.language.minimap}
          icon={<MinimapIcon />}
          isOn={settings.general.minimap}
          handleToggle={() => toggleSetting("minimap")}
        />
      )}
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.freeformEditMode}
        icon={<FreeFormEditModeIcon />}
        isOn={settings.general.freeformEditMode}
        handleToggle={() => toggleSetting("freeformEditMode")}
      />
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.hideAllHud}
        icon={<HideIcon />}
        isOn={settings.general.hideAllHud}
        handleToggle={() => toggleSetting("hideAllHud")}
      />
      <ListItem
        description={settings.language.onOffSettings}
        title={settings.language.hideFocus}
        icon={<HideIcon />}
        isOn={settings.general.hideFocus}
        handleToggle={() => toggleSetting("hideFocus")}
      />
    </div>
  );
};

export default GeneralSettings;
