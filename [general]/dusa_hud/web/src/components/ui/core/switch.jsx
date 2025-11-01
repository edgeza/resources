import clsx from "clsx";

const Switch = ({isOn, onToggle}) => {
  const switchBaseClass = "w-16 pl-[17.02px] pr-[18.53px]";
  const activeClass =
    "py-[7.01px] bg-neutral-200 bg-opacity-10 rounded-lg shadow shadow-white border-2 border-neutral-200 justify-start items-start inline-flex";
  const textBaseClass = "font-['Qanelas Soft'] leading-normal tracking-tight";

  return (
    <button
      onClick={() => onToggle(!isOn)}
      className="flex items-center cursor-pointer justify-center px-3 py-2 bg-white bg-opacity-0 rounded-lg border border-white border-opacity-10 backdrop-blur-[12.71px]"
    >
      <div
        className={clsx(
          switchBaseClass,
          { [activeClass]: isOn },
          "justify-start items-start inline-flex"
        )}
      >
        <div
          className={clsx(
            textBaseClass,
            isOn
              ? "text-neutral-200 text-[13.02px] font-bold"
              : "text-zinc-500 text-sm font-medium"
          )}
        >
          ON
        </div>
      </div>
      <div
        className={clsx(
          switchBaseClass,
          { [activeClass]: !isOn },
          "justify-start items-start inline-flex"
        )}
      >
        <div
          className={clsx(
            textBaseClass,
            !isOn
              ? "text-neutral-200 text-[13.02px] font-bold"
              : "text-zinc-500 text-sm font-medium"
          )}
        >
          OFF
        </div>
      </div>
    </button>
  );
};

export default Switch;
