const Tab = ({ label, isActive, setActiveTab }) => (
  <div
    onClick={() => setActiveTab(label)}
    className={`h-[23.34px] pt-[4.93px] pb-[5.40px] m-1.5 grow flex cursor-pointerp -1 items-center justify-center shrink basis-0 self-stretch relative ${
      isActive ? "bg-gradient-to-l from-stone-300 to-stone-300" : ""
    } rounded`}
  >
    <div
      className={`w-[80.88px] text-center ${
        isActive ? "text-gray-950/ font-bold" : "text-neutral-400 font-medium"
      } text-[10.34px] font-['Qanelas Soft']`}
    >
      {label}
    </div>
  </div>
);

export default Tab;
