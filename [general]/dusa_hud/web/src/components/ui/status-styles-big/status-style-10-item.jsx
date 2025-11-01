const StatusStyle10Item = ({fillPercentage, Icon, activeColor}) => {
  const radius = 25;
  const circumference = 2 * Math.PI * radius;
  const filledLength = (circumference * fillPercentage) / 100;

  return (
      <div
        className="relative flex items-center justify-center"
        style={{
          width: "100%",
          height: "100%",
          filter: `drop-shadow(0px 0px 14.301px ${activeColor})`,
        }}
      >
        <div
          className="w-18 h-18 z-10 absolute rounded-full  top-1/2 left-1/2"
          style={{ transform: "translate(-50%, -50%)" }}
        ></div>

        <div
          className="w-[75px] h-[75px] absolute rounded-full bg-white bg-opacity-5 top-1/2 left-1/2"
          style={{
            transform: "translate(-50%, -50%)",
            boxShadow: "0px 0px 7.601px 2px " + activeColor + "43",
          }}
        ></div>
        <div
          className="w-18 h-18 z-50 absolute flex items-center justify-center top-1/2 left-1/2"
          style={{ transform: "translate(-50%, -50%)" }}
        >
          <svg
            width="72"
            height="72"
            viewBox="0 0 72 72"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <circle
              cx="36"
              cy="36"
              r="35"
              fill="transparent"
              stroke={activeColor}
              strokeOpacity={0.3}
              strokeWidth="2"
            />
            <circle
              cx="36"
              cy="36"
              r="35"
              fill="transparent"
              stroke={activeColor}
              strokeWidth="2"
              strokeDasharray={`${filledLength} ${circumference*3}`}
            />
          </svg>
        </div>
        <div className="absolute z-20">
          <Icon />
        </div>
      </div>
  );
};

export default StatusStyle10Item;
