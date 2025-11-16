const StatusStyle4Item = ({Icon, activeColor, color, percentage}) => {
  const purplePercentage = percentage;
  const squareStyle = {
    width: "2rem",
    height: "2rem",
    transform: "rotate(45deg)",
    backgroundImage: `linear-gradient(to top left, ${activeColor} ${purplePercentage}%,  ${color} ${0}%)`,
  };

  return (
    <div
      style={{ backgroundColor: activeColor + "30" }}
      className="relative w-12 h-12 rounded-full items-center justify-center"
    >
      <div style={squareStyle} className="absolute left-2 top-2"></div>
      <div className="absolute z-10 left-[17px] top-4">
        <Icon />
      </div>
    </div>
  );
};
export default StatusStyle4Item;
