const StatusStyle6Item = ({Icon, value}) => {
  const calculatedPercentage = (value * 128) / 100;

  return (
    <div className="flex justify-center items-center relative w-12 h-12">
      <svg
        className="absolute"
        width="45"
        height="45"
        viewBox="0 0 45 45"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <rect
          strokeDasharray={`${calculatedPercentage} 100`}
          strokeWidth={2}
          stroke="white"
          x="22.7559"
          y="44.9812"
          width="32"
          height="32"
          transform="rotate(-135 22.7559 44.9812)"
          fill="white"
          fillOpacity="0.25"
        />
      </svg>
      <svg
        className="absolute"
        width="38"
        height="38"
        viewBox="0 0 38 38"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <rect
          x="37.6455"
          y="18.7368"
          width="26.7136"
          height="26.7136"
          rx="0.782758"
          transform="rotate(135 37.6455 18.7368)"
          fill="black"
        />
      </svg>
      <div className="absolute">
        <Icon />
      </div>
    </div>
  );
};

export default StatusStyle6Item;
