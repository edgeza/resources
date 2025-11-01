const StatusStyle8Item = ({ color, activeColor, value, Icon }) => {
  const size = 50;
  const progress = value;
  const strokeWidth = 2;
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
        width="43"
        height="22"
        viewBox="0 0 43 22"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M42.6154 21.0663C42.6154 15.5077 40.4073 10.1768 36.4768 6.24629C32.5463 2.3158 27.2154 0.107666 21.6568 0.107666C16.0983 0.107666 10.7674 2.3158 6.83687 6.24629C2.90637 10.1768 0.698243 15.5077 0.698242 21.0663L21.6568 21.0663H42.6154Z"
          fill="#0B0B0B"
        />
        <path
          d="M42.6154 21.0663C42.6154 15.5077 40.4073 10.1768 36.4768 6.24629C32.5463 2.3158 27.2154 0.107666 21.6568 0.107666C16.0983 0.107666 10.7674 2.3158 6.83687 6.24629C2.90637 10.1768 0.698243 15.5077 0.698242 21.0662H1.11768C1.11768 15.6189 3.28162 10.3947 7.13346 6.54288C10.9853 2.69104 16.2095 0.527105 21.6568 0.527105C27.1042 0.527106 32.3284 2.69105 36.1802 6.54288C40.032 10.3947 42.196 15.6189 42.196 21.0663H42.6154Z"
          fill={activeColor}
        />
      </svg>
      <div className="absolute bottom-1">
        <Icon />
      </div>
    </div>
  );
};

export default StatusStyle8Item;
