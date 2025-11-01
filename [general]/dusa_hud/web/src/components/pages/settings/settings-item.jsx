import Switch from "../../ui/core/switch";

const ListItem = ({ title, description, icon, isOn, handleToggle }) => {
  return (
    <div
      style={{
        background:
          "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
      }}
      className="flex items-center justify-between px-8 py-4 rounded-[5px] font-['Qanelas Soft']"
    >
      <div className="flex items-center gap-x-8">
        {icon}
        <div className="flex flex-col gap-y-2 items-start justify-start">
          <div className="text-center text-neutral-400 text-[21.25px] font-semibold">
            {title}
          </div>
          <div className="text-center text-zinc-500 text-xs font-semibold">
            {description}
          </div>
        </div>
      </div>
      <Switch isOn={isOn} onToggle={() => handleToggle(!isOn)} />
    </div>
  );
};

export default ListItem;
