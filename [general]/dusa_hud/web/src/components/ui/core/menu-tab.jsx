import clsx from "clsx";

const Tab = ({ label, isActive }) => (
  <div
    className={clsx(
      "grow w-full cursor-pointer shrink basis-0 p-[5.17px] flex-col justify-start items-start gap-[5.17px] inline-flex",
      isActive &&
        "bg-gradient-to-l from-gray-200 to-violet-300 rounded shadow-violet-300 shadow"
    )}
  >
    <div
      className={clsx(
        "self-stretch text-center custom:text-lg text-[10.34px] font-medium font-['Qanelas Soft']",
        {
          "text-gray-950 font-bold": isActive,
          "text-neutral-400": !isActive,
        }
      )}
    >
      {label}
    </div>
  </div>
);

const Tabs = ({ tabs, activeTab, setActiveTab }) => {
  return (
    <div className="w-[369px] opacity-80 custom:w-[600px] p-[2.07px] bg-gradient-to-r from-neutral-950/80 via-neutral-900/80 to-neutral-950/80 rounded rounded-t-none justify-start items-start inline-flex">
      {tabs.map((tab, index) => (
        <div
          className={tabs.length === 1 ? "w-full" : "w-1/" + tabs.length}
          key={index}
          onClick={() => setActiveTab(tab.label)}
        >
          <Tab label={tab.label} isActive={tab.label === activeTab} />
        </div>
      ))}
    </div>
  );
};

export default Tabs;
