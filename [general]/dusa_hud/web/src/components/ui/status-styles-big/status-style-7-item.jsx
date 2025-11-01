const StatusStyle7Item = ({ Icon, activeColor, color, percentage }) => {
  const purplePercentage = percentage;

  const squareStyle = {
    width: "85px",
    height: "85px",
    backgroundImage: `linear-gradient(to top left, ${activeColor} ${purplePercentage}%,  ${color} ${0}%)`,
  };

  return (
    <div className="relative w-[126px] bg-black bg-opacity-20 h-[126px] rotate-45 flex items-center justify-center">
      <div style={squareStyle}></div>
      <div className="z-10 absolute -rotate-45">
        <Icon />
      </div>
    </div>
  );
};

export default StatusStyle7Item;
