const StatusStyle4Item = ({ Icon, activeColor, color, percentage }) => {
  const purplePercentage = percentage;
  const squareStyle = {
    width: "85px",
    height: "85px",
    transform: "rotate(45deg)",
    backgroundImage: `linear-gradient(to top left, ${activeColor} ${purplePercentage}%,  ${color} ${0}%)`,
  };

  return (
    <div
      style={{ backgroundColor: activeColor + "30" }}
      className="relative w-[126px] h-[126px] rounded-full flex items-center justify-center"
    >
      <div style={squareStyle}></div>
      <div className="z-10 absolute ">
        <Icon />
      </div>
    </div>
  );
};
export default StatusStyle4Item;
