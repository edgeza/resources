const StatusStyle5Item = ({ fillPercentage, Icon, activeColor }) => {
  const radius = 50;
  const circumference = 2 * Math.PI * radius;
  const filledLength = (circumference * fillPercentage) / 100;

  return (
    <div className="relative w-28 h-28 flex items-center justify-center">
      <div
        className="w-28 h-28 z-10 absolute rounded-full bg-black top-1/2 left-1/2"
        style={{ transform: "translate(-50%, -50%)" }}
      ></div>
      <div
        className="w-[128px] h-[128px] absolute rounded-full bg-black  top-1/2 left-1/2"
        style={{ transform: "translate(-50%, -50%)" }}
      ></div>

      <div className="z-50 absolute flex items-center justify-center left-[58px] top-[58px]">
        <svg
          className="absolute"
          width="110"
          height="110"
          viewBox="0 0 104 104"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <circle
            cx="50"
            cy="50"
            r="44"
            fill="transparent"
            stroke="black"
            strokeWidth="2"
          />
          <circle
            cx="50"
            cy="50"
            r="44"
            fill="transparent"
            stroke={activeColor}
            strokeWidth="5"
            strokeDasharray={`${filledLength} ${circumference}`}
          />
        </svg>
      </div>
      <div className="absolute z-20">
        <Icon />
      </div>
    </div>
  );
};

export default StatusStyle5Item;
