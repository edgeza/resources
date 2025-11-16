const VehicleMenuTab = ({ tabs, selected, onSelect }) => {
  return (
    <div className="flex">
      {tabs.map((tab, index) => (
        <div
          key={index}
          className={`cursor-pointer ${
            selected === tab.title
              ? "w-full h-[23.34px] pt-[4.93px] pb-[5.40px] bg-gradient-to-l from-zinc-300 to-stone-300 rounded justify-center items-center"
              : "w-full h-[23.34px] py-[5.17px] justify-center items-center"
          } inline-flex`}
          onClick={() => onSelect(tab.title)}
        >
          <div className="grow shrink basis-0 self-stretch relative">
            <div
              className={`flex items-center gap-x-2 justify-center w-full text-center text-[10.34px] font-['Qanelas Soft'] ${
                selected === tab.title
                  ? "text-gray-950 font-bold left-[15.24px]"
                  : "text-neutral-400 font-medium left-[10.67px]"
              } top-0`}
            >
              {<tab.icon />}
              {tab.title}
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default VehicleMenuTab;
