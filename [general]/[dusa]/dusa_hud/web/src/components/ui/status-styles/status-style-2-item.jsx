const StatusStyle2Item = ({ fillPercentage, Icon }) => {
  const radius = 18;
  const circumference = 2 * Math.PI * radius;
  const filledLength = (circumference * fillPercentage) / 100;

  return (
    <>
      <div
        className="relative flex items-center justify-center"
        style={{ width: "100%", height: "100%" }}
      >
        <div
          className="w-9 h-9 z-10 absolute rounded-full bg-[#8D8D8D] top-1/2 left-1/2"
          style={{ transform: "translate(-50%, -50%)" }}
        ></div>
        <div
          className="w-[41px] h-[41px] absolute rounded-full bg-white bg-opacity-10 top-1/2 left-1/2"
          style={{ transform: "translate(-50%, -50%)" }}
        ></div>
        <div
          className="w-[43px] h-[43px] absolute rounded-full bg-white bg-opacity-30 top-1/2 left-1/2"
          style={{ transform: "translate(-50%, -50%)" }}
        ></div>
        <div
          className="w-[36px] h-[36px] z-50 absolute flex items-center justify-center top-1/2 left-1/2"
          style={{ transform: "translate(-50%, -50%)" }}
        >
          <svg
            width="36"
            height="36"
            viewBox="0 0 36 36"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <circle
              cx="18"
              cy="18"
              r="17"
              fill="transparent"
              stroke="#8D8D8D"
              strokeWidth="2"
            />
            <circle
              cx="18"
              cy="18"
              r="17"
              fill="transparent"
              stroke="white"
              strokeWidth="2"
              strokeDasharray={`${filledLength} ${circumference}`}
              transform="rotate(-90) translate(-36)"
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
