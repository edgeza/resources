const StatusStyle8Item = ({ color, activeColor, value, Icon }) => {
  const size = 140;
  const progress = value;
  const strokeWidth = 3;
  const radius = (size - strokeWidth) / 2;
  const circumference = Math.PI * radius;
  const offset = circumference - (progress / 100) * circumference;

  return (
    <div className="flex justify-center items-end relative">
      <svg width={size} height={size / 2}>
        <path
          d={`M ${strokeWidth / 2}, ${size / 2} 
                    a ${radius},${radius} 0 0,1 ${size - strokeWidth},0`}
          fill="none"
          stroke={color}
          strokeWidth={strokeWidth}
        />
        <path
          d={`M ${strokeWidth / 2}, ${size / 2} 
                    a ${radius},${radius} 0 0,1 ${size - strokeWidth},0`}
          fill="none"
          stroke={activeColor}
          strokeWidth={strokeWidth}
          strokeDasharray={circumference}
          strokeDashoffset={offset}
        />
      </svg>
      <svg
        className="absolute"
        width="120"
        height="61"
        viewBox="0 0 120 61"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M119.881 60.2363C119.881 44.4696 113.617 29.3488 102.469 18.2001C91.3201 7.05136 76.1992 0.788087 60.4326 0.788086C44.6659 0.788085 29.545 7.05135 18.3963 18.2C7.24765 29.3487 0.984377 44.4696 0.984375 60.2363L60.4326 60.2363H119.881Z"
          fill="black"
        />
      </svg>

      <div className="absolute bottom-1 z-20">
        <Icon />
      </div>
    </div>
  );
};

export default StatusStyle8Item;
