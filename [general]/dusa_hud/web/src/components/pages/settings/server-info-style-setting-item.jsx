import { useSettings } from "../../../contexts/SettingsContext";
import { fetchNui } from "../../../utils/fetchNui";

const ServerInfoStyleSettingItem = ({ serverInfoStyleNumber, children }) => {
  const { settings, updateSettings } = useSettings();

  const handleSelect = () => {
    updateSettings("serverInfoSettings", {
      serverInfoStyle: serverInfoStyleNumber,
    });

    // fetchNui("changeStatus", serverInfoStyleNumber);
  };

  return (
    <div
      style={{
        background:
          "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
      }}
      className="w-full relative flex flex-col  justify-end rounded border border-white border-opacity-20 "
    >
      <div className="flex items-center justify-center h-40">{children}</div>

      <div className="flex flex-col items-center gap-y-5 mb-2 h-28">
        <div className="flex flex-col items-center justify-end h-12">
          <div className="text-center text-neutral-400 text-lg font-semibold font-['Qanelas Soft']">
            {settings.language.serverInfoStyle} #{serverInfoStyleNumber}
          </div>

          {settings.serverInfoSettings.serverInfoStyle ===
            serverInfoStyleNumber && (
            <div className="text-center text-gray-200 text-[10.54px] font-semibold font-['Qanelas Soft']">
              {settings.language.selectedNow}
            </div>
          )}
        </div>
        <div className="flex gap-x-2">
          {settings.serverInfoSettings.serverInfoStyle ===
            serverInfoStyleNumber && (
            <div className="w-[184.70px] h-[32.59px] pl-[70.62px] pr-[19.92px] pt-[5.43px] pb-[4.53px] bg-neutral-200 rounded border-2 border-neutral-200 justify-start items-start inline-flex">
              <div className="text-black text-xs font-bold font-['Satoshi'] leading-snug tracking-tight">
                {settings.language.selected}
              </div>
            </div>
          )}

          {settings.serverInfoSettings.serverInfoStyle !==
            serverInfoStyleNumber && (
            <button
              onClick={() => handleSelect()}
              className="w-[204px] h-9 pl-[78px] pr-[22px] pt-1.5 pb-[5px] bg-neutral-200 bg-opacity-10 rounded border-2 border-neutral-600 justify-start items-start inline-flex"
            >
              <div className="text-neutral-400 text-[13.02px] font-bold font-['Satoshi'] leading-normal tracking-tight">
                {settings.language.select}
              </div>
            </button>
          )}
        </div>
      </div>
    </div>
  );
};

export default ServerInfoStyleSettingItem;
