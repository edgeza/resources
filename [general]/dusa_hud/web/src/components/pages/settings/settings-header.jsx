import { useSettings } from "../../../contexts/SettingsContext";

const SettingsHeader = () => {
  const { settings } = useSettings();
  return (
    <div
      style={{
        background:
          "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
      }}
      className="flex px-4 w-full mb-2 h-[126.67px] items-center bg-opacity-100 justify-between "
    >
      <div className="flex items-center gap-x-2">
        <svg
          width="63"
          height="64"
          viewBox="0 0 63 64"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <rect
            y="0.806946"
            width="62.4688"
            height="62.4688"
            rx="1.64392"
            fill="url(#paint0_linear_79_641)"
          />
          <path
            d="M44.9436 29.5787C44.915 29.434 44.8556 29.2972 44.7694 29.1775C44.6832 29.0579 44.5722 28.9582 44.4441 28.8852L40.6132 26.702L40.5978 22.3845C40.5974 22.2358 40.5646 22.089 40.5019 21.9542C40.4391 21.8194 40.3479 21.6998 40.2344 21.6037C38.8448 20.4283 37.2445 19.5275 35.5187 18.9492C35.3828 18.9032 35.2388 18.8862 35.0959 18.8993C34.953 18.9123 34.8145 18.9551 34.6891 19.025L30.8249 21.1851L26.9569 19.0211C26.8315 18.9509 26.6927 18.9077 26.5496 18.8945C26.4065 18.8812 26.2622 18.8981 26.126 18.9441C24.4012 19.526 22.8027 20.4303 21.4155 21.6088C21.3022 21.7048 21.211 21.8242 21.1483 21.9587C21.0855 22.0933 21.0527 22.2399 21.052 22.3884L21.0328 26.7098L17.202 28.8929C17.0738 28.9659 16.9628 29.0656 16.8766 29.1852C16.7904 29.3049 16.731 29.4417 16.7024 29.5864C16.3518 31.3482 16.3518 33.1618 16.7024 34.9236C16.731 35.0683 16.7904 35.2051 16.8766 35.3248C16.9628 35.4444 17.0738 35.5441 17.202 35.6171L21.0328 37.8003L21.0482 42.1191C21.0487 42.2678 21.0814 42.4146 21.1441 42.5494C21.2069 42.6842 21.2982 42.8038 21.4116 42.8999C22.8012 44.0753 24.4015 44.9761 26.1273 45.5544C26.2632 45.6004 26.4072 45.6174 26.5501 45.6043C26.693 45.5913 26.8315 45.5484 26.9569 45.4786L30.8249 43.3121L34.693 45.476C34.8461 45.5613 35.0186 45.6055 35.1938 45.6044C35.306 45.6044 35.4175 45.5862 35.5239 45.5505C37.2482 44.9688 38.8466 44.0655 40.2344 42.8883C40.3477 42.7924 40.4389 42.673 40.5016 42.5384C40.5643 42.4039 40.5972 42.2573 40.5978 42.1088L40.6171 37.7874L44.4479 35.6042C44.5761 35.5313 44.687 35.4316 44.7732 35.3119C44.8594 35.1923 44.9189 35.0554 44.9475 34.9108C45.2961 33.1504 45.2948 31.3386 44.9436 29.5787ZM30.8249 37.3855C29.809 37.3855 28.8158 37.0842 27.971 36.5197C27.1263 35.9553 26.4679 35.153 26.0791 34.2144C25.6903 33.2757 25.5886 32.2429 25.7868 31.2464C25.985 30.25 26.4742 29.3347 27.1926 28.6163C27.911 27.8979 28.8263 27.4086 29.8228 27.2104C30.8192 27.0122 31.8521 27.1139 32.7907 27.5027C33.7294 27.8915 34.5316 28.5499 35.0961 29.3947C35.6605 30.2394 35.9618 31.2326 35.9618 32.2486C35.9618 33.611 35.4206 34.9175 34.4572 35.8809C33.4939 36.8442 32.1873 37.3855 30.8249 37.3855Z"
            fill="black"
          />
          <defs>
            <linearGradient
              id="paint0_linear_79_641"
              x1="31.2344"
              y1="0.806945"
              x2="54.6602"
              y2="58.755"
              gradientUnits="userSpaceOnUse"
            >
              <stop stopColor="#F3F2FC" />
              <stop offset="1" stopColor="white" />
            </linearGradient>
          </defs>
        </svg>

        <div className="flex flex-col">
          <div className="text-neutral-400 uppercase text-[32.97px] font-bold font-['Qanelas Soft']">
            {settings.language.settings}
          </div>
          <div className="text-neutral-400 text-lg font-semibold font-['Qanelas Soft']">
            Dusa Hud | www.dusadev.tebex.io
          </div>
        </div>
      </div>
      <div className="flex flex-col gap-y-2">
        <div className="flex items-center gap-x-2">
          <div className="text-center w-11 bg-white py-1 text-black text-[10.72px] font-bold font-['Qanelas Soft']">
            ESC
          </div>
          <div className="text-center text-neutral-400 text-xs font-medium font-['Qanelas Soft']">
            {settings.language.exitSettings}
          </div>
        </div>
        <div className="flex items-center gap-x-2">
          <div className="text-center w-11  bg-white py-1 text-black text-[10.72px] font-bold font-['Qanelas Soft']">
            {settings.language.click}
          </div>
          <div className="text-center text-neutral-400 text-xs font-medium font-['Qanelas Soft']">
            {settings.language.toSaveSettings}
          </div>
        </div>
      </div>
    </div>
  );
};

export default SettingsHeader;
