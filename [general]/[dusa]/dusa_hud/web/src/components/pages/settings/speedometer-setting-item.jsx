import { useSettings } from "../../../contexts/SettingsContext";

const SpeedometerSettingsItem = ({ speedometerNumber, children }) => {
  const { settings, updateSettings } = useSettings();

  const handleSelect = () => {
    updateSettings("speedometers", {
      speedometerType: speedometerNumber.toString(),
    });
  };

  return (
    <div
      style={{
        background:
          "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
      }}
      className="w-[231.51px] relative h-[231.51px] flex flex-col justify-end ounded border border-white border-opacity-20 "
    >
      <div className="flex items-center justify-center h-28 z-50">{children}</div>

      <div className="flex flex-col items-center gap-y-5 mb-2 h-28">
        <div className="flex flex-col items-center justify-start h-12">
          <div className="text-center text-neutral-400 text-lg font-semibold font-['Qanelas Soft']">
            {settings.language.speedometerType} #{speedometerNumber}
          </div>

          {settings.speedometers.speedometerType ===
            speedometerNumber.toString() && (
            <div className="text-center text-gray-200 text-[10.54px] font-semibold font-['Qanelas Soft']">
              {settings.language.selectedNow}
            </div>
          )}
        </div>

        {settings.speedometers.speedometerType ===
          speedometerNumber.toString() && (
          <div className="w-[184.70px] h-[32.59px] pl-[70.62px] pr-[19.92px] pt-[5.43px] pb-[4.53px] bg-neutral-200 rounded border-2 border-neutral-200 justify-start items-start inline-flex">
            <div className="text-black text-xs font-bold font-['Satoshi'] leading-snug tracking-tight">
              {settings.language.selected}
            </div>
          </div>
        )}

        {settings.speedometers.speedometerType !==
          speedometerNumber.toString() && (
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
  );
};

export default SpeedometerSettingsItem;
