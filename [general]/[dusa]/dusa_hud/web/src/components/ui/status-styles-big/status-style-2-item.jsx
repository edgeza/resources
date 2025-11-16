const StatusStyle2Item = ({ fillPercentage, Icon }) => {
  const radius = 50;
  const circumference = 2 * Math.PI * radius;
  const filledLength = (circumference * fillPercentage) / 100;

  return (
    <>
      <div className="relative w-28 h-28 flex items-center justify-center">
        <div
          className="w-28 h-28 z-10 absolute rounded-full bg-[#8D8D8D] top-1/2 left-1/2"
          style={{ transform: "translate(-50%, -50%)" }}
        ></div>
        <div
          className="w-[128px] h-[128px] absolute rounded-full bg-white bg-opacity-10 top-1/2 left-1/2"
          style={{ transform: "translate(-50%, -50%)" }}
        ></div>

        <div className="z-50 absolute flex items-center justify-center left-[3px] top-[3px]">
          <svg
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
              stroke="white"
              strokeWidth="1"
              strokeOpacity={0.5}
            />
            <circle
              cx="50"
              cy="50"
              r="44"
              fill="transparent"
              stroke="white"
              strokeWidth="5"
              strokeDasharray={`${filledLength} ${circumference}`}
            />
          </svg>
        </div>
        <div className="absolute z-20">
          <Icon />
        </div>
      </div>
    </>
  );
};

export default StatusStyle2Item;
