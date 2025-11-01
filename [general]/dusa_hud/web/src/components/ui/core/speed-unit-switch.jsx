import clsx from "clsx";

const SpeedUnitSwitch = ({isOn, onToggle}) => {
  const switchBaseClass =
    "w-16 pl-[17.02px] pr-[18.53px] justify-start items-start inline-flex";
  const textBaseClass = "font-['Satoshi'] leading-normal tracking-tight";

  const activeClass =
    "py-[7.01px] bg-neutral-200 bg-opacity-10 rounded-lg shadow shadow-white border-2 border-neutral-200";
  const inactiveClass = "bg-white bg-opacity-0";

  return (
    <button
      onClick={() => onToggle(!isOn)}
      className="flex items-center cursor-pointer justify-center px-3 py-2 rounded-lg border border-white border-opacity-10 backdrop-blur-[12.71px]"
    >
      <div
        className={clsx(switchBaseClass, isOn ? activeClass : inactiveClass)}
      >
        <div
          className={clsx(textBaseClass, "text-[13.02px]", {
            "text-neutral-200 font-bold": isOn,
            "text-zinc-500 font-medium": !isOn,
          })}
        >
          KMH
        </div>
      </div>
      <div
        className={clsx(switchBaseClass, !isOn ? activeClass : inactiveClass)}
      >
        <div
          className={clsx(textBaseClass, "text-[13.02px]", {
            "text-neutral-200 font-bold": !isOn,
            "text-zinc-500 font-medium": isOn,
          })}
        >
          MPH
        </div>
      </div>
    </button>
  );
};

export default SpeedUnitSwitch;
