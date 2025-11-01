const StatusStyle6Item = ({Icon, value}) => {
  const calculatedPercentage = (value * 256) / 100;

  return (
    <div className="flex justify-center items-center relative w-24 h-24">
      <svg
        className="absolute"
        width="90"
        height="90"
        viewBox="0 0 90 90"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <rect
          strokeDasharray={`${calculatedPercentage} 1000`}
          strokeWidth={3}
          stroke="white"
          x="44.7559"
          y="88.9812"
          width="64"
          height="64"
          transform="rotate(-135 44.7559 88.9812)"
          fill="white"
          fillOpacity="0.25"
        />
      </svg>
      <svg
        className="absolute"
        width="76"
        height="76"
        viewBox="0 0 76 76"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <rect
          x="74.6455"
          y="36.7368"
          width="53.7136"
          height="53.7136"
          rx="0.782758"
          transform="rotate(135 74.6455 36.7368)"
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
