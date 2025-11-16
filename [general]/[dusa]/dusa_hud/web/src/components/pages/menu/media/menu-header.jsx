import { useState } from "react";
import { useNuiEvent } from "../../../../hooks/useNuiEvent";
import { useSettings } from "../../../../contexts/SettingsContext";

const LogoAndLocation = () => {
  const { settings } = useSettings();
  const [direction, setDirection] = useState("NE");
  useNuiEvent("setCompassDirection", setDirection);

  const [location1, setLocation1] = useState("");
  useNuiEvent("setStreet_1", setLocation1);

  const [location2, setLocation2] = useState("");
  useNuiEvent("setStreet_2", setLocation2);

  const [openMic, setOpenMic] = useState(false);
  useNuiEvent("setProximityActive", setOpenMic);

  const [mic, setMic] = useState(0);
  useNuiEvent("setProximity", setMic);

  return (
    <div className="flex w-full items-center justify-between">
      <div className="flex gap-x-2 items-center">
        <div className="w-[32.56px] h-[32.56px] custom:w-16 custom:h-16 flex items-center justify-center bg-gradient-to-b from-violet-300 to-gray-200 rounded-[0.57px]">
          <div className="text-center text-black text-xs custom:text-lg font-extrabold">
            {direction}
          </div>
        </div>
        <div className="flex flex-col gap-y-2 items-start justify-start">
          <div className="text-center custom:text-lg text-white text-xs font-semibold">
            {location1}
          </div>
          <div className="text-center custom:text-lg text-white text-opacity-50 text-[7.95px] font-bold">
            {location2}
          </div>
        </div>
      </div>
      {settings.status.statusStyleType !== "10" && (
        <svg
          width="33"
          height="34"
          viewBox="0 0 33 34"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <rect
            x="0.443359"
            y="0.716156"
            width="32.5565"
            height="32.5565"
            rx="0.581367"
            fill="#010100"
            fill-opacity="0.33"
          />
          <rect
            x="0.443359"
            y="1.3687"
            width="32.5565"
            height="32.5565"
            rx="0.581367"
            fill="url(#paint0_linear_0_1)"
          />
          <path
            d="M14.1479 16.9184V13.7779C14.1479 13.1532 14.3961 12.5541 14.8378 12.1124C15.2795 11.6707 15.8786 11.4225 16.5033 11.4225C17.128 11.4225 17.7271 11.6707 18.1688 12.1124C18.6105 12.5541 18.8587 13.1532 18.8587 13.7779V16.9184C18.8587 17.5431 18.6105 18.1422 18.1688 18.584C17.7271 19.0257 17.128 19.2738 16.5033 19.2738C15.8786 19.2738 15.2795 19.0257 14.8378 18.584C14.3961 18.1422 14.1479 17.5431 14.1479 16.9184ZM20.429 16.9184C20.429 16.8143 20.3876 16.7145 20.314 16.6409C20.2404 16.5672 20.1405 16.5259 20.0364 16.5259C19.9323 16.5259 19.8324 16.5672 19.7588 16.6409C19.6852 16.7145 19.6438 16.8143 19.6438 16.9184C19.6438 17.7514 19.313 18.5502 18.724 19.1391C18.135 19.7281 17.3362 20.059 16.5033 20.059C15.6704 20.059 14.8716 19.7281 14.2826 19.1391C13.6936 18.5502 13.3628 17.7514 13.3628 16.9184C13.3628 16.8143 13.3214 16.7145 13.2478 16.6409C13.1742 16.5672 13.0743 16.5259 12.9702 16.5259C12.8661 16.5259 12.7662 16.5672 12.6926 16.6409C12.619 16.7145 12.5776 16.8143 12.5776 16.9184C12.5788 17.8913 12.9407 18.8291 13.5933 19.5506C14.2459 20.2721 15.1429 20.726 16.1107 20.8245V22.0218C16.1107 22.1259 16.1521 22.2258 16.2257 22.2994C16.2993 22.373 16.3992 22.4144 16.5033 22.4144C16.6074 22.4144 16.7073 22.373 16.7809 22.2994C16.8545 22.2258 16.8959 22.1259 16.8959 22.0218V20.8245C17.8637 20.726 18.7607 20.2721 19.4133 19.5506C20.0659 18.8291 20.4278 17.8913 20.429 16.9184Z"
            fill="black"
            fillOpacity={openMic ? 1 : 0.5}
          />
          <rect
            x="2"
            y="30"
            width="9"
            height="2"
            rx="0.6"
            fill={mic >= 1 ? "black" : "none"}
          />
          <rect
            x="13"
            y="30"
            width="9"
            height="2"
            rx="0.6"
            fill={mic >= 2 ? "black" : "none"}
          />
          <rect
            x="23"
            y="30"
            width="9"
            height="2"
            rx="0.6"
            fill={mic >= 3 ? "black" : "none"}
          />
          <defs>
            <linearGradient
              id="paint0_linear_0_1"
              x1="16.7216"
              y1="1.3687"
              x2="16.7216"
              y2="33.9252"
              gradientUnits="userSpaceOnUse"
            >
              <stop stop-color="#C8C0E9" />
              <stop offset="1" stop-color="#E8DCF2" />
            </linearGradient>
          </defs>
        </svg>
      )}
    </div>
  );
};

export default LogoAndLocation;
