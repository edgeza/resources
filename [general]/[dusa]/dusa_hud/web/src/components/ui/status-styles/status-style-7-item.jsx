const StatusStyle7Item = ({ Icon, activeColor, color, percentage }) => {
  const purplePercentage = percentage;

  const squareStyle = {
    width: "2rem",
    height: "2rem",
    transform: "rotate(45deg)",
    backgroundImage: `linear-gradient(to top left, ${activeColor} ${purplePercentage}%,  ${color} ${0}%)`,
  };

  return (
    <div className="relative items-center justify-center w-12 mt-5 h-full">
      <div
        style={squareStyle}
        className="absolute left-2 top-2  border-4 border-black border-opacity-30"
      ></div>
      <div className="absolute z-10 left-[17px] top-4">
        <Icon />
      </div>
    </div>
  );
};

export default StatusStyle7Item;
