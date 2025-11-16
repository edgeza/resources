import { useSettings } from "../../../contexts/SettingsContext";
import { useState } from "react";
import { useNuiEvent } from "../../../hooks/useNuiEvent";

const SpeedoMeter10 = ({ gear, speed, fuel }) => {
  const { settings } = useSettings();
  const [seatBelts, setSeatBelts] = useState({
    seat_1: false,
    seat_2: false,
    seat_3: false,
    seat_4: false,
  });

  const speedDeg = () => {
    if (speed < 20) return -115;
    if (speed < 40) return -80;
    if (speed < 60) return -50;
    if (speed < 80) return -40;
    if (speed < 100) return -20;
    if (speed < 120) return 0;
    if (speed < 140) return 30;
    if (speed < 160) return 60;
    if (speed < 180) return 90;
    if (speed < 200) return 120;
  };

  useNuiEvent("setSeatBelts", setSeatBelts);

  return (
    <div
      className="relative w-[656px] h-[276px]"
      style={{
        scale: settings.speedometers.transform ? settings.speedometers.transform.toString() + "%" : '90%',
      }}
    >
      <div className="absolute top-32 z-10 left-56 w-52 py-1 flex items-center justify-center">
        <span className="text-neutral-200 text-xl font-semibold drop-shadow-lg px-2 py-1 rounded-lg z-20">
          {speed}
        </span>
      </div>
      {gear === 2 && (
        <svg
          className="absolute right-[76px] top-[124px] z-10"
          width="80"
          height="24"
          viewBox="0 0 80 24"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <g filter="url(#filter0_d_759_3273)">
            <path
              d="M10.355 10.6389C10.355 10.4512 10.5071 10.2991 10.6948 10.2991H63.2389C63.2602 10.2991 63.2816 10.3011 63.3026 10.3051L69.698 11.5255C70.0663 11.5957 70.0663 12.1229 69.698 12.1931L63.3026 13.4135C63.2816 13.4175 63.2602 13.4195 63.2389 13.4195H10.6948C10.5071 13.4195 10.355 13.2673 10.355 13.0796V10.6389Z"
              fill="url(#paint0_linear_759_3273)"
            />
          </g>
          <rect
            width="3.59368"
            height="6.24088"
            rx="0.849663"
            transform="matrix(-1 0 0 1 11.5566 8.73755)"
            fill="#A96A3B"
          />
          <defs>
            <filter
              id="filter0_d_759_3273"
              x="0.3411"
              y="0.285192"
              width="79.6469"
              height="23.1481"
              filterUnits="userSpaceOnUse"
              colorInterpolationFilters="sRGB"
            >
              <feFlood floodOpacity="0" result="BackgroundImageFix" />
              <feColorMatrix
                in="SourceAlpha"
                type="matrix"
                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                result="hardAlpha"
              />
              <feOffset />
              <feGaussianBlur stdDeviation="5.00694" />
              <feComposite in2="hardAlpha" operator="out" />
              <feColorMatrix
                type="matrix"
                values="0 0 0 0 0.827451 0 0 0 0 0.501961 0 0 0 0 0.258824 0 0 0 0.45 0"
              />
              <feBlend
                mode="normal"
                in2="BackgroundImageFix"
                result="effect1_dropShadow_759_3273"
              />
              <feBlend
                mode="normal"
                in="SourceGraphic"
                in2="effect1_dropShadow_759_3273"
                result="shape"
              />
            </filter>
            <linearGradient
              id="paint0_linear_759_3273"
              x1="13.4609"
              y1="12.3794"
              x2="64.7091"
              y2="13.4099"
              gradientUnits="userSpaceOnUse"
            >
              <stop stopColor="#A96A3B" />
              <stop offset="1" stopColor="#F89347" />
            </linearGradient>
          </defs>
        </svg>
      )}
      {gear === 1 && (
        <svg
          className="absolute right-[98px] top-[124px] z-10"
          width="51"
          height="74"
          viewBox="0 0 51 74"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <g filter="url(#filter0_d_759_3273)">
            <path
              d="M12.9552 11.0139C13.1194 10.9229 13.3262 10.9822 13.4172 11.1464L38.8911 57.1024C38.9014 57.1211 38.91 57.1407 38.9167 57.161L40.9499 63.3463C41.067 63.7024 40.6059 63.958 40.3659 63.67L36.198 58.668C36.1843 58.6516 36.1722 58.6339 36.1619 58.6152L10.688 12.6592C10.597 12.495 10.6563 12.2882 10.8205 12.1972L12.9552 11.0139Z"
              fill="url(#paint0_linear_759_3273)"
            />
          </g>
          <rect
            width="3.59368"
            height="6.24088"
            rx="0.849663"
            transform="matrix(-0.48481 -0.87462 -0.87462 0.48481 15.2007 11.1431)"
            fill="#A96A3B"
          />
          <defs>
            <filter
              id="filter0_d_759_3273"
              x="0.631627"
              y="0.957311"
              width="50.351"
              height="72.851"
              filterUnits="userSpaceOnUse"
              colorInterpolationFilters="sRGB"
            >
              <feFlood floodOpacity="0" result="BackgroundImageFix" />
              <feColorMatrix
                in="SourceAlpha"
                type="matrix"
                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                result="hardAlpha"
              />
              <feOffset />
              <feGaussianBlur stdDeviation="5.00694" />
              <feComposite in2="hardAlpha" operator="out" />
              <feColorMatrix
                type="matrix"
                values="0 0 0 0 0.827451 0 0 0 0 0.501961 0 0 0 0 0.258824 0 0 0 0.45 0"
              />
              <feBlend
                mode="normal"
                in2="BackgroundImageFix"
                result="effect1_dropShadow_759_3273"
              />
              <feBlend
                mode="normal"
                in="SourceGraphic"
                in2="effect1_dropShadow_759_3273"
                result="shape"
              />
            </filter>
            <linearGradient
              id="paint0_linear_759_3273"
              x1="12.9388"
              y1="14.5742"
              x2="36.8831"
              y2="59.8965"
              gradientUnits="userSpaceOnUse"
            >
              <stop stopColor="#A96A3B" />
              <stop offset="1" stopColor="#F89347" />
            </linearGradient>
          </defs>
        </svg>
      )}
      {gear === 0 && (
        <svg
          className="absolute right-[130px] top-[130px] z-10"
          width="44"
          height="77"
          viewBox="0 0 44 77"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <g filter="url(#filter0_d_759_3273)">
            <path
              d="M33.3277 11.2915C33.503 11.3588 33.5905 11.5554 33.5232 11.7306L14.6931 60.7847C14.6855 60.8046 14.6759 60.8238 14.6647 60.842L11.2334 66.3754C11.0359 66.6939 10.5438 66.505 10.6101 66.1361L11.7627 59.7281C11.7665 59.707 11.7723 59.6864 11.78 59.6664L30.61 10.6124C30.6773 10.4371 30.8739 10.3496 31.0491 10.4169L33.3277 11.2915Z"
              fill="url(#paint0_linear_759_3273)"
            />
          </g>
          <rect
            width="3.59368"
            height="6.24088"
            rx="0.849663"
            transform="matrix(0.358368 -0.93358 -0.93358 -0.358368 34.6719 13.095)"
            fill="#A96A3B"
          />
          <defs>
            <filter
              id="filter0_d_759_3273"
              x="0.590123"
              y="0.380406"
              width="42.9697"
              height="76.1708"
              filterUnits="userSpaceOnUse"
              colorInterpolationFilters="sRGB"
            >
              <feFlood floodOpacity="0" result="BackgroundImageFix" />
              <feColorMatrix
                in="SourceAlpha"
                type="matrix"
                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                result="hardAlpha"
              />
              <feOffset />
              <feGaussianBlur stdDeviation="5.00694" />
              <feComposite in2="hardAlpha" operator="out" />
              <feColorMatrix
                type="matrix"
                values="0 0 0 0 0.827451 0 0 0 0 0.501961 0 0 0 0 0.258824 0 0 0 0.45 0"
              />
              <feBlend
                mode="normal"
                in2="BackgroundImageFix"
                result="effect1_dropShadow_759_3273"
              />
              <feBlend
                mode="normal"
                in="SourceGraphic"
                in2="effect1_dropShadow_759_3273"
                result="shape"
              />
            </filter>
            <linearGradient
              id="paint0_linear_759_3273"
              x1="30.5898"
              y1="13.5675"
              x2="11.2621"
              y2="61.0425"
              gradientUnits="userSpaceOnUse"
            >
              <stop stopColor="#A96A3B" />
              <stop offset="1" stopColor="#F89347" />
            </linearGradient>
          </defs>
        </svg>
      )}
      {gear === 3 && (
        <svg
          className="absolute right-[84px] top-24 z-10"
          width="74"
          height="52"
          viewBox="0 0 74 52"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <g filter="url(#filter0_d_759_3273)">
            <path
              d="M10.9819 39.1906C10.8881 39.028 10.9438 38.8202 11.1063 38.7263L56.6108 12.4543C56.6293 12.4436 56.6488 12.4347 56.669 12.4277L62.8178 10.2868C63.1718 10.1635 63.4354 10.6201 63.1516 10.865L58.2232 15.1196C58.207 15.1336 58.1895 15.146 58.171 15.1567L12.6666 41.4287C12.504 41.5225 12.2961 41.4668 12.2023 41.3043L10.9819 39.1906Z"
              fill="url(#paint0_linear_759_3273)"
            />
          </g>
          <rect
            width="3.59368"
            height="6.24088"
            rx="0.849663"
            transform="matrix(-0.866025 0.5 0.5 0.866025 11.0723 36.9431)"
            fill="#A96A3B"
          />
          <defs>
            <filter
              id="filter0_d_759_3273"
              x="0.922643"
              y="0.252233"
              width="72.3627"
              height="51.236"
              filterUnits="userSpaceOnUse"
              colorInterpolationFilters="sRGB"
            >
              <feFlood floodOpacity="0" result="BackgroundImageFix" />
              <feColorMatrix
                in="SourceAlpha"
                type="matrix"
                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                result="hardAlpha"
              />
              <feOffset />
              <feGaussianBlur stdDeviation="5.00694" />
              <feComposite in2="hardAlpha" operator="out" />
              <feColorMatrix
                type="matrix"
                values="0 0 0 0 0.827451 0 0 0 0 0.501961 0 0 0 0 0.258824 0 0 0 0.45 0"
              />
              <feBlend
                mode="normal"
                in2="BackgroundImageFix"
                result="effect1_dropShadow_759_3273"
              />
              <feBlend
                mode="normal"
                in="SourceGraphic"
                in2="effect1_dropShadow_759_3273"
                result="shape"
              />
            </filter>
            <linearGradient
              id="paint0_linear_759_3273"
              x1="14.542"
              y1="39.1449"
              x2="59.4395"
              y2="14.4132"
              gradientUnits="userSpaceOnUse"
            >
              <stop stopColor="#A96A3B" />
              <stop offset="1" stopColor="#F89347" />
            </linearGradient>
          </defs>
        </svg>
      )}
      {gear === 4 && (
        <svg
          className="absolute right-28 top-20 z-10"
          width="42"
          height="77"
          viewBox="0 0 42 77"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <g filter="url(#filter0_d_759_3273)">
            <path
              d="M10.5367 66.0975C10.3592 66.0364 10.2649 65.8429 10.326 65.6655L27.4326 15.9841C27.4396 15.9639 27.4485 15.9444 27.4591 15.9258L30.6951 10.2761C30.8814 9.95084 31.3799 10.1225 31.3264 10.4935L30.3981 16.9378C30.3951 16.959 30.39 16.9798 30.3831 17L13.2764 66.6814C13.2153 66.8589 13.0219 66.9532 12.8444 66.8921L10.5367 66.0975Z"
              fill="url(#paint0_linear_759_3273)"
            />
          </g>
          <rect
            width="3.59368"
            height="6.24088"
            rx="0.849663"
            transform="matrix(-0.325568 0.945519 0.945519 0.325568 9.12988 64.342)"
            fill="#A96A3B"
          />
          <defs>
            <filter
              id="filter0_d_759_3273"
              x="0.293248"
              y="0.0901232"
              width="41.0512"
              height="76.8344"
              filterUnits="userSpaceOnUse"
              colorInterpolationFilters="sRGB"
            >
              <feFlood floodOpacity="0" result="BackgroundImageFix" />
              <feColorMatrix
                in="SourceAlpha"
                type="matrix"
                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                result="hardAlpha"
              />
              <feOffset />
              <feGaussianBlur stdDeviation="5.00694" />
              <feComposite in2="hardAlpha" operator="out" />
              <feColorMatrix
                type="matrix"
                values="0 0 0 0 0.827451 0 0 0 0 0.501961 0 0 0 0 0.258824 0 0 0 0.45 0"
              />
              <feBlend
                mode="normal"
                in2="BackgroundImageFix"
                result="effect1_dropShadow_759_3273"
              />
              <feBlend
                mode="normal"
                in="SourceGraphic"
                in2="effect1_dropShadow_759_3273"
                result="shape"
              />
            </filter>
            <linearGradient
              id="paint0_linear_759_3273"
              x1="13.1935"
              y1="63.7274"
              x2="30.8526"
              y2="15.6067"
              gradientUnits="userSpaceOnUse"
            >
              <stop stopColor="#A96A3B" />
              <stop offset="1" stopColor="#F89347" />
            </linearGradient>
          </defs>
        </svg>
      )}
      {gear >= 5 && (
        <svg
          className="absolute right-32 top-20 z-10"
          width="53"
          height="73"
          viewBox="0 0 53 73"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <g filter="url(#filter0_d_759_3273)">
            <path
              d="M40.3582 62.7102C40.1973 62.8069 39.9885 62.7548 39.8919 62.5939L12.8297 17.5549C12.8187 17.5366 12.8094 17.5173 12.802 17.4972L10.5542 11.3867C10.4248 11.0349 10.8766 10.7634 11.1265 11.0428L15.4664 15.8963C15.4807 15.9122 15.4934 15.9295 15.5044 15.9478L42.5666 60.9868C42.6633 61.1477 42.6112 61.3565 42.4503 61.4532L40.3582 62.7102Z"
              fill="url(#paint0_linear_759_3273)"
            />
          </g>
          <rect
            width="3.59368"
            height="6.24088"
            rx="0.849663"
            transform="matrix(0.515038 0.857167 0.857167 -0.515038 38.1089 62.6597)"
            fill="#A96A3B"
          />
          <defs>
            <filter
              id="filter0_d_759_3273"
              x="0.517369"
              y="0.913365"
              width="52.1117"
              height="71.8593"
              filterUnits="userSpaceOnUse"
              colorInterpolationFilters="sRGB"
            >
              <feFlood floodOpacity="0" result="BackgroundImageFix" />
              <feColorMatrix
                in="SourceAlpha"
                type="matrix"
                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                result="hardAlpha"
              />
              <feOffset />
              <feGaussianBlur stdDeviation="5.00694" />
              <feComposite in2="hardAlpha" operator="out" />
              <feColorMatrix
                type="matrix"
                values="0 0 0 0 0.827451 0 0 0 0 0.501961 0 0 0 0 0.258824 0 0 0 0.45 0"
              />
              <feBlend
                mode="normal"
                in2="BackgroundImageFix"
                result="effect1_dropShadow_759_3273"
              />
              <feBlend
                mode="normal"
                in="SourceGraphic"
                in2="effect1_dropShadow_759_3273"
                result="shape"
              />
            </filter>
            <linearGradient
              id="paint0_linear_759_3273"
              x1="40.2504"
              y1="59.1515"
              x2="14.7389"
              y2="14.6925"
              gradientUnits="userSpaceOnUse"
            >
              <stop stopColor="#A96A3B" />
              <stop offset="1" stopColor="#F89347" />
            </linearGradient>
          </defs>
        </svg>
      )}

      <div className="absolute flex items-center justify-center top-[132px] left-32 z-10">
        <div
          className="relative bg-[#3B8DA9]"
          style={{
            width: 39,
            height: 2.75,
            transform: "rotate(" + speedDeg() + "deg)",
            transformOrigin: "0 0 90 90",
            transition: "transform 0.5s ease",
            boxShadow: "0px 0px 10.013880729675293px rgba(59, 141, 169, 0.45)",
          }}
        >
          <svg
            style={{
              transform: "rotate(-30deg)",
              transformOrigin: "0 0",
            }}
            className="absolute top-[1px] -left-2"
            width="16.5"
            height="11"
            viewBox="0 0 17 11"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M4 4.5L0.5 0.5L5.5 2L15.5 7.5L14 10L4 4.5Z"
              fill="#3B8DA9"
            />
          </svg>
        </div>
      </div>

      <svg
        className="absolute z-10 right-[38px] top-8"
        width="144"
        height="209"
        viewBox="0 0 144 209"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M0.5 208H98L143 103.5L91 14.5L0.5 1.5"
          strokeDasharray={(gear < 3 ? 100 * gear : 90 * gear) + "2000"}
          stroke="#A96F3A"
          strokeWidth="1.7"
        />
      </svg>

      <svg
        className="absolute z-10 left-[31px] top-[33px]"
        width="148"
        height="207"
        viewBox="0 0 148 207"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M147.5 206H46L1 100.5L55.5 12.5L145 1"
          stroke="#3DA3D9"
          strokeWidth="1.69933"
          strokeDasharray={speed * 2.2 + " 500"}
        />
      </svg>

      <svg
        className="absolute"
        width="656"
        height="276"
        viewBox="0 0 656 276"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M401.556 32.0507C400.566 32.6908 399.412 33.0313 398.233 33.0313H258.346C257.167 33.0313 256.013 32.6908 255.023 32.0507L208.517 1.98074C207.527 1.34067 206.373 1.00016 205.194 1.00016L205.063 1.00016L89.7293 13.3135C88.0076 13.4973 86.4444 14.4019 85.4271 15.803L2.70852 129.734C1.31446 131.655 1.15607 134.207 2.3021 136.285L74.0416 266.345C75.1182 268.297 77.1708 269.509 79.3998 269.509H573.623C575.808 269.509 577.828 268.343 578.921 266.451L654.026 136.458C655.274 134.296 655.085 131.593 653.547 129.627L564.384 15.6246C563.372 14.3309 561.883 13.4983 560.251 13.3139L451.277 1V1C450.169 1 449.084 1.32008 448.154 1.92175L401.556 32.0507Z"
          fill="url(#paint0_linear_799_3663)"
        />
        <path
          d="M205.063 1.00016L205.063 0.4054L205.031 0.4054L204.999 0.408761L205.063 1.00016ZM564.384 15.6246L564.852 15.2581L564.384 15.6246ZM560.251 13.3139L560.184 13.9049L560.251 13.3139ZM654.026 136.458L653.511 136.16L654.026 136.458ZM653.547 129.627L653.079 129.993L653.547 129.627ZM578.921 266.451L578.406 266.153L578.921 266.451ZM74.0416 266.345L74.5624 266.058L74.0416 266.345ZM89.7293 13.3135L89.6661 12.7221L89.7293 13.3135ZM85.4271 15.803L84.9458 15.4535L85.4271 15.803ZM208.517 1.98074L208.194 2.48019L208.517 1.98074ZM401.556 32.0507L401.879 32.5502L401.556 32.0507ZM2.70852 129.734L3.18981 130.084L2.70852 129.734ZM448.154 1.92175L448.477 2.42121L448.154 1.92175ZM255.023 32.0507L254.7 32.5502L255.023 32.0507ZM258.346 33.6261H398.233V32.4365H258.346V33.6261ZM208.194 2.48019L254.7 32.5502L255.346 31.5513L208.839 1.48128L208.194 2.48019ZM205.063 1.59493L205.194 1.59493L205.194 0.4054L205.063 0.4054L205.063 1.59493ZM89.7924 13.9049L205.126 1.59157L204.999 0.408761L89.6661 12.7221L89.7924 13.9049ZM3.18981 130.084L85.9084 16.1524L84.9458 15.4535L2.22723 129.385L3.18981 130.084ZM74.5624 266.058L2.82289 135.998L1.7813 136.572L73.5208 266.632L74.5624 266.058ZM573.623 268.914H79.3998V270.104H573.623V268.914ZM653.511 136.16L578.406 266.153L579.436 266.749L654.541 136.755L653.511 136.16ZM563.915 15.991L653.079 129.993L654.016 129.26L564.852 15.2581L563.915 15.991ZM451.21 1.591L560.184 13.9049L560.317 12.7229L451.344 0.408997L451.21 1.591ZM401.879 32.5502L448.477 2.42121L447.831 1.4223L401.233 31.5513L401.879 32.5502ZM564.852 15.2581C563.742 13.8388 562.108 12.9252 560.317 12.7229L560.184 13.9049C561.657 14.0714 563.002 14.8231 563.915 15.991L564.852 15.2581ZM654.541 136.755C655.911 134.384 655.703 131.418 654.016 129.26L653.079 129.993C654.467 131.768 654.638 134.209 653.511 136.16L654.541 136.755ZM573.623 270.104C576.021 270.104 578.236 268.825 579.436 266.749L578.406 266.153C577.419 267.862 575.596 268.914 573.623 268.914V270.104ZM73.5208 266.632C74.702 268.774 76.9542 270.104 79.3998 270.104V268.914C77.3875 268.914 75.5343 267.82 74.5624 266.058L73.5208 266.632ZM89.6661 12.7221C87.7771 12.9237 86.062 13.9162 84.9458 15.4535L85.9084 16.1524C86.8268 14.8875 88.2381 14.0708 89.7924 13.9049L89.6661 12.7221ZM208.839 1.48128C207.753 0.778998 206.487 0.405399 205.194 0.4054L205.194 1.59493C206.258 1.59493 207.3 1.90234 208.194 2.48019L208.839 1.48128ZM398.233 33.6261C399.527 33.6261 400.792 33.2525 401.879 32.5502L401.233 31.5513C400.339 32.1291 399.297 32.4365 398.233 32.4365V33.6261ZM2.22723 129.385C0.697678 131.492 0.523892 134.293 1.7813 136.572L2.82289 135.998C1.78825 134.122 1.93125 131.817 3.18981 130.084L2.22723 129.385ZM451.277 0.405236C450.054 0.405237 448.857 0.758411 447.831 1.4223L448.477 2.42121C449.311 1.88175 450.283 1.59476 451.277 1.59476L451.277 0.405236ZM258.346 32.4365C257.282 32.4365 256.24 32.1291 255.346 31.5513L254.7 32.5502C255.787 33.2525 257.052 33.6261 258.346 33.6261V32.4365Z"
          fill="white"
          fillOpacity="0.13"
        />
        <path
          opacity="0.2"
          d="M412.055 150.546C412.055 200.373 372.601 240.762 323.937 240.762C275.273 240.762 235.819 200.373 235.819 150.546C235.819 100.718 275.273 60.3293 323.937 60.3293C372.601 60.3293 412.055 100.718 412.055 150.546Z"
          fill="url(#paint1_radial_799_3663)"
          fillOpacity="0.2"
          stroke="white"
          strokeWidth="0.202627"
        />
        <path
          opacity="0.2"
          d="M397.346 150.373C397.346 190.848 365.297 223.655 325.769 223.655C286.24 223.655 254.192 190.848 254.192 150.373C254.192 109.899 286.24 77.0915 325.769 77.0915C365.297 77.0915 397.346 109.899 397.346 150.373Z"
          fill="url(#paint2_radial_799_3663)"
          fillOpacity="0.4"
          stroke="white"
          strokeWidth="0.202627"
        />
        <g opacity="0.2">
          <rect
            x="295.221"
            y="60.228"
            width="0.174031"
            height="1.25793"
            fill="white"
          />
          <rect
            width="0.0621197"
            height="0.448976"
            transform="matrix(0.999362 0.0357285 -0.0340897 0.999419 297.298 60.2625)"
            fill="white"
          />
          <rect
            width="0.062127"
            height="0.448924"
            transform="matrix(0.997447 0.0714072 -0.0681435 0.997676 299.373 60.3706)"
            fill="white"
          />
          <rect
            width="0.0621391"
            height="0.448836"
            transform="matrix(0.994261 0.106987 -0.102126 0.994772 301.442 60.5525)"
            fill="white"
          />
          <rect
            width="0.0621559"
            height="0.448714"
            transform="matrix(0.989807 0.142417 -0.136 0.990709 303.503 60.8091)"
            fill="white"
          />
          <rect
            width="0.0621774"
            height="0.448559"
            transform="matrix(0.984094 0.177649 -0.169732 0.98549 305.555 61.1375)"
            fill="white"
          />
          <rect
            width="0.0622034"
            height="0.44837"
            transform="matrix(0.977132 0.212636 -0.203283 0.97912 307.594 61.541)"
            fill="white"
          />
          <rect
            width="0.0622339"
            height="0.44815"
            transform="matrix(0.968932 0.247328 -0.23662 0.971602 309.621 62.0161)"
            fill="white"
          />
          <rect
            width="0.0622688"
            height="0.447899"
            transform="matrix(0.959509 0.281679 -0.269705 0.962943 311.625 62.5635)"
            fill="white"
          />
          <rect
            width="0.0623077"
            height="0.447618"
            transform="matrix(0.948878 0.315642 -0.302502 0.953149 313.615 63.1821)"
            fill="white"
          />
          <rect
            width="0.0623506"
            height="0.447309"
            transform="matrix(0.937058 0.349173 -0.334975 0.942227 315.578 63.8716)"
            fill="white"
          />
          <rect
            width="0.0623973"
            height="0.446974"
            transform="matrix(0.924068 0.382228 -0.367089 0.930186 317.519 64.6306)"
            fill="white"
          />
          <rect
            width="0.0624476"
            height="0.446614"
            transform="matrix(0.90993 0.414763 -0.398805 0.917036 319.43 65.458)"
            fill="white"
          />
          <rect
            width="0.0625011"
            height="0.446231"
            transform="matrix(0.894666 0.446736 -0.430089 0.902787 321.315 66.3545)"
            fill="white"
          />
          <rect
            width="0.0625577"
            height="0.445826"
            transform="matrix(0.878301 0.478108 -0.460903 0.88745 323.168 67.3171)"
            fill="white"
          />
          <rect
            width="0.062617"
            height="0.445403"
            transform="matrix(0.860861 0.50884 -0.491212 0.87104 324.984 68.3445)"
            fill="white"
          />
          <rect
            width="0.0626789"
            height="0.444963"
            transform="matrix(0.842374 0.538893 -0.520978 0.85357 326.768 69.437)"
            fill="white"
          />
          <rect
            width="0.062743"
            height="0.444508"
            transform="matrix(0.822868 0.568233 -0.550166 0.835055 328.51 70.5933)"
            fill="white"
          />
          <rect
            width="0.062809"
            height="0.44404"
            transform="matrix(0.802373 0.596823 -0.578739 0.815512 330.213 71.8105)"
            fill="white"
          />
          <rect
            width="0.0628766"
            height="0.443563"
            transform="matrix(0.780919 0.624632 -0.606662 0.79496 331.874 73.0876)"
            fill="white"
          />
          <rect
            width="0.0629454"
            height="0.443078"
            transform="matrix(0.758539 0.651628 -0.633897 0.773417 333.49 74.4233)"
            fill="white"
          />
          <rect
            width="0.0630152"
            height="0.442587"
            transform="matrix(0.735264 0.677781 -0.66041 0.750905 335.061 75.8154)"
            fill="white"
          />
          <rect
            width="0.0630855"
            height="0.442093"
            transform="matrix(0.711128 0.703062 -0.686166 0.727445 336.582 77.2637)"
            fill="white"
          />
          <rect
            width="0.0631562"
            height="0.441599"
            transform="matrix(0.686166 0.727445 -0.711128 0.703062 338.055 78.7644)"
            fill="white"
          />
          <rect
            width="0.0634791"
            height="0.443264"
            transform="matrix(0.66041 0.750905 -0.735264 0.677781 339.471 80.3174)"
            fill="white"
          />
          <rect
            width="0.0635305"
            height="0.442902"
            transform="matrix(0.633897 0.773417 -0.758539 0.651628 340.836 81.9199)"
            fill="white"
          />
          <rect
            width="0.0635813"
            height="0.442545"
            transform="matrix(0.606662 0.79496 -0.780919 0.624632 342.144 83.5703)"
            fill="white"
          />
          <rect
            width="0.0636311"
            height="0.442194"
            transform="matrix(0.578739 0.815512 -0.802373 0.596823 343.398 85.2666)"
            fill="white"
          />
          <rect
            width="0.0636798"
            height="0.441851"
            transform="matrix(0.550166 0.835055 -0.822868 0.568233 344.591 87.0066)"
            fill="white"
          />
          <rect
            width="0.0637271"
            height="0.441517"
            transform="matrix(0.520978 0.85357 -0.842374 0.538893 345.725 88.7896)"
            fill="white"
          />
          <rect
            width="0.0637727"
            height="0.441194"
            transform="matrix(0.491212 0.87104 -0.860861 0.50884 346.797 90.6108)"
            fill="white"
          />
          <rect
            width="0.0638165"
            height="0.440883"
            transform="matrix(0.460903 0.88745 -0.878301 0.478108 347.807 92.4683)"
            fill="white"
          />
          <rect
            width="0.0638583"
            height="0.440587"
            transform="matrix(0.430089 0.902786 -0.894666 0.446736 348.754 94.3618)"
            fill="white"
          />
          <rect
            width="0.0638979"
            height="0.440306"
            transform="matrix(0.398805 0.917036 -0.90993 0.414762 349.633 96.2881)"
            fill="white"
          />
          <rect
            width="0.063935"
            height="0.440041"
            transform="matrix(0.367088 0.930186 -0.924068 0.382228 350.447 98.2437)"
            fill="white"
          />
          <rect
            width="0.0639695"
            height="0.439796"
            transform="matrix(0.334975 0.942227 -0.937058 0.349173 351.195 100.228)"
            fill="white"
          />
          <rect
            width="0.0640012"
            height="0.43957"
            transform="matrix(0.302502 0.953149 -0.948878 0.315642 351.875 102.238)"
            fill="white"
          />
          <rect
            width="0.06403"
            height="0.439364"
            transform="matrix(0.269705 0.962943 -0.959509 0.281679 352.485 104.27)"
            fill="white"
          />
          <rect
            width="0.0640557"
            height="0.43918"
            transform="matrix(0.23662 0.971602 -0.968932 0.247328 353.026 106.323)"
            fill="white"
          />
          <rect
            width="0.0640783"
            height="0.439019"
            transform="matrix(0.203283 0.97912 -0.977132 0.212636 353.496 108.393)"
            fill="white"
          />
          <rect
            width="0.0640976"
            height="0.438881"
            transform="matrix(0.169732 0.98549 -0.984094 0.177649 353.893 110.481)"
            fill="white"
          />
          <rect
            width="0.0641134"
            height="0.438767"
            transform="matrix(0.136 0.990709 -0.989807 0.142417 354.223 112.581)"
            fill="white"
          />
          <rect
            width="0.0641259"
            height="0.438678"
            transform="matrix(0.102126 0.994772 -0.994261 0.106987 354.479 114.69)"
            fill="white"
          />
          <rect
            width="0.0641348"
            height="0.438614"
            transform="matrix(0.0681435 0.997676 -0.997447 0.0714072 354.663 116.809)"
            fill="white"
          />
          <rect
            width="0.0641402"
            height="0.438576"
            transform="matrix(0.0340897 0.999419 -0.999362 0.0357285 354.774 118.931)"
            fill="white"
          />
          <rect
            x="354.814"
            y="121.058"
            width="0.064142"
            height="0.438563"
            transform="rotate(90 354.814 121.058)"
            fill="white"
          />
          <rect
            width="0.0641402"
            height="0.438576"
            transform="matrix(-0.0340897 0.999419 -0.999362 -0.0357285 354.78 123.184)"
            fill="white"
          />
          <rect
            width="0.0641348"
            height="0.438614"
            transform="matrix(-0.0681435 0.997676 -0.997447 -0.0714072 354.673 125.308)"
            fill="white"
          />
          <rect
            width="0.0641259"
            height="0.438678"
            transform="matrix(-0.102126 0.994772 -0.994261 -0.106987 354.496 127.426)"
            fill="white"
          />
          <rect
            width="0.0641134"
            height="0.438767"
            transform="matrix(-0.136 0.990709 -0.989807 -0.142417 354.25 129.537)"
            fill="white"
          />
          <rect
            width="0.0640976"
            height="0.438881"
            transform="matrix(-0.169732 0.98549 -0.984094 -0.177649 353.925 131.637)"
            fill="white"
          />
          <rect
            width="0.0640783"
            height="0.439019"
            transform="matrix(-0.203283 0.97912 -0.977132 -0.212636 353.531 133.726)"
            fill="white"
          />
          <rect
            width="0.0640557"
            height="0.43918"
            transform="matrix(-0.23662 0.971602 -0.968932 -0.247328 353.069 135.799)"
            fill="white"
          />
          <rect
            width="0.06403"
            height="0.439364"
            transform="matrix(-0.269705 0.962943 -0.959509 -0.281679 352.532 137.853)"
            fill="white"
          />
          <rect
            width="0.0640012"
            height="0.43957"
            transform="matrix(-0.302502 0.953149 -0.948878 -0.315642 351.926 139.887)"
            fill="white"
          />
          <rect
            width="0.0639695"
            height="0.439796"
            transform="matrix(-0.334975 0.942227 -0.937058 -0.349173 351.255 141.899)"
            fill="white"
          />
          <rect
            width="0.063935"
            height="0.440042"
            transform="matrix(-0.367089 0.930186 -0.924068 -0.382228 350.512 143.886)"
            fill="white"
          />
          <rect
            width="0.0638978"
            height="0.440305"
            transform="matrix(-0.398805 0.917036 -0.90993 -0.414763 349.706 145.844)"
            fill="white"
          />
          <rect
            width="0.0638583"
            height="0.440586"
            transform="matrix(-0.430089 0.902787 -0.894666 -0.446736 348.83 147.772)"
            fill="white"
          />
          <rect
            width="0.0638165"
            height="0.440883"
            transform="matrix(-0.460903 0.88745 -0.878301 -0.478108 347.891 149.669)"
            fill="white"
          />
          <rect
            width="0.0637727"
            height="0.441194"
            transform="matrix(-0.491212 0.87104 -0.860861 -0.50884 346.885 151.53)"
            fill="white"
          />
          <rect
            width="0.063727"
            height="0.441517"
            transform="matrix(-0.520978 0.85357 -0.842374 -0.538893 345.818 153.354)"
            fill="white"
          />
          <rect
            width="0.0636798"
            height="0.441851"
            transform="matrix(-0.550166 0.835055 -0.822868 -0.568233 344.69 155.139)"
            fill="white"
          />
          <rect
            width="0.0636311"
            height="0.442194"
            transform="matrix(-0.578739 0.815512 -0.802373 -0.596823 343.502 156.883)"
            fill="white"
          />
          <rect
            width="0.0635813"
            height="0.442545"
            transform="matrix(-0.606662 0.79496 -0.780919 -0.624632 342.252 158.582)"
            fill="white"
          />
          <rect
            width="0.0635305"
            height="0.442902"
            transform="matrix(-0.633897 0.773417 -0.758539 -0.651628 340.951 160.237)"
            fill="white"
          />
          <rect
            width="0.0634791"
            height="0.443263"
            transform="matrix(-0.66041 0.750905 -0.735264 -0.677781 339.588 161.844)"
            fill="white"
          />
          <rect
            width="0.0631562"
            height="0.441599"
            transform="matrix(-0.686166 0.727445 -0.711128 -0.703062 338.173 163.401)"
            fill="white"
          />
          <rect
            width="0.0630855"
            height="0.442093"
            transform="matrix(-0.711128 0.703062 -0.686166 -0.727445 336.708 164.908)"
            fill="white"
          />
          <rect
            width="0.0630152"
            height="0.442587"
            transform="matrix(-0.735264 0.677781 -0.66041 -0.750905 335.193 166.36)"
            fill="white"
          />
          <rect
            width="0.0629454"
            height="0.443078"
            transform="matrix(-0.758539 0.651628 -0.633897 -0.773417 333.624 167.757)"
            fill="white"
          />
          <rect
            width="0.0628766"
            height="0.443563"
            transform="matrix(-0.780919 0.624632 -0.606662 -0.79496 332.013 169.098)"
            fill="white"
          />
          <rect
            width="0.062809"
            height="0.444041"
            transform="matrix(-0.802373 0.596823 -0.578739 -0.815512 330.355 170.38)"
            fill="white"
          />
          <rect
            width="0.062743"
            height="0.444508"
            transform="matrix(-0.822868 0.568233 -0.550166 -0.835055 328.658 171.602)"
            fill="white"
          />
          <rect
            width="0.0626789"
            height="0.444963"
            transform="matrix(-0.842374 0.538893 -0.520978 -0.85357 326.914 172.763)"
            fill="white"
          />
          <rect
            width="0.062617"
            height="0.445403"
            transform="matrix(-0.860861 0.50884 -0.491212 -0.87104 325.138 173.862)"
            fill="white"
          />
          <rect
            width="0.0625577"
            height="0.445826"
            transform="matrix(-0.878301 0.478108 -0.460903 -0.88745 323.322 174.895)"
            fill="white"
          />
          <rect
            width="0.0625011"
            height="0.446231"
            transform="matrix(-0.894666 0.446736 -0.430089 -0.902786 321.475 175.862)"
            fill="white"
          />
          <rect
            width="0.0624476"
            height="0.446614"
            transform="matrix(-0.90993 0.414762 -0.398805 -0.917036 319.592 176.764)"
            fill="white"
          />
          <rect
            width="0.0623973"
            height="0.446974"
            transform="matrix(-0.924068 0.382228 -0.367088 -0.930186 317.681 177.597)"
            fill="white"
          />
          <rect
            width="0.0623506"
            height="0.447309"
            transform="matrix(-0.937058 0.349173 -0.334975 -0.942227 315.742 178.362)"
            fill="white"
          />
          <rect
            width="0.0623077"
            height="0.447618"
            transform="matrix(-0.948878 0.315642 -0.302502 -0.953149 313.779 179.057)"
            fill="white"
          />
          <rect
            width="0.0622688"
            height="0.447899"
            transform="matrix(-0.959509 0.281679 -0.269705 -0.962943 311.795 179.683)"
            fill="white"
          />
          <rect
            width="0.0622339"
            height="0.44815"
            transform="matrix(-0.968932 0.247328 -0.23662 -0.971602 309.791 180.236)"
            fill="white"
          />
          <rect
            width="0.0622034"
            height="0.44837"
            transform="matrix(-0.977132 0.212636 -0.203283 -0.97912 307.768 180.717)"
            fill="white"
          />
          <rect
            width="0.0621774"
            height="0.448559"
            transform="matrix(-0.984094 0.177649 -0.169732 -0.98549 305.73 181.126)"
            fill="white"
          />
          <rect
            width="0.0621559"
            height="0.448714"
            transform="matrix(-0.989807 0.142417 -0.136 -0.990709 303.677 181.462)"
            fill="white"
          />
          <rect
            width="0.0621391"
            height="0.448836"
            transform="matrix(-0.994261 0.106987 -0.102126 -0.994772 301.617 181.724)"
            fill="white"
          />
          <rect
            width="0.062127"
            height="0.448924"
            transform="matrix(-0.997447 0.0714072 -0.0681435 -0.997676 299.549 181.913)"
            fill="white"
          />
          <rect
            width="0.0621197"
            height="0.448976"
            transform="matrix(-0.999362 0.0357285 -0.0340897 -0.999419 297.472 182.026)"
            fill="white"
          />
          <rect
            x="295.396"
            y="182.067"
            width="0.0621173"
            height="0.448994"
            transform="rotate(-180 295.396 182.067)"
            fill="white"
          />
          <rect
            width="0.0621197"
            height="0.448976"
            transform="matrix(-0.999362 -0.0357285 0.0340897 -0.999419 293.323 182.034)"
            fill="white"
          />
          <rect
            width="0.062127"
            height="0.448924"
            transform="matrix(-0.997447 -0.0714072 0.0681435 -0.997676 291.246 181.925)"
            fill="white"
          />
          <rect
            width="0.0621391"
            height="0.448836"
            transform="matrix(-0.994261 -0.106987 0.102126 -0.994772 289.175 181.742)"
            fill="white"
          />
          <rect
            width="0.0621559"
            height="0.448714"
            transform="matrix(-0.989807 -0.142417 0.136 -0.990709 287.114 181.487)"
            fill="white"
          />
          <rect
            width="0.0621774"
            height="0.448559"
            transform="matrix(-0.984094 -0.177649 0.169732 -0.98549 285.062 181.157)"
            fill="white"
          />
          <rect
            width="0.0622034"
            height="0.44837"
            transform="matrix(-0.977132 -0.212636 0.203283 -0.97912 283.024 180.754)"
            fill="white"
          />
          <rect
            width="0.0622339"
            height="0.44815"
            transform="matrix(-0.968932 -0.247328 0.23662 -0.971602 281 180.28)"
            fill="white"
          />
          <rect
            width="0.0622688"
            height="0.447899"
            transform="matrix(-0.959509 -0.281679 0.269705 -0.962943 278.993 179.731)"
            fill="white"
          />
          <rect
            width="0.0623077"
            height="0.447618"
            transform="matrix(-0.948878 -0.315642 0.302502 -0.953149 277.006 179.113)"
            fill="white"
          />
          <rect
            width="0.0623506"
            height="0.447309"
            transform="matrix(-0.937058 -0.349173 0.334975 -0.942227 275.042 178.424)"
            fill="white"
          />
          <rect
            width="0.0623974"
            height="0.446974"
            transform="matrix(-0.924068 -0.382228 0.367089 -0.930186 273.102 177.665)"
            fill="white"
          />
          <rect
            width="0.0624476"
            height="0.446614"
            transform="matrix(-0.90993 -0.414763 0.398805 -0.917036 271.188 176.837)"
            fill="white"
          />
          <rect
            width="0.0625011"
            height="0.446231"
            transform="matrix(-0.894666 -0.446736 0.430089 -0.902787 269.304 175.94)"
            fill="white"
          />
          <rect
            width="0.0625577"
            height="0.445826"
            transform="matrix(-0.878301 -0.478108 0.460903 -0.88745 267.451 174.978)"
            fill="white"
          />
          <rect
            width="0.062617"
            height="0.445403"
            transform="matrix(-0.860861 -0.50884 0.491212 -0.87104 265.636 173.951)"
            fill="white"
          />
          <rect
            width="0.0626789"
            height="0.444963"
            transform="matrix(-0.842374 -0.538893 0.520978 -0.85357 263.851 172.858)"
            fill="white"
          />
          <rect
            width="0.062743"
            height="0.444508"
            transform="matrix(-0.822868 -0.568233 0.550166 -0.835055 262.109 171.703)"
            fill="white"
          />
          <rect
            width="0.062809"
            height="0.44404"
            transform="matrix(-0.802373 -0.596823 0.578739 -0.815512 260.406 170.485)"
            fill="white"
          />
          <rect
            width="0.0628766"
            height="0.443563"
            transform="matrix(-0.780919 -0.624632 0.606662 -0.79496 258.745 169.208)"
            fill="white"
          />
          <rect
            width="0.0629454"
            height="0.443078"
            transform="matrix(-0.758539 -0.651628 0.633897 -0.773417 257.127 167.873)"
            fill="white"
          />
          <rect
            width="0.0630152"
            height="0.442587"
            transform="matrix(-0.735264 -0.677781 0.66041 -0.750905 255.557 166.48)"
            fill="white"
          />
          <rect
            width="0.0630855"
            height="0.442093"
            transform="matrix(-0.711128 -0.703062 0.686166 -0.727445 254.038 165.032)"
            fill="white"
          />
          <rect
            width="0.0631562"
            height="0.441599"
            transform="matrix(-0.686166 -0.727445 0.711128 -0.703062 252.566 163.53)"
            fill="white"
          />
          <rect
            width="0.0634791"
            height="0.443264"
            transform="matrix(-0.66041 -0.750905 0.735264 -0.677781 251.146 161.978)"
            fill="white"
          />
          <rect
            width="0.0635305"
            height="0.442902"
            transform="matrix(-0.633897 -0.773417 0.758539 -0.651628 249.783 160.375)"
            fill="white"
          />
          <rect
            width="0.0635813"
            height="0.442545"
            transform="matrix(-0.606662 -0.79496 0.780919 -0.624632 248.473 158.724)"
            fill="white"
          />
          <rect
            width="0.0636311"
            height="0.442194"
            transform="matrix(-0.578739 -0.815512 0.802373 -0.596823 247.223 157.027)"
            fill="white"
          />
          <rect
            width="0.0636798"
            height="0.441851"
            transform="matrix(-0.550166 -0.835055 0.822868 -0.568233 246.027 155.289)"
            fill="white"
          />
          <rect
            width="0.0637271"
            height="0.441517"
            transform="matrix(-0.520978 -0.85357 0.842374 -0.538893 244.895 153.506)"
            fill="white"
          />
          <rect
            width="0.0637727"
            height="0.441194"
            transform="matrix(-0.491212 -0.87104 0.860861 -0.50884 243.822 151.685)"
            fill="white"
          />
          <rect
            width="0.0638165"
            height="0.440883"
            transform="matrix(-0.460903 -0.88745 0.878301 -0.478108 242.812 149.827)"
            fill="white"
          />
          <rect
            width="0.0638583"
            height="0.440587"
            transform="matrix(-0.430089 -0.902786 0.894666 -0.446736 241.863 147.934)"
            fill="white"
          />
          <rect
            width="0.0638979"
            height="0.440306"
            transform="matrix(-0.398805 -0.917036 0.90993 -0.414762 240.985 146.008)"
            fill="white"
          />
          <rect
            width="0.063935"
            height="0.440041"
            transform="matrix(-0.367088 -0.930186 0.924068 -0.382228 240.17 144.052)"
            fill="white"
          />
          <rect
            width="0.0639695"
            height="0.439796"
            transform="matrix(-0.334975 -0.942227 0.937058 -0.349173 239.424 142.067)"
            fill="white"
          />
          <rect
            width="0.0640012"
            height="0.43957"
            transform="matrix(-0.302502 -0.953149 0.948878 -0.315642 238.746 140.058)"
            fill="white"
          />
          <rect
            width="0.06403"
            height="0.439364"
            transform="matrix(-0.269705 -0.962943 0.959509 -0.281679 238.136 138.025)"
            fill="white"
          />
          <rect
            width="0.0640557"
            height="0.43918"
            transform="matrix(-0.23662 -0.971602 0.968932 -0.247328 237.595 135.973)"
            fill="white"
          />
          <rect
            width="0.0640783"
            height="0.439019"
            transform="matrix(-0.203283 -0.97912 0.977132 -0.212636 237.122 133.902)"
            fill="white"
          />
          <rect
            width="0.0640976"
            height="0.438881"
            transform="matrix(-0.169732 -0.98549 0.984094 -0.177649 236.725 131.814)"
            fill="white"
          />
          <rect
            width="0.0641134"
            height="0.438767"
            transform="matrix(-0.136 -0.990709 0.989807 -0.142417 236.395 129.715)"
            fill="white"
          />
          <rect
            width="0.0641259"
            height="0.438678"
            transform="matrix(-0.102126 -0.994772 0.994261 -0.106987 236.141 127.604)"
            fill="white"
          />
          <rect
            width="0.0641348"
            height="0.438614"
            transform="matrix(-0.0681435 -0.997676 0.997447 -0.0714072 235.956 125.487)"
            fill="white"
          />
          <rect
            width="0.0641402"
            height="0.438576"
            transform="matrix(-0.0340897 -0.999419 0.999362 -0.0357285 235.844 123.364)"
            fill="white"
          />
          <rect
            x="235.805"
            y="121.238"
            width="0.064142"
            height="0.438563"
            transform="rotate(-90 235.805 121.238)"
            fill="white"
          />
          <rect
            width="0.0641402"
            height="0.438576"
            transform="matrix(0.0340897 -0.999419 0.999362 0.0357285 235.837 119.111)"
            fill="white"
          />
          <rect
            width="0.0641348"
            height="0.438614"
            transform="matrix(0.0681435 -0.997676 0.997447 0.0714072 235.943 116.987)"
            fill="white"
          />
          <rect
            width="0.0641259"
            height="0.438678"
            transform="matrix(0.102126 -0.994772 0.994261 0.106987 236.124 114.869)"
            fill="white"
          />
          <rect
            width="0.0641134"
            height="0.438767"
            transform="matrix(0.136 -0.990709 0.989807 0.142417 236.372 112.759)"
            fill="white"
          />
          <rect
            width="0.0640976"
            height="0.438881"
            transform="matrix(0.169732 -0.98549 0.984094 0.177649 236.695 110.658)"
            fill="white"
          />
          <rect
            width="0.0640783"
            height="0.439019"
            transform="matrix(0.203283 -0.97912 0.977132 0.212636 237.086 108.569)"
            fill="white"
          />
          <rect
            width="0.0640557"
            height="0.43918"
            transform="matrix(0.23662 -0.971602 0.968932 0.247328 237.552 106.497)"
            fill="white"
          />
          <rect
            width="0.06403"
            height="0.439364"
            transform="matrix(0.269705 -0.962943 0.959509 0.281679 238.085 104.443)"
            fill="white"
          />
          <rect
            width="0.0640012"
            height="0.43957"
            transform="matrix(0.302502 -0.953149 0.948878 0.315642 238.691 102.408)"
            fill="white"
          />
          <rect
            width="0.0639695"
            height="0.439796"
            transform="matrix(0.334975 -0.942227 0.937058 0.349173 239.363 100.397)"
            fill="white"
          />
          <rect
            width="0.063935"
            height="0.440041"
            transform="matrix(0.367089 -0.930186 0.924068 0.382228 240.105 98.4109)"
            fill="white"
          />
          <rect
            width="0.0638978"
            height="0.440306"
            transform="matrix(0.398805 -0.917036 0.90993 0.414763 240.914 96.4519)"
            fill="white"
          />
          <rect
            width="0.0638583"
            height="0.440586"
            transform="matrix(0.430089 -0.902787 0.894666 0.446736 241.789 94.5222)"
            fill="white"
          />
          <rect
            width="0.0638165"
            height="0.440883"
            transform="matrix(0.460903 -0.88745 0.878301 0.478108 242.728 92.6277)"
            fill="white"
          />
          <rect
            width="0.0637727"
            height="0.441194"
            transform="matrix(0.491212 -0.87104 0.860861 0.50884 243.733 90.7656)"
            fill="white"
          />
          <rect
            width="0.063727"
            height="0.441517"
            transform="matrix(0.520978 -0.85357 0.842374 0.538893 244.801 88.9409)"
            fill="white"
          />
          <rect
            width="0.0636798"
            height="0.441851"
            transform="matrix(0.550166 -0.835055 0.822868 0.568233 245.928 87.1562)"
            fill="white"
          />
          <rect
            width="0.0636311"
            height="0.442194"
            transform="matrix(0.578739 -0.815512 0.802373 0.596823 247.117 85.4126)"
            fill="white"
          />
          <rect
            width="0.0635813"
            height="0.442545"
            transform="matrix(0.606662 -0.79496 0.780919 0.624632 248.365 83.7119)"
            fill="white"
          />
          <rect
            width="0.0635305"
            height="0.442902"
            transform="matrix(0.633897 -0.773417 0.758539 0.651628 249.668 82.0583)"
            fill="white"
          />
          <rect
            width="0.0634791"
            height="0.443263"
            transform="matrix(0.66041 -0.750905 0.735264 0.677781 251.031 80.4502)"
            fill="white"
          />
          <rect
            width="0.0631562"
            height="0.441599"
            transform="matrix(0.686166 -0.727445 0.711128 0.703062 252.445 78.8936)"
            fill="white"
          />
          <rect
            width="0.0630855"
            height="0.442093"
            transform="matrix(0.711128 -0.703062 0.686166 0.727445 253.912 77.3884)"
            fill="white"
          />
          <rect
            width="0.0630152"
            height="0.442587"
            transform="matrix(0.735264 -0.677781 0.66041 0.750905 255.426 75.9355)"
            fill="white"
          />
          <rect
            width="0.0629454"
            height="0.443078"
            transform="matrix(0.758539 -0.651628 0.633897 0.773417 256.995 74.5396)"
            fill="white"
          />
          <rect
            width="0.0628766"
            height="0.443563"
            transform="matrix(0.780919 -0.624632 0.606662 0.79496 258.607 73.197)"
            fill="white"
          />
          <rect
            width="0.062809"
            height="0.444041"
            transform="matrix(0.802373 -0.596823 0.578739 0.815512 260.26 71.9158)"
            fill="white"
          />
          <rect
            width="0.062743"
            height="0.444508"
            transform="matrix(0.822868 -0.568233 0.550166 0.835055 261.961 70.6931)"
            fill="white"
          />
          <rect
            width="0.0626789"
            height="0.444963"
            transform="matrix(0.842374 -0.538893 0.520978 0.85357 263.702 69.533)"
            fill="white"
          />
          <rect
            width="0.062617"
            height="0.445403"
            transform="matrix(0.860861 -0.50884 0.491212 0.87104 265.48 68.4341)"
            fill="white"
          />
          <rect
            width="0.0625577"
            height="0.445826"
            transform="matrix(0.878301 -0.478108 0.460903 0.88745 267.295 67.4019)"
            fill="white"
          />
          <rect
            width="0.0625011"
            height="0.446231"
            transform="matrix(0.894666 -0.446736 0.430089 0.902786 269.145 66.4331)"
            fill="white"
          />
          <rect
            width="0.0624476"
            height="0.446614"
            transform="matrix(0.90993 -0.414763 0.398805 0.917036 271.026 65.531)"
            fill="white"
          />
          <rect
            width="0.0623974"
            height="0.446974"
            transform="matrix(0.924068 -0.382228 0.367088 0.930186 272.937 64.6982)"
            fill="white"
          />
          <rect
            width="0.0623506"
            height="0.447309"
            transform="matrix(0.937058 -0.349173 0.334975 0.942227 274.875 63.9324)"
            fill="white"
          />
          <rect
            width="0.0623077"
            height="0.447618"
            transform="matrix(0.948878 -0.315642 0.302502 0.953149 276.839 63.238)"
            fill="white"
          />
          <rect
            width="0.0622688"
            height="0.447899"
            transform="matrix(0.959509 -0.281679 0.269705 0.962943 278.822 62.6128)"
            fill="white"
          />
          <rect
            width="0.0622339"
            height="0.44815"
            transform="matrix(0.968932 -0.247328 0.23662 0.971602 280.831 62.0596)"
            fill="white"
          />
          <rect
            width="0.0622034"
            height="0.44837"
            transform="matrix(0.977132 -0.212636 0.203283 0.97912 282.851 61.5781)"
            fill="white"
          />
          <rect
            width="0.0621774"
            height="0.448559"
            transform="matrix(0.984094 -0.177649 0.169732 0.98549 284.89 61.1685)"
            fill="white"
          />
          <rect
            width="0.0621559"
            height="0.448714"
            transform="matrix(0.989807 -0.142417 0.136 0.990709 286.943 60.833)"
            fill="white"
          />
          <rect
            width="0.0621391"
            height="0.448836"
            transform="matrix(0.994261 -0.106987 0.102126 0.994772 289.004 60.5713)"
            fill="white"
          />
          <rect
            width="0.062127"
            height="0.448924"
            transform="matrix(0.997447 -0.0714072 0.0681435 0.997676 291.072 60.3828)"
            fill="white"
          />
          <rect
            width="0.0621197"
            height="0.448976"
            transform="matrix(0.999362 -0.0357285 0.0340897 0.999419 293.145 60.2683)"
            fill="white"
          />
        </g>
        <path
          opacity="0.2"
          d="M393.097 149.894C393.097 186.149 363.711 215.539 327.462 215.539C291.214 215.539 261.828 186.149 261.828 149.894C261.828 113.64 291.214 84.2496 327.462 84.2496C363.711 84.2496 393.097 113.64 393.097 149.894Z"
          fill="url(#paint3_radial_799_3663)"
          fillOpacity="0.4"
          stroke="white"
          strokeWidth="0.273621"
        />
        <g opacity="0.2">
          <rect
            x="327.459"
            y="49.8953"
            width="0.294937"
            height="2.06489"
            fill="white"
          />
          <rect
            width="0.105525"
            height="0.737027"
            transform="matrix(0.999391 0.0349051 -0.0348939 0.999391 330.951 49.9509)"
            fill="white"
          />
          <rect
            width="0.105524"
            height="0.737032"
            transform="matrix(0.997563 0.0697675 -0.0697454 0.997565 334.435 50.1296)"
            fill="white"
          />
          <rect
            width="0.105523"
            height="0.73704"
            transform="matrix(0.99452 0.104545 -0.104512 0.994524 337.914 50.4268)"
            fill="white"
          />
          <rect
            width="0.10552"
            height="0.737051"
            transform="matrix(0.990265 0.139195 -0.139151 0.990271 341.376 50.8477)"
            fill="white"
          />
          <rect
            width="0.105517"
            height="0.737066"
            transform="matrix(0.984803 0.173675 -0.173621 0.984812 344.824 51.3877)"
            fill="white"
          />
          <rect
            width="0.105514"
            height="0.737084"
            transform="matrix(0.978141 0.207943 -0.20788 0.978154 348.25 52.0522)"
            fill="white"
          />
          <rect
            width="0.10551"
            height="0.737106"
            transform="matrix(0.970287 0.241958 -0.241886 0.970305 351.654 52.8301)"
            fill="white"
          />
          <rect
            width="0.105505"
            height="0.73713"
            transform="matrix(0.96125 0.275678 -0.275597 0.961273 355.024 53.729)"
            fill="white"
          />
          <rect
            width="0.1055"
            height="0.737158"
            transform="matrix(0.951042 0.309062 -0.308972 0.951071 358.364 54.7451)"
            fill="white"
          />
          <rect
            width="0.105494"
            height="0.737188"
            transform="matrix(0.939675 0.342068 -0.341972 0.93971 361.665 55.877)"
            fill="white"
          />
          <rect
            width="0.105488"
            height="0.737222"
            transform="matrix(0.927163 0.374658 -0.374555 0.927205 364.926 57.1221)"
            fill="white"
          />
          <rect
            width="0.105481"
            height="0.737259"
            transform="matrix(0.913521 0.406791 -0.406683 0.91357 368.14 58.4822)"
            fill="white"
          />
          <rect
            width="0.105474"
            height="0.737298"
            transform="matrix(0.898766 0.438428 -0.438315 0.898822 371.309 59.9529)"
            fill="white"
          />
          <rect
            width="0.105467"
            height="0.73734"
            transform="matrix(0.882917 0.46953 -0.469413 0.882979 374.415 61.532)"
            fill="white"
          />
          <rect
            width="0.10546"
            height="0.737385"
            transform="matrix(0.865991 0.50006 -0.49994 0.86606 377.471 63.2185)"
            fill="white"
          />
          <rect
            width="0.10461"
            height="0.735069"
            transform="matrix(0.84801 0.52998 -0.529858 0.848086 380.465 65.0132)"
            fill="white"
          />
          <rect
            width="0.105278"
            height="0.736988"
            transform="matrix(0.828996 0.559254 -0.559132 0.829079 383.394 66.9109)"
            fill="white"
          />
          <rect
            width="0.105278"
            height="0.736984"
            transform="matrix(0.808972 0.587847 -0.587724 0.809062 386.257 68.9072)"
            fill="white"
          />
          <rect
            width="0.105279"
            height="0.73698"
            transform="matrix(0.787963 0.615723 -0.615601 0.788058 389.045 71.0039)"
            fill="white"
          />
          <rect
            width="0.105279"
            height="0.736977"
            transform="matrix(0.765994 0.642848 -0.642727 0.766095 391.763 73.1958)"
            fill="white"
          />
          <rect
            width="0.10528"
            height="0.736972"
            transform="matrix(0.743092 0.66919 -0.669072 0.743198 394.401 75.4819)"
            fill="white"
          />
          <rect
            width="0.105281"
            height="0.736968"
            transform="matrix(0.719284 0.694716 -0.694601 0.719395 396.958 77.8604)"
            fill="white"
          />
          <rect
            width="0.105281"
            height="0.736964"
            transform="matrix(0.694601 0.719395 -0.719284 0.694716 399.429 80.3223)"
            fill="white"
          />
          <rect
            width="0.105282"
            height="0.73696"
            transform="matrix(0.669072 0.743198 -0.743092 0.66919 401.812 82.8728)"
            fill="white"
          />
          <rect
            width="0.105282"
            height="0.736956"
            transform="matrix(0.642727 0.766095 -0.765994 0.642848 404.105 85.5027)"
            fill="white"
          />
          <rect
            width="0.105283"
            height="0.736952"
            transform="matrix(0.615601 0.788058 -0.787963 0.615723 406.306 88.2117)"
            fill="white"
          />
          <rect
            width="0.105283"
            height="0.736948"
            transform="matrix(0.587724 0.809062 -0.808972 0.587847 408.414 90.9971)"
            fill="white"
          />
          <rect
            width="0.105284"
            height="0.736944"
            transform="matrix(0.559132 0.829079 -0.828996 0.559254 410.417 93.853)"
            fill="white"
          />
          <rect
            width="0.105285"
            height="0.73694"
            transform="matrix(0.529858 0.848086 -0.84801 0.52998 412.323 96.7783)"
            fill="white"
          />
          <rect
            width="0.105285"
            height="0.736937"
            transform="matrix(0.49994 0.86606 -0.865991 0.50006 414.155 99.7817)"
            fill="white"
          />
          <rect
            width="0.105286"
            height="0.736934"
            transform="matrix(0.469413 0.882979 -0.882917 0.46953 415.852 102.831)"
            fill="white"
          />
          <rect
            width="0.105286"
            height="0.73693"
            transform="matrix(0.438315 0.898822 -0.898766 0.438428 417.442 105.939)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736927"
            transform="matrix(0.406682 0.913569 -0.913521 0.406791 418.921 109.1)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736924"
            transform="matrix(0.374555 0.927205 -0.927163 0.374658 420.287 112.312)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736921"
            transform="matrix(0.341972 0.93971 -0.939675 0.342068 421.542 115.569)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736919"
            transform="matrix(0.308972 0.951071 -0.951042 0.309062 422.682 118.869)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736916"
            transform="matrix(0.275597 0.961273 -0.96125 0.275678 423.709 122.204)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736914"
            transform="matrix(0.241886 0.970305 -0.970287 0.241958 424.621 125.574)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736913"
            transform="matrix(0.20788 0.978154 -0.978141 0.207943 425.409 128.973)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736911"
            transform="matrix(0.173621 0.984812 -0.984803 0.173675 426.078 132.399)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.73691"
            transform="matrix(0.139151 0.990271 -0.990265 0.139195 426.63 135.845)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736909"
            transform="matrix(0.104512 0.994524 -0.99452 0.104545 427.059 139.31)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736908"
            transform="matrix(0.0697454 0.997565 -0.997563 0.0697675 427.371 142.787)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736908"
            transform="matrix(0.0348939 0.999391 -0.999391 0.0349051 427.558 146.27)"
            fill="white"
          />
          <rect
            x="427.625"
            y="149.761"
            width="0.105289"
            height="0.736908"
            transform="rotate(90 427.625 149.761)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736908"
            transform="matrix(-0.0348939 0.999391 -0.999391 -0.0349051 427.569 153.251)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736908"
            transform="matrix(-0.0697454 0.997565 -0.997563 -0.0697675 427.389 156.738)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736909"
            transform="matrix(-0.104512 0.994524 -0.99452 -0.104545 427.093 160.214)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.73691"
            transform="matrix(-0.139151 0.990271 -0.990265 -0.139195 426.67 163.679)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736911"
            transform="matrix(-0.173621 0.984812 -0.984803 -0.173675 426.129 167.129)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736913"
            transform="matrix(-0.20788 0.978154 -0.978141 -0.207943 425.467 170.555)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736915"
            transform="matrix(-0.241886 0.970305 -0.970287 -0.241958 424.691 173.958)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736916"
            transform="matrix(-0.275597 0.961273 -0.96125 -0.275678 423.792 177.33)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736919"
            transform="matrix(-0.308972 0.951071 -0.951042 -0.309062 422.777 180.67)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736921"
            transform="matrix(-0.341972 0.93971 -0.939675 -0.342068 421.644 183.972)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736924"
            transform="matrix(-0.374555 0.927205 -0.927163 -0.374658 420.397 187.233)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736927"
            transform="matrix(-0.406683 0.91357 -0.913521 -0.406791 419.037 190.448)"
            fill="white"
          />
          <rect
            width="0.105286"
            height="0.73693"
            transform="matrix(-0.438315 0.898822 -0.898766 -0.438428 417.568 193.614)"
            fill="white"
          />
          <rect
            width="0.105286"
            height="0.736934"
            transform="matrix(-0.469413 0.882979 -0.882917 -0.46953 415.992 196.726)"
            fill="white"
          />
          <rect
            width="0.105285"
            height="0.736937"
            transform="matrix(-0.49994 0.86606 -0.865991 -0.50006 414.303 199.781)"
            fill="white"
          />
          <rect
            width="0.105285"
            height="0.73694"
            transform="matrix(-0.529858 0.848086 -0.84801 -0.52998 412.477 202.761)"
            fill="white"
          />
          <rect
            width="0.105284"
            height="0.736944"
            transform="matrix(-0.559132 0.829079 -0.828996 -0.559254 410.581 205.692)"
            fill="white"
          />
          <rect
            width="0.105283"
            height="0.736948"
            transform="matrix(-0.587724 0.809062 -0.808972 -0.587847 408.583 208.555)"
            fill="white"
          />
          <rect
            width="0.105283"
            height="0.736952"
            transform="matrix(-0.615601 0.788058 -0.787963 -0.615723 406.485 211.345)"
            fill="white"
          />
          <rect
            width="0.105282"
            height="0.736956"
            transform="matrix(-0.642727 0.766095 -0.765994 -0.642848 404.293 214.062)"
            fill="white"
          />
          <rect
            width="0.105282"
            height="0.73696"
            transform="matrix(-0.669072 0.743198 -0.743092 -0.66919 402.009 216.7)"
            fill="white"
          />
          <rect
            width="0.105281"
            height="0.736964"
            transform="matrix(-0.694601 0.719395 -0.719284 -0.694716 399.633 219.254)"
            fill="white"
          />
          <rect
            width="0.105281"
            height="0.736968"
            transform="matrix(-0.719284 0.694716 -0.694601 -0.719395 397.169 221.727)"
            fill="white"
          />
          <rect
            width="0.10528"
            height="0.736972"
            transform="matrix(-0.743092 0.66919 -0.669072 -0.743198 394.621 224.111)"
            fill="white"
          />
          <rect
            width="0.105279"
            height="0.736977"
            transform="matrix(-0.765994 0.642848 -0.642727 -0.766095 391.989 226.403)"
            fill="white"
          />
          <rect
            width="0.105279"
            height="0.73698"
            transform="matrix(-0.787963 0.615723 -0.615601 -0.788058 389.279 228.605)"
            fill="white"
          />
          <rect
            width="0.105278"
            height="0.736984"
            transform="matrix(-0.808972 0.587847 -0.587724 -0.809062 386.498 230.711)"
            fill="white"
          />
          <rect
            width="0.105278"
            height="0.736988"
            transform="matrix(-0.828996 0.559254 -0.559132 -0.829079 383.637 232.716)"
            fill="white"
          />
          <rect
            width="0.10461"
            height="0.735069"
            transform="matrix(-0.84801 0.52998 -0.529858 -0.848086 380.713 234.621)"
            fill="white"
          />
          <rect
            width="0.10546"
            height="0.737385"
            transform="matrix(-0.865991 0.50006 -0.49994 -0.86606 377.73 236.425)"
            fill="white"
          />
          <rect
            width="0.105467"
            height="0.73734"
            transform="matrix(-0.882917 0.46953 -0.469413 -0.882979 374.676 238.12)"
            fill="white"
          />
          <rect
            width="0.105475"
            height="0.737298"
            transform="matrix(-0.898766 0.438428 -0.438315 -0.898822 371.57 239.708)"
            fill="white"
          />
          <rect
            width="0.105481"
            height="0.737259"
            transform="matrix(-0.913521 0.406791 -0.406682 -0.913569 368.41 241.189)"
            fill="white"
          />
          <rect
            width="0.105488"
            height="0.737222"
            transform="matrix(-0.927163 0.374658 -0.374555 -0.927205 365.2 242.557)"
            fill="white"
          />
          <rect
            width="0.105494"
            height="0.737188"
            transform="matrix(-0.939675 0.342068 -0.341972 -0.93971 361.942 243.813)"
            fill="white"
          />
          <rect
            width="0.1055"
            height="0.737158"
            transform="matrix(-0.951042 0.309062 -0.308972 -0.951071 358.645 244.954)"
            fill="white"
          />
          <rect
            width="0.105505"
            height="0.73713"
            transform="matrix(-0.96125 0.275678 -0.275597 -0.961273 355.309 245.98)"
            fill="white"
          />
          <rect
            width="0.10551"
            height="0.737106"
            transform="matrix(-0.970287 0.241958 -0.241886 -0.970305 351.94 246.89)"
            fill="white"
          />
          <rect
            width="0.105514"
            height="0.737084"
            transform="matrix(-0.978141 0.207943 -0.20788 -0.978154 348.541 247.679)"
            fill="white"
          />
          <rect
            width="0.105517"
            height="0.737066"
            transform="matrix(-0.984803 0.173675 -0.173621 -0.984812 345.117 248.35)"
            fill="white"
          />
          <rect
            width="0.10552"
            height="0.737051"
            transform="matrix(-0.990265 0.139195 -0.139151 -0.990271 341.669 248.901)"
            fill="white"
          />
          <rect
            width="0.105523"
            height="0.73704"
            transform="matrix(-0.99452 0.104545 -0.104512 -0.994524 338.207 249.332)"
            fill="white"
          />
          <rect
            width="0.105524"
            height="0.737032"
            transform="matrix(-0.997563 0.0697675 -0.0697454 -0.997565 334.73 249.642)"
            fill="white"
          />
          <rect
            width="0.105525"
            height="0.737027"
            transform="matrix(-0.999391 0.0349051 -0.0348939 -0.999391 331.244 249.83)"
            fill="white"
          />
          <rect
            x="327.757"
            y="249.895"
            width="0.105526"
            height="0.737025"
            transform="rotate(-180 327.757 249.895)"
            fill="white"
          />
          <rect
            width="0.105525"
            height="0.737027"
            transform="matrix(-0.999391 -0.0349051 0.0348939 -0.999391 324.266 249.839)"
            fill="white"
          />
          <rect
            width="0.105524"
            height="0.737032"
            transform="matrix(-0.997563 -0.0697675 0.0697454 -0.997565 320.782 249.659)"
            fill="white"
          />
          <rect
            width="0.105523"
            height="0.73704"
            transform="matrix(-0.99452 -0.104545 0.104512 -0.994524 317.303 249.363)"
            fill="white"
          />
          <rect
            width="0.10552"
            height="0.737051"
            transform="matrix(-0.990265 -0.139195 0.139151 -0.990271 313.838 248.943)"
            fill="white"
          />
          <rect
            width="0.105517"
            height="0.737066"
            transform="matrix(-0.984803 -0.173675 0.173621 -0.984812 310.392 248.402)"
            fill="white"
          />
          <rect
            width="0.105514"
            height="0.737084"
            transform="matrix(-0.978141 -0.207943 0.20788 -0.978154 306.963 247.74)"
            fill="white"
          />
          <rect
            width="0.10551"
            height="0.737106"
            transform="matrix(-0.970287 -0.241958 0.241886 -0.970305 303.564 246.96)"
            fill="white"
          />
          <rect
            width="0.105505"
            height="0.73713"
            transform="matrix(-0.96125 -0.275678 0.275597 -0.961273 300.191 246.06)"
            fill="white"
          />
          <rect
            width="0.1055"
            height="0.737158"
            transform="matrix(-0.951042 -0.309062 0.308972 -0.951071 296.852 245.045)"
            fill="white"
          />
          <rect
            width="0.105494"
            height="0.737188"
            transform="matrix(-0.939675 -0.342068 0.341972 -0.93971 293.55 243.914)"
            fill="white"
          />
          <rect
            width="0.105488"
            height="0.737222"
            transform="matrix(-0.927163 -0.374658 0.374555 -0.927205 290.292 242.669)"
            fill="white"
          />
          <rect
            width="0.105481"
            height="0.737259"
            transform="matrix(-0.913521 -0.406791 0.406683 -0.91357 287.075 241.31)"
            fill="white"
          />
          <rect
            width="0.105474"
            height="0.737298"
            transform="matrix(-0.898766 -0.438428 0.438315 -0.898822 283.91 239.838)"
            fill="white"
          />
          <rect
            width="0.105467"
            height="0.73734"
            transform="matrix(-0.882917 -0.46953 0.469413 -0.882979 280.799 238.257)"
            fill="white"
          />
          <rect
            width="0.10546"
            height="0.737385"
            transform="matrix(-0.865991 -0.50006 0.49994 -0.86606 277.744 236.572)"
            fill="white"
          />
          <rect
            width="0.10461"
            height="0.735069"
            transform="matrix(-0.84801 -0.52998 0.529858 -0.848086 274.75 234.78)"
            fill="white"
          />
          <rect
            width="0.105278"
            height="0.736988"
            transform="matrix(-0.828996 -0.559254 0.559132 -0.829079 271.822 232.881)"
            fill="white"
          />
          <rect
            width="0.105278"
            height="0.736984"
            transform="matrix(-0.808972 -0.587847 0.587724 -0.809062 268.958 230.883)"
            fill="white"
          />
          <rect
            width="0.105279"
            height="0.73698"
            transform="matrix(-0.787963 -0.615723 0.615601 -0.788058 266.169 228.787)"
            fill="white"
          />
          <rect
            width="0.105279"
            height="0.736977"
            transform="matrix(-0.765994 -0.642848 0.642727 -0.766095 263.451 226.594)"
            fill="white"
          />
          <rect
            width="0.10528"
            height="0.736972"
            transform="matrix(-0.743092 -0.66919 0.669072 -0.743198 260.814 224.309)"
            fill="white"
          />
          <rect
            width="0.105281"
            height="0.736968"
            transform="matrix(-0.719284 -0.694716 0.694601 -0.719395 258.261 221.93)"
            fill="white"
          />
          <rect
            width="0.105281"
            height="0.736964"
            transform="matrix(-0.694601 -0.719395 0.719284 -0.694716 255.789 219.466)"
            fill="white"
          />
          <rect
            width="0.105282"
            height="0.73696"
            transform="matrix(-0.669072 -0.743198 0.743092 -0.66919 253.406 216.917)"
            fill="white"
          />
          <rect
            width="0.105282"
            height="0.736956"
            transform="matrix(-0.642727 -0.766095 0.765994 -0.642848 251.113 214.286)"
            fill="white"
          />
          <rect
            width="0.105283"
            height="0.736952"
            transform="matrix(-0.615601 -0.788058 0.787963 -0.615723 248.914 211.577)"
            fill="white"
          />
          <rect
            width="0.105283"
            height="0.736948"
            transform="matrix(-0.587724 -0.809062 0.808972 -0.587847 246.805 208.792)"
            fill="white"
          />
          <rect
            width="0.105284"
            height="0.736944"
            transform="matrix(-0.559132 -0.829079 0.828996 -0.559254 244.801 205.937)"
            fill="white"
          />
          <rect
            width="0.105285"
            height="0.73694"
            transform="matrix(-0.529858 -0.848086 0.84801 -0.52998 242.896 203.01)"
            fill="white"
          />
          <rect
            width="0.105285"
            height="0.736937"
            transform="matrix(-0.49994 -0.86606 0.865991 -0.50006 241.092 200.021)"
            fill="white"
          />
          <rect
            width="0.105286"
            height="0.736934"
            transform="matrix(-0.469413 -0.882979 0.882917 -0.46953 239.398 196.972)"
            fill="white"
          />
          <rect
            width="0.105286"
            height="0.73693"
            transform="matrix(-0.438315 -0.898822 0.898766 -0.438428 237.809 193.865)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736927"
            transform="matrix(-0.406682 -0.913569 0.913521 -0.406791 236.328 190.704)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736924"
            transform="matrix(-0.374555 -0.927205 0.927163 -0.374658 234.959 187.492)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736921"
            transform="matrix(-0.341972 -0.93971 0.939675 -0.342068 233.703 184.235)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736919"
            transform="matrix(-0.308972 -0.951071 0.951042 -0.309062 232.565 180.936)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736916"
            transform="matrix(-0.275597 -0.961273 0.96125 -0.275678 231.539 177.6)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736914"
            transform="matrix(-0.241886 -0.970305 0.970287 -0.241958 230.633 174.229)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736913"
            transform="matrix(-0.20788 -0.978154 0.978141 -0.207943 229.841 170.831)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736911"
            transform="matrix(-0.173621 -0.984812 0.984803 -0.173675 229.169 167.405)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.73691"
            transform="matrix(-0.139151 -0.990271 0.990265 -0.139195 228.616 163.959)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736909"
            transform="matrix(-0.104512 -0.994524 0.99452 -0.104545 228.189 160.493)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736908"
            transform="matrix(-0.0697454 -0.997565 0.997563 -0.0697675 227.881 157.017)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736908"
            transform="matrix(-0.0348939 -0.999391 0.999391 -0.0349051 227.692 153.533)"
            fill="white"
          />
          <rect
            x="227.625"
            y="150.043"
            width="0.105289"
            height="0.736908"
            transform="rotate(-90 227.625 150.043)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736908"
            transform="matrix(0.0348939 -0.999391 0.999391 0.0349051 227.679 146.552)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736908"
            transform="matrix(0.0697454 -0.997565 0.997563 0.0697675 227.858 143.067)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736909"
            transform="matrix(0.104512 -0.994524 0.99452 0.104545 228.159 139.588)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.73691"
            transform="matrix(0.139151 -0.990271 0.990265 0.139195 228.578 136.125)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736911"
            transform="matrix(0.173621 -0.984812 0.984803 0.173675 229.118 132.676)"
            fill="white"
          />
          <rect
            width="0.105289"
            height="0.736913"
            transform="matrix(0.20788 -0.978154 0.978141 0.207943 229.781 129.248)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736915"
            transform="matrix(0.241886 -0.970305 0.970287 0.241958 230.559 125.846)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736916"
            transform="matrix(0.275597 -0.961273 0.96125 0.275678 231.458 122.475)"
            fill="white"
          />
          <rect
            width="0.105288"
            height="0.736919"
            transform="matrix(0.308972 -0.951071 0.951042 0.309062 232.473 119.134)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736921"
            transform="matrix(0.341972 -0.93971 0.939675 0.342068 233.604 115.832)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736924"
            transform="matrix(0.374555 -0.927205 0.927163 0.374658 234.85 112.572)"
            fill="white"
          />
          <rect
            width="0.105287"
            height="0.736927"
            transform="matrix(0.406683 -0.91357 0.913521 0.406791 236.208 109.357)"
            fill="white"
          />
          <rect
            width="0.105286"
            height="0.73693"
            transform="matrix(0.438315 -0.898822 0.898766 0.438428 237.678 106.189)"
            fill="white"
          />
          <rect
            width="0.105286"
            height="0.736934"
            transform="matrix(0.469413 -0.882979 0.882917 0.46953 239.258 103.079)"
            fill="white"
          />
          <rect
            width="0.105285"
            height="0.736937"
            transform="matrix(0.49994 -0.86606 0.865991 0.50006 240.947 100.023)"
            fill="white"
          />
          <rect
            width="0.105285"
            height="0.73694"
            transform="matrix(0.529858 -0.848086 0.84801 0.52998 242.739 97.0293)"
            fill="white"
          />
          <rect
            width="0.105284"
            height="0.736944"
            transform="matrix(0.559132 -0.829079 0.828996 0.559254 244.637 94.0977)"
            fill="white"
          />
          <rect
            width="0.105283"
            height="0.736948"
            transform="matrix(0.587724 -0.809062 0.808972 0.587847 246.631 91.2368)"
            fill="white"
          />
          <rect
            width="0.105283"
            height="0.736952"
            transform="matrix(0.615601 -0.788058 0.787963 0.615723 248.727 88.4443)"
            fill="white"
          />
          <rect
            width="0.105282"
            height="0.736956"
            transform="matrix(0.642727 -0.766095 0.765994 0.642848 250.921 85.729)"
            fill="white"
          />
          <rect
            width="0.105282"
            height="0.73696"
            transform="matrix(0.669072 -0.743198 0.743092 0.66919 253.206 83.0898)"
            fill="white"
          />
          <rect
            width="0.105281"
            height="0.736964"
            transform="matrix(0.694601 -0.719395 0.719284 0.694716 255.582 80.5356)"
            fill="white"
          />
          <rect
            width="0.105281"
            height="0.736968"
            transform="matrix(0.719284 -0.694716 0.694601 0.719395 258.046 78.064)"
            fill="white"
          />
          <rect
            width="0.10528"
            height="0.736972"
            transform="matrix(0.743092 -0.66919 0.669072 0.743198 260.598 75.6794)"
            fill="white"
          />
          <rect
            width="0.105279"
            height="0.736977"
            transform="matrix(0.765994 -0.642848 0.642727 0.766095 263.227 73.3875)"
            fill="white"
          />
          <rect
            width="0.105279"
            height="0.73698"
            transform="matrix(0.787963 -0.615723 0.615601 0.788058 265.935 71.1833)"
            fill="white"
          />
          <rect
            width="0.105278"
            height="0.736984"
            transform="matrix(0.808972 -0.587847 0.587724 0.809062 268.719 69.0798)"
            fill="white"
          />
          <rect
            width="0.105278"
            height="0.736988"
            transform="matrix(0.828996 -0.559254 0.559132 0.829079 271.577 67.0742)"
            fill="white"
          />
          <rect
            width="0.10461"
            height="0.735069"
            transform="matrix(0.84801 -0.52998 0.529858 0.848086 274.502 65.1699)"
            fill="white"
          />
          <rect
            width="0.10546"
            height="0.737385"
            transform="matrix(0.865991 -0.50006 0.49994 0.86606 277.488 63.3657)"
            fill="white"
          />
          <rect
            width="0.105467"
            height="0.73734"
            transform="matrix(0.882917 -0.46953 0.469413 0.882979 280.537 61.6709)"
            fill="white"
          />
          <rect
            width="0.105475"
            height="0.737298"
            transform="matrix(0.898766 -0.438428 0.438315 0.898822 283.645 60.0806)"
            fill="white"
          />
          <rect
            width="0.105481"
            height="0.737259"
            transform="matrix(0.913521 -0.406791 0.406682 0.913569 286.807 58.6011)"
            fill="white"
          />
          <rect
            width="0.105488"
            height="0.737222"
            transform="matrix(0.927163 -0.374658 0.374555 0.927205 290.018 57.2332)"
            fill="white"
          />
          <rect
            width="0.105494"
            height="0.737188"
            transform="matrix(0.939675 -0.342068 0.341972 0.93971 293.271 55.9761)"
            fill="white"
          />
          <rect
            width="0.1055"
            height="0.737158"
            transform="matrix(0.951042 -0.309062 0.308972 0.951071 296.573 54.8347)"
            fill="white"
          />
          <rect
            width="0.105505"
            height="0.73713"
            transform="matrix(0.96125 -0.275678 0.275597 0.961273 299.908 53.811)"
            fill="white"
          />
          <rect
            width="0.10551"
            height="0.737106"
            transform="matrix(0.970287 -0.241958 0.241886 0.970305 303.276 52.9011)"
            fill="white"
          />
          <rect
            width="0.105514"
            height="0.737084"
            transform="matrix(0.978141 -0.207943 0.20788 0.978154 306.674 52.1101)"
            fill="white"
          />
          <rect
            width="0.105517"
            height="0.737066"
            transform="matrix(0.984803 -0.173675 0.173621 0.984812 310.102 51.4395)"
            fill="white"
          />
          <rect
            width="0.10552"
            height="0.737051"
            transform="matrix(0.990265 -0.139195 0.139151 0.990271 313.546 50.8882)"
            fill="white"
          />
          <rect
            width="0.105523"
            height="0.73704"
            transform="matrix(0.99452 -0.104545 0.104512 0.994524 317.011 50.4597)"
            fill="white"
          />
          <rect
            width="0.105524"
            height="0.737032"
            transform="matrix(0.997563 -0.0697675 0.0697454 0.997565 320.484 50.1489)"
            fill="white"
          />
          <rect
            width="0.105525"
            height="0.737027"
            transform="matrix(0.999391 -0.0349051 0.0348939 0.999391 323.971 49.9607)"
            fill="white"
          />
        </g>
        <path
          d="M376.752 151.573C376.752 143.555 374.815 135.656 371.107 128.548C367.398 121.44 362.026 115.333 355.45 110.748C348.874 106.162 341.287 103.234 333.336 102.212C325.385 101.19 317.305 102.105 309.783 104.878C302.261 107.652 295.521 112.201 290.136 118.141C284.75 124.08 280.879 131.233 278.853 138.99C276.826 146.747 276.703 154.879 278.494 162.694C280.286 170.51 283.939 177.776 289.142 183.875L290.241 182.937C285.189 177.015 281.642 169.96 279.903 162.372C278.163 154.783 278.282 146.887 280.25 139.355C282.218 131.823 285.977 124.878 291.206 119.111C296.435 113.345 302.979 108.927 310.283 106.234C317.586 103.541 325.432 102.653 333.152 103.645C340.872 104.638 348.239 107.481 354.624 111.933C361.009 116.385 366.224 122.314 369.826 129.216C373.427 136.118 375.308 143.788 375.308 151.573H376.752Z"
          fill="none"
          stroke="#E27538"
          strokeDasharray={fuel * 1.8 + " 2000"}
        />
        <g filter="url(#filter0_d_799_3663)">
          <path
            d="M310.668 60.0058C311.844 59.3023 317.207 57.8953 327.625 57.8953C338.043 57.8953 343.406 59.3023 344.582 60.0058L347.43 62.1164C347.973 62.1555 349.492 62.5854 351.229 63.9924C353.399 65.7512 358.147 69.9723 358.418 73.7244C358.69 77.4765 358.961 92.3676 358.961 100.927C358.961 107.024 358.418 116.522 358.418 132.585C358.418 148.649 358.825 156.857 358.825 163.188C358.825 169.52 358.69 174.562 358.283 177.493C357.876 180.425 356.519 185.232 356.248 185.466C355.57 188.75 354.891 191.798 350.551 193.791C346.21 195.785 336.714 197.895 327.625 197.895C318.536 197.895 309.04 195.785 304.7 193.791C300.359 191.798 299.68 188.75 299.002 185.466C298.731 185.232 297.374 180.425 296.967 177.493C296.56 174.562 296.425 169.52 296.425 163.188C296.425 156.857 296.832 148.649 296.832 132.585C296.832 116.522 296.289 107.024 296.289 100.927C296.289 92.3676 296.56 77.4765 296.832 73.7244C297.103 69.9723 301.851 65.7512 304.021 63.9924C305.758 62.5854 307.277 62.1555 307.82 62.1164L310.668 60.0058Z"
            fill="url(#paint5_radial_799_3663)"
            shapeRendering="crispEdges"
          />
          <path
            d="M310.668 60.0058C311.844 59.3023 317.207 57.8953 327.625 57.8953C338.043 57.8953 343.406 59.3023 344.582 60.0058L347.43 62.1164C347.973 62.1555 349.492 62.5854 351.229 63.9924C353.399 65.7512 358.147 69.9723 358.418 73.7244C358.69 77.4765 358.961 92.3676 358.961 100.927C358.961 107.024 358.418 116.522 358.418 132.585C358.418 148.649 358.825 156.857 358.825 163.188C358.825 169.52 358.69 174.562 358.283 177.493C357.876 180.425 356.519 185.232 356.248 185.466C355.57 188.75 354.891 191.798 350.551 193.791C346.21 195.785 336.714 197.895 327.625 197.895C318.536 197.895 309.04 195.785 304.7 193.791C300.359 191.798 299.68 188.75 299.002 185.466C298.731 185.232 297.374 180.425 296.967 177.493C296.56 174.562 296.425 169.52 296.425 163.188C296.425 156.857 296.832 148.649 296.832 132.585C296.832 116.522 296.289 107.024 296.289 100.927C296.289 92.3676 296.56 77.4765 296.832 73.7244C297.103 69.9723 301.851 65.7512 304.021 63.9924C305.758 62.5854 307.277 62.1555 307.82 62.1164L310.668 60.0058Z"
            stroke="url(#paint6_linear_799_3663)"
            strokeWidth="0.438517"
            shapeRendering="crispEdges"
          />
        </g>
        <path
          d="M355.842 102.92L359.098 100.692L358.556 132.82H357.877M355.842 102.92V107.493M355.842 102.92L353.943 104.015M354.215 133.758L348.517 135.517V132.937M354.215 133.758L354.893 133.64M354.215 133.758C354.215 132.823 354.224 131.765 354.236 130.592M356.385 133.226L355.842 133.406L354.893 133.64M356.385 133.226L357.606 132.82H357.877M356.385 133.226L356.249 111.831M353.943 104.015L353.808 104.093V105.148C353.74 105.284 353.664 105.441 353.581 105.617M353.943 104.015C354.757 111.949 354.893 127.954 354.893 133.64M353.581 105.617C352.779 107.322 351.339 110.841 350.552 114.411C349.684 118.351 348.834 128.325 348.517 132.82V132.937M353.581 105.617C354.393 116.238 354.293 124.819 354.236 130.592M354.236 130.592L348.517 132.937M357.877 132.82C357.857 132.391 357.821 131.758 357.778 131.178M357.606 129.771C357.47 129.537 357.335 128.599 357.335 128.247C357.335 128.071 357.47 127.279 357.606 126.488M357.606 129.771C357.665 129.873 357.727 130.488 357.778 131.178M357.606 129.771C357.742 129.498 358.013 128.81 358.013 128.247C358.013 127.684 357.742 126.84 357.606 126.488M357.802 125.315C357.848 125.028 357.877 124.811 357.877 124.729C357.877 124.377 358.284 121.094 358.42 120.86C358.528 120.672 358.053 123.752 357.802 125.315ZM357.802 125.315C358.27 125.902 358.42 127.074 358.42 128.481C358.42 129.232 357.992 130.592 357.778 131.178M357.802 125.315C357.751 125.644 357.678 126.066 357.606 126.488"
          stroke="url(#paint7_linear_799_3663)"
          strokeOpacity="0.26"
          strokeWidth="0.219259"
        />
        <path
          d="M299.408 102.92L296.152 100.692L296.695 132.82H297.373M299.408 102.92L299.272 107.493M299.408 102.92L301.307 104.015M301.036 133.758L306.733 135.517V132.937M301.036 133.758L300.357 133.64M301.036 133.758C301.036 132.823 301.026 131.765 301.014 130.592M299.272 107.493L298.187 108.548M299.272 107.493C299.543 107.649 300.086 108.079 300.086 108.548V110.073L299.662 110.214M298.865 133.226L299.408 133.406L300.357 133.64M298.865 133.226L297.644 132.82H297.373M298.865 133.226L299.001 111.831V111.744M301.307 104.015L301.442 104.093V105.148C301.51 105.284 301.586 105.441 301.669 105.617M301.307 104.015C300.493 111.949 300.357 127.954 300.357 133.64M301.669 105.617C302.471 107.322 303.911 110.841 304.698 114.411C305.566 118.351 306.416 128.325 306.733 132.82V132.937M301.669 105.617C300.871 116.069 300.954 124.545 301.011 130.314L301.014 130.592M301.014 130.592L306.733 132.937M297.373 132.82C297.394 132.391 297.429 131.758 297.472 131.178M297.644 129.771C297.78 129.537 297.915 128.599 297.915 128.247C297.915 128.071 297.78 127.279 297.644 126.488M297.644 129.771C297.585 129.873 297.524 130.488 297.472 131.178M297.644 129.771C297.509 129.498 297.237 128.81 297.237 128.247C297.237 127.684 297.509 126.84 297.644 126.488M297.448 125.315C297.402 125.028 297.373 124.811 297.373 124.729C297.373 124.377 296.966 121.094 296.83 120.86C296.722 120.672 297.197 123.752 297.448 125.315ZM297.448 125.315C296.98 125.902 296.83 127.074 296.83 128.481C296.83 129.232 297.258 130.592 297.472 131.178M297.448 125.315C297.5 125.644 297.572 126.066 297.644 126.488M298.187 108.548C297.373 108.705 295.501 109.228 294.524 110.073C293.712 110.775 293.093 112.121 292.778 113.004M298.187 108.548C298.549 108.666 299.326 109.017 299.543 109.486C299.624 109.66 299.657 109.924 299.662 110.214M299.662 110.214C299.668 110.515 299.644 110.844 299.611 111.128M292.778 113.004C292.714 113.182 292.663 113.342 292.625 113.473L299.001 111.744M292.778 113.004L299.611 111.128M299.611 111.128C299.59 111.309 299.566 111.472 299.543 111.597L299.001 111.744"
          stroke="url(#paint8_linear_799_3663)"
          strokeOpacity="0.26"
          strokeWidth="0.219259"
        />
        <path
          d="M357.063 108.548L355.978 107.492C355.707 107.649 355.164 108.079 355.164 108.548C355.164 109.017 355.164 109.759 355.164 110.072L355.588 110.213M357.063 108.548C357.877 108.704 359.749 109.228 360.726 110.072C361.538 110.774 362.157 112.121 362.472 113.003M357.063 108.548C356.701 108.665 355.924 109.017 355.707 109.486C355.626 109.659 355.593 109.923 355.588 110.213M355.588 110.213C355.582 110.515 355.606 110.844 355.639 111.127M362.472 113.003C362.536 113.182 362.587 113.341 362.625 113.472L355.707 111.596C355.684 111.471 355.66 111.309 355.639 111.127M362.472 113.003L355.639 111.127"
          stroke="white"
          strokeOpacity="0.26"
          strokeWidth="0.219259"
        />
        <path
          d="M311.21 61.9988C312.703 61.6471 320.299 60.3573 327.624 60.24C334.95 60.3573 342.546 61.6471 344.039 61.9988M311.21 61.9988C312.024 60.1228 312.703 59.302 312.703 59.302M311.21 61.9988C309.247 68.2132 304.77 83.5499 302.568 95.1814M311.21 61.9988C310.459 62.1758 309.502 62.4123 308.633 62.6932M302.257 68.096C303.433 66.8453 305.676 64.5549 306.327 63.9921C306.731 63.6427 307.775 62.9704 308.633 62.6932M302.257 68.096L302.257 84.8631M302.257 68.096C302.222 68.1706 302.186 68.2489 302.148 68.3305M302.257 84.8631C302.122 87.4036 301.85 92.5784 301.85 92.9536M302.257 84.8631L308.633 62.6932M301.85 92.9536C301.85 93.2503 302.246 94.3483 302.568 95.1814M301.85 92.9536C301.398 94.5561 300.439 97.9955 300.222 98.9335C300.005 99.8715 299.589 101.982 299.408 102.92M302.664 95.7677C304.88 94.2825 313.516 91.3121 327.624 91.3121C341.732 91.3121 350.369 94.2825 352.585 95.7677M302.664 95.7677L302.568 95.1814M302.664 95.7677C302.438 96.2758 301.85 103.155 301.85 103.155M301.036 66.6889C300.222 67.5097 299.137 70.5583 299.002 71.3791C298.944 71.7273 298.188 74.4276 298.188 74.5449C298.188 74.5934 298.257 74.8022 298.406 75.0139M302.148 68.3305C301.259 70.2577 299.648 74.043 299.544 75.4829C299.273 75.4829 299.063 75.4828 298.866 75.3657M302.148 68.3305H301.443M300.901 68.3305C301.715 67.1189 304.183 64.3204 307.005 62.8196C307.439 62.5382 307.729 62.2333 307.819 62.1161M300.901 68.3305H301.443M300.901 68.3305C300.087 69.5421 299.137 72.4343 298.406 75.0139M298.866 75.3657C299.207 73.8746 300.25 70.3941 301.443 68.3305M298.866 75.3657L298.865 75.365C298.702 75.2685 298.501 75.1494 298.406 75.0139M301.85 103.155C301.85 103.155 301.715 103.858 301.443 104.093M301.85 103.155C302.021 102.922 302.34 102.461 302.717 101.865M302.717 101.865C303.038 101.358 303.4 100.753 303.749 100.106C304.699 98.3472 307.005 96.2367 308.09 95.5332C309.176 94.8296 314.602 92.2501 327.624 92.2501C340.647 92.2501 346.073 94.8296 347.159 95.5332C348.244 96.2367 350.55 98.3472 351.499 100.106C351.848 100.753 352.211 101.358 352.531 101.865M302.717 101.865C304.646 108.257 306.149 111.522 307.117 118.749M309.582 173.975C309.311 165.729 308.633 145.694 308.09 131.53C307.88 126.042 307.553 121.996 307.117 118.749M309.582 173.975H310.396M309.582 173.975C309.147 173.975 308.74 174.271 308.362 174.886M310.396 173.975C310.035 163.423 309.257 140.16 309.04 131.53C308.823 122.9 308.316 119.179 308.09 118.397M310.396 173.975L314.602 173.975M308.09 118.397C311.572 117.499 320.787 115.701 327.624 115.701C334.461 115.701 343.677 117.499 347.159 118.397M308.09 118.397L307.117 118.749M308.362 174.886C307.915 175.611 307.508 176.781 307.141 178.431C306.646 180.656 306.44 183.069 306.734 185.122M308.362 174.886C310.396 179.838 311.617 181.425 317.993 182.887C322.083 183.825 326.539 183.825 327.624 183.825C328.71 183.825 333.165 183.825 337.256 182.887C343.632 181.425 344.852 179.838 346.887 174.886M314.602 173.975C314.466 175.265 314.33 176.203 314.195 177.141H317.45C317.776 176.203 317.948 174.64 317.993 173.975M314.602 173.975H317.993M317.993 173.975L337.256 173.975M306.734 185.122C307.005 184.846 307.575 184.2 307.683 183.825C307.819 183.356 308.497 181.011 308.904 179.955C309.311 178.9 310.396 180.073 310.803 180.307C311.129 180.495 311.934 181.011 312.296 181.245C311.843 182.3 310.885 184.833 310.668 186.521C310.396 188.632 310.396 190.625 313.788 191.798C317.179 192.97 322.334 193.322 327.624 193.322C332.915 193.322 338.07 192.97 341.461 191.798C344.852 190.625 344.852 188.632 344.581 186.521C344.364 184.833 343.405 182.3 342.953 181.245C343.315 181.011 344.12 180.495 344.445 180.307C344.852 180.073 345.938 178.9 346.345 179.955C346.752 181.011 347.43 183.356 347.566 183.825C347.674 184.2 348.244 184.846 348.515 185.122M306.734 185.122C306.822 185.739 306.956 186.324 307.141 186.862M306.734 185.122L305.581 186.115M307.141 186.862C307.183 186.985 307.228 187.107 307.276 187.225C308.368 189.922 312.567 194.377 320.163 194.612C323.962 194.729 327.624 194.729 327.624 194.729C327.624 194.729 331.287 194.729 335.085 194.612C342.682 194.377 346.88 189.922 347.972 187.225C348.02 187.107 348.066 186.985 348.108 186.862M307.141 186.862C310.668 191.212 311.901 192.283 316.908 193.322C320.299 194.026 326.268 194.026 327.624 194.026C328.981 194.026 334.95 194.026 338.341 193.322C343.348 192.283 344.581 191.212 348.108 186.862M305.581 186.115L304.428 187.108M305.581 186.115C304.789 184.179 303.125 178.83 302.8 172.92M304.428 187.108C303.57 185.951 302.015 183.296 301.172 180.198M304.428 187.108C305.258 188.281 306.129 189.346 307.276 190.383M302.8 172.92C303.668 174.493 304.428 175.139 304.699 175.265C304.774 175.063 304.856 174.827 304.945 174.562M302.8 172.92C301.932 169.356 301.624 165.572 301.579 164.126M302.257 163.892L306.734 159.084V164.83C306.734 168.336 305.659 172.412 304.945 174.562M302.257 163.892C302.302 165.611 302.529 169.496 303.071 171.279C303.614 173.061 304.546 174.21 304.945 174.562M302.257 163.892L301.579 164.126M301.579 164.126L299.951 164.83M299.951 164.83C300.042 167.136 300.304 172.826 300.629 177.141C300.708 178.182 300.904 179.213 301.172 180.198M299.951 164.83L298.323 164.361C298.595 170.575 298.866 175.617 299.137 179.955M299.137 179.955C300.331 181.55 300.991 182.574 301.172 182.887M299.137 179.955C298.16 178.361 297.193 177.415 296.831 177.141M301.172 182.887V180.198M301.172 182.887C301.715 183.825 301.715 186.287 303.071 188.046C304.095 189.373 305.815 190.367 307.005 191.027M301.172 182.887C301.172 184.759 301.331 186.558 302.257 188.28M311.21 193.791C312.431 194.534 315.931 196.042 320.163 196.136C324.396 196.23 327.624 196.253 327.624 196.253C327.624 196.253 330.853 196.23 335.085 196.136C339.318 196.042 342.818 194.534 344.039 193.791M311.21 193.791C310.827 193.518 310.204 193.079 309.582 192.65M311.21 193.791C310.217 193.466 308.48 192.841 306.869 192.131M302.257 188.28C302.665 189.038 303.342 190.039 304.021 190.625C304.663 191.181 305.768 191.645 306.869 192.131M302.257 188.28C303.749 189.805 304.699 190.625 306.327 191.329C306.509 191.408 306.693 191.486 306.877 191.563M309.582 192.65C308.958 192.22 308.335 191.798 307.955 191.563C307.722 191.42 307.391 191.241 307.005 191.027M309.582 192.65C309.116 192.473 308.007 192.039 306.877 191.563M306.869 192.131L306.877 191.563M306.869 192.131C306.869 192.265 306.876 192.5 306.894 192.78M306.877 191.563L307.005 191.027M307.005 191.027L307.276 190.383M307.276 190.383C308.192 191.211 309.283 192.02 310.668 192.853C313.788 194.729 316.636 195.433 327.624 195.433C338.612 195.433 341.461 194.729 344.581 192.853C345.966 192.02 347.057 191.211 347.972 190.383M307.141 194.846C307.141 194.768 307.114 194.448 307.005 193.791C306.948 193.448 306.914 193.087 306.894 192.78M306.894 192.78C308.468 193.625 312.323 195.456 315.144 196.019C318.671 196.722 323.826 197.074 327.624 197.074C331.423 197.074 336.578 196.722 340.105 196.019C342.926 195.456 346.78 193.625 348.355 192.78M306.894 192.78C305.581 192.131 305.242 192.032 303.342 190.86C301.443 189.687 299.544 186.17 299.137 185.466M300.222 189.453C300.765 189.95 302.04 191.116 302.8 191.798C303.559 192.48 304.97 193.567 305.581 194.026M344.039 61.9988C343.225 60.1228 342.546 59.302 342.546 59.302M344.039 61.9988C346.002 68.2132 350.479 83.5499 352.681 95.1814M344.039 61.9988C344.789 62.1758 345.747 62.4123 346.616 62.6932M352.992 68.096C351.816 66.8453 349.573 64.5549 348.922 63.9921C348.518 63.6427 347.474 62.9704 346.616 62.6932M352.992 68.096L352.992 84.8631M352.992 68.096C353.027 68.1706 353.063 68.2489 353.101 68.3305M352.992 84.8631C353.127 87.4036 353.399 92.5784 353.399 92.9536M352.992 84.8631L346.616 62.6932M353.399 92.9536C353.399 93.2503 353.003 94.3483 352.681 95.1814M353.399 92.9536C353.851 94.5561 354.809 97.9955 355.026 98.9335C355.243 99.8715 355.659 101.982 355.84 102.92M352.585 95.7677L352.681 95.1814M352.585 95.7677C352.811 96.2758 353.399 103.155 353.399 103.155M354.213 66.6889C355.026 67.5097 356.112 70.5583 356.247 71.3791C356.305 71.7273 357.061 74.4276 357.061 74.5449C357.061 74.5934 356.992 74.8022 356.843 75.0139M353.101 68.3305C353.99 70.2577 355.601 74.043 355.705 75.4829C355.976 75.4829 356.185 75.4828 356.383 75.3657M353.101 68.3305H353.806M354.348 68.3305C353.534 67.1189 351.065 64.3204 348.244 62.8196C347.81 62.5382 347.52 62.2333 347.43 62.1161M354.348 68.3305H353.806M354.348 68.3305C355.162 69.5421 356.112 72.4343 356.843 75.0139M356.383 75.3657C356.042 73.8746 354.999 70.3941 353.806 68.3305M356.383 75.3657L356.384 75.365C356.547 75.2685 356.748 75.1494 356.843 75.0139M353.399 103.155C353.399 103.155 353.534 103.858 353.806 104.093M353.399 103.155C353.228 102.922 352.908 102.461 352.531 101.865M352.531 101.865C350.602 108.257 349.1 111.522 348.131 118.749M345.666 173.975C345.938 165.729 346.616 145.694 347.159 131.53C347.369 126.042 347.696 121.996 348.131 118.749M345.666 173.975H344.852M345.666 173.975C346.102 173.975 346.509 174.271 346.887 174.886M344.852 173.975C345.214 163.423 345.992 140.16 346.209 131.53C346.426 122.9 346.932 119.179 347.159 118.397M344.852 173.975H340.647M347.159 118.397L348.131 118.749M346.887 174.886C347.334 175.611 347.741 176.781 348.108 178.431C348.603 180.656 348.809 183.069 348.515 185.122M340.647 173.975C340.783 175.265 340.918 176.203 341.054 177.141H337.798C337.473 176.203 337.301 174.64 337.256 173.975M340.647 173.975H337.256M348.515 185.122C348.427 185.739 348.293 186.324 348.108 186.862M348.515 185.122L349.668 186.115M349.668 186.115L350.821 187.108M349.668 186.115C350.459 184.179 352.123 178.83 352.449 172.92M350.821 187.108C351.679 185.951 353.234 183.296 354.077 180.198M350.821 187.108C349.991 188.281 349.12 189.346 347.972 190.383M352.449 172.92C351.581 174.493 350.821 175.139 350.55 175.265C350.475 175.063 350.393 174.827 350.304 174.562M352.449 172.92C353.317 169.356 353.625 165.572 353.67 164.126M352.992 163.892L348.515 159.084V164.83C348.515 168.336 349.59 172.412 350.304 174.562M352.992 163.892C352.946 165.611 352.72 169.496 352.178 171.279C351.635 173.061 350.703 174.21 350.304 174.562M352.992 163.892L353.67 164.126M353.67 164.126L355.298 164.83M355.298 164.83C355.207 167.136 354.945 172.826 354.619 177.141C354.541 178.182 354.345 179.213 354.077 180.198M355.298 164.83L356.926 164.361C356.654 170.575 356.383 175.617 356.112 179.955M356.112 179.955C354.918 181.55 354.258 182.574 354.077 182.887M356.112 179.955C357.088 178.361 358.056 177.415 358.418 177.141M354.077 182.887V180.198M354.077 182.887C353.534 183.825 353.534 186.287 352.178 188.046C351.154 189.373 349.434 190.367 348.244 191.027M354.077 182.887C354.077 184.759 353.918 186.558 352.992 188.28M344.039 193.791C344.422 193.518 345.045 193.079 345.666 192.65M344.039 193.791C345.032 193.466 346.769 192.841 348.379 192.131M352.992 188.28C352.584 189.038 351.906 190.039 351.228 190.625C350.586 191.181 349.481 191.645 348.379 192.131M352.992 188.28C351.499 189.805 350.55 190.625 348.922 191.329C348.74 191.408 348.556 191.486 348.372 191.563M345.666 192.65C346.29 192.22 346.914 191.798 347.294 191.563C347.527 191.42 347.857 191.241 348.244 191.027M345.666 192.65C346.133 192.473 347.242 192.039 348.372 191.563M348.379 192.131L348.372 191.563M348.379 192.131C348.379 192.265 348.373 192.5 348.355 192.78M348.372 191.563L348.244 191.027M348.244 191.027L347.972 190.383M348.108 194.846C348.108 194.768 348.135 194.448 348.244 193.791C348.3 193.448 348.335 193.087 348.355 192.78M348.355 192.78C349.668 192.131 350.007 192.032 351.906 190.86C353.806 189.687 355.705 186.17 356.112 185.466M355.026 189.453C354.484 189.95 353.209 191.116 352.449 191.798C351.689 192.48 350.279 193.567 349.668 194.026"
          stroke="url(#paint9_linear_799_3663)"
          strokeOpacity="0.26"
          strokeWidth="0.219259"
        />
        <path
          d="M308.225 96.1203C305.241 98.2309 304.291 100.693 304.02 102.804C304.427 104.68 306.597 113.943 307.276 115.35C307.954 116.757 308.09 117.226 311.21 116.64C314.33 116.053 317.857 115.584 319.078 115.467C320.298 115.35 321.112 114.529 321.519 113.122C321.926 111.715 322.74 109.604 323.418 108.784C324.097 107.963 326.403 107.963 327.624 107.963C328.845 107.963 331.151 107.963 331.829 108.784C332.507 109.604 333.321 111.715 333.728 113.122C334.135 114.529 334.949 115.35 336.17 115.467C337.391 115.584 340.918 116.053 344.038 116.64C347.158 117.226 347.294 116.757 347.972 115.35C348.65 113.943 350.821 104.68 351.227 102.804C350.956 100.693 350.007 98.2309 347.022 96.1203C344.038 94.0098 333.864 92.72 327.624 92.72C321.384 92.72 311.21 94.0098 308.225 96.1203Z"
          fill="#111111"
          stroke="white"
          strokeOpacity="0.26"
          strokeWidth="0.219259"
        />
        <path
          d="M302.257 163.891L306.734 159.084V156.27M302.257 163.891L301.444 164.243M302.257 163.891C302.165 163.142 302.076 162.186 301.992 161.077M301.444 164.243L299.951 164.829M301.444 164.243C301.037 155.689 300.25 137.583 300.358 133.59M299.951 164.829C299.409 157.982 299.454 144.544 299.544 138.682M299.951 164.829C299.749 164.759 299.194 164.571 298.459 164.331M301.037 133.757L306.734 135.516V137.275M301.037 133.757V136.219M301.037 133.757L300.358 133.59M306.734 137.275L301.037 136.219M306.734 137.275L306.734 156.27M301.037 136.219C301.136 141.358 301.394 150.949 301.78 157.794M306.734 156.27L304.699 158.333M301.992 161.077C301.918 160.091 301.847 158.984 301.78 157.794M301.992 161.077L304.699 158.333M301.78 157.794L304.699 158.333M300.358 133.59L299.816 133.456M298.866 133.21L297.917 132.936L297.51 132.858M298.866 133.21L299.137 133.288L299.816 133.456M298.866 133.21V141.965L299.544 138.682M299.544 138.682L299.816 133.456M298.459 164.331C298.371 164.302 298.281 164.273 298.188 164.243C297.32 163.962 296.65 163.422 296.424 163.188L296.696 151.697L296.696 141.379V132.702L297.51 132.858M298.459 164.331V162.484C298.469 162.445 298.479 162.402 298.49 162.356M297.51 132.858C297.51 139.581 298.188 155.566 298.188 156.27C298.188 156.371 298.202 156.49 298.226 156.622M298.226 156.622C297.942 157.012 297.374 158.122 297.374 159.436C297.374 161.077 298.114 161.993 298.49 162.356M298.226 156.622C298.297 157.009 298.454 157.513 298.595 158.045M298.49 162.356C298.555 162.077 298.64 161.67 298.713 161.227M298.713 161.227C298.798 160.708 298.866 160.14 298.866 159.67C298.866 159.162 298.739 158.589 298.595 158.045M298.713 161.227C298.583 161.177 298.296 160.796 298.188 159.67C298.079 158.544 298.414 158.117 298.595 158.045"
          stroke="url(#paint10_linear_799_3663)"
          strokeOpacity="0.26"
          strokeWidth="0.219259"
        />
        <path
          d="M352.993 163.891L348.516 159.084V156.27M352.993 163.891L353.806 164.243M352.993 163.891C353.085 163.142 353.174 162.186 353.258 161.077M353.806 164.243L355.299 164.829M353.806 164.243C354.213 155.689 355 137.583 354.892 133.59M355.299 164.829C355.841 157.982 355.796 144.544 355.706 138.682M355.299 164.829C355.501 164.759 356.056 164.571 356.791 164.331M354.213 133.757L348.516 135.516V137.275M354.213 133.757V136.219M354.213 133.757L354.892 133.59M348.516 137.275L354.213 136.219M348.516 137.275L348.516 156.27M354.213 136.219C354.114 141.358 353.856 150.949 353.47 157.794M348.516 156.27L350.551 158.333M353.258 161.077C353.332 160.091 353.403 158.984 353.47 157.794M353.258 161.077L350.551 158.333M353.47 157.794L350.551 158.333M354.892 133.59L355.434 133.456M356.384 133.21L357.333 132.936L357.74 132.858M356.384 133.21L356.113 133.288L355.434 133.456M356.384 133.21V141.965L355.706 138.682M355.706 138.682L355.434 133.456M356.791 164.331C356.879 164.302 356.969 164.273 357.062 164.243C357.93 163.962 358.6 163.422 358.826 163.188L358.554 151.697L358.554 141.379V132.702L357.74 132.858M356.791 164.331V162.484C356.781 162.445 356.771 162.402 356.76 162.356M357.74 132.858C357.74 139.581 357.062 155.566 357.062 156.27C357.062 156.371 357.048 156.49 357.024 156.622M357.024 156.622C357.308 157.012 357.876 158.122 357.876 159.436C357.876 161.077 357.136 161.993 356.76 162.356M357.024 156.622C356.953 157.009 356.796 157.513 356.655 158.045M356.76 162.356C356.695 162.077 356.61 161.67 356.537 161.227M356.537 161.227C356.452 160.708 356.384 160.14 356.384 159.67C356.384 159.162 356.511 158.589 356.655 158.045M356.537 161.227C356.667 161.177 356.954 160.796 357.062 159.67C357.171 158.544 356.836 158.117 356.655 158.045"
          stroke="url(#paint11_linear_799_3663)"
          strokeOpacity="0.26"
          strokeWidth="0.219259"
        />
        <path
          d="M327.626 165.651C327.355 165.807 326.785 166.448 326.676 167.761C326.638 168.225 326.7 168.731 326.812 169.221M327.554 171.259C327.579 171.308 327.603 171.354 327.626 171.396L327.554 171.259ZM327.554 171.259C327.32 170.8 326.997 170.032 326.812 169.221M327.554 171.259H326.749C326.77 170.636 326.812 169.357 326.812 169.221"
          stroke="white"
          strokeOpacity="0.26"
          strokeWidth="0.219259"
        />
        <path
          d="M327.624 165.651C327.895 165.807 328.465 166.448 328.574 167.761C328.612 168.225 328.55 168.731 328.438 169.221M327.696 171.259C327.671 171.308 327.647 171.354 327.624 171.396L327.696 171.259ZM327.696 171.259C327.93 170.8 328.253 170.032 328.438 169.221M327.696 171.259H328.501C328.48 170.636 328.438 169.357 328.438 169.221"
          stroke="white"
          strokeOpacity="0.26"
          strokeWidth="0.219259"
        />
        <path
          d="M385.23 145.958L385.307 145.958C385.677 145.958 385.976 146.258 385.976 146.628L385.972 150.225C385.972 150.48 385.765 150.687 385.51 150.687L385.438 150.686C385.183 150.686 384.976 150.479 384.977 150.224L384.977 149.815C384.977 149.471 384.699 149.193 384.356 149.192V149.192L383.485 149.191"
          stroke="#E37738"
          strokeWidth="0.461673"
          strokeLinecap="round"
        />
        <rect
          x="385.227"
          y="146.828"
          width="0.746459"
          height="1.49316"
          rx="0.115418"
          transform="rotate(0.0610379 385.227 146.828)"
          stroke="#E37738"
          strokeWidth="0.230837"
        />
        <rect
          x="379.999"
          y="151.303"
          width="4.97639"
          height="0.497719"
          rx="0.248859"
          transform="rotate(0.0610379 379.999 151.303)"
          fill="#E37738"
        />
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M381.195 145.082C380.813 145.081 380.503 145.391 380.502 145.774L380.496 151.551L384.477 151.556L384.483 145.778C384.484 145.395 384.174 145.085 383.792 145.085L381.195 145.082ZM381.231 145.58C381.104 145.58 381 145.683 381 145.81L380.998 148.086C380.998 148.214 381.101 148.317 381.228 148.317L383.753 148.32C383.88 148.32 383.984 148.217 383.984 148.089L383.986 145.814C383.986 145.686 383.883 145.583 383.755 145.583L381.231 145.58Z"
          fill="#E37738"
        />
        <path
          d="M380.496 151.551L380.381 151.551L380.38 151.667L380.496 151.667L380.496 151.551ZM384.477 151.556L384.477 151.671L384.592 151.671L384.593 151.556L384.477 151.556ZM381 145.81L381.116 145.811L381 145.81ZM381.231 145.58L381.231 145.464L381.231 145.58ZM380.998 148.086L380.882 148.086L380.998 148.086ZM383.755 145.583L383.755 145.698L383.755 145.583ZM380.618 145.774C380.618 145.455 380.877 145.197 381.195 145.197L381.196 144.966C380.749 144.966 380.387 145.327 380.387 145.773L380.618 145.774ZM380.611 151.552L380.618 145.774L380.387 145.773L380.381 151.551L380.611 151.552ZM384.477 151.44L380.496 151.436L380.496 151.667L384.477 151.671L384.477 151.44ZM384.368 145.778L384.362 151.556L384.593 151.556L384.599 145.778L384.368 145.778ZM383.791 145.2C384.11 145.2 384.368 145.459 384.368 145.778L384.599 145.778C384.599 145.332 384.238 144.97 383.792 144.969L383.791 145.2ZM381.195 145.197L383.791 145.2L383.792 144.969L381.196 144.966L381.195 145.197ZM381.116 145.811C381.116 145.747 381.167 145.695 381.231 145.695L381.231 145.464C381.04 145.464 380.885 145.619 380.885 145.81L381.116 145.811ZM381.113 148.086L381.116 145.811L380.885 145.81L380.882 148.086L381.113 148.086ZM381.229 148.202C381.165 148.202 381.113 148.15 381.113 148.086L380.882 148.086C380.882 148.277 381.037 148.433 381.228 148.433L381.229 148.202ZM383.753 148.205L381.229 148.202L381.228 148.433L383.752 148.435L383.753 148.205ZM383.868 148.089C383.868 148.153 383.816 148.205 383.753 148.205L383.752 148.435C383.944 148.436 384.099 148.281 384.099 148.09L383.868 148.089ZM383.871 145.813L383.868 148.089L384.099 148.09L384.101 145.814L383.871 145.813ZM383.755 145.698C383.819 145.698 383.871 145.75 383.871 145.813L384.101 145.814C384.102 145.622 383.947 145.467 383.756 145.467L383.755 145.698ZM381.231 145.695L383.755 145.698L383.756 145.467L381.231 145.464L381.231 145.695Z"
          fill="#E37738"
        />

        <path
          d="M176.738 33.8811L89.6535 44.2513C87.0319 44.5635 84.7043 46.0767 83.355 48.346L34.0434 131.28C32.632 133.653 32.4623 136.565 33.5885 139.087L75.9486 233.934C77.3156 236.995 80.3544 238.966 83.7066 238.966H176.738"
          stroke="#D7D1D1"
          strokeOpacity="0.1"
          strokeWidth="1.69933"
        />

        <path
          className="transition-all duration-500 ease-in-out"
          d="M167.264 226.096C166.839 226.096 166.448 225.987 166.092 225.769C165.747 225.539 165.471 225.24 165.264 224.872C165.057 224.504 164.954 224.113 164.954 223.699V216.025C164.954 215.6 165.057 215.209 165.264 214.852C165.471 214.496 165.747 214.214 166.092 214.007C166.448 213.789 166.839 213.68 167.264 213.68H174.99C175.416 213.68 175.801 213.789 176.146 214.007C176.502 214.214 176.784 214.496 176.991 214.852C177.198 215.209 177.301 215.6 177.301 216.025V223.699C177.301 224.113 177.198 224.504 176.991 224.872C176.784 225.24 176.502 225.539 176.146 225.769C175.801 225.987 175.416 226.096 174.99 226.096H167.264ZM167.834 223.941H174.938C175.019 223.941 175.088 223.912 175.145 223.854C175.214 223.785 175.249 223.711 175.249 223.63V217.784L167.834 223.941ZM167.006 221.94L174.421 215.784H167.333C167.241 215.784 167.161 215.818 167.092 215.887C167.034 215.945 167.006 216.014 167.006 216.094V221.94Z"
          fill={speed >= 0 ? "#3DA3D9" : "white"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M123.572 226.096V221.354C123.572 220.928 123.676 220.543 123.882 220.198C124.089 219.842 124.365 219.566 124.71 219.371C125.067 219.164 125.458 219.06 125.883 219.06H133.557C133.637 219.06 133.706 219.031 133.764 218.974C133.833 218.905 133.867 218.825 133.867 218.733V216.06C133.867 215.968 133.833 215.893 133.764 215.835C133.706 215.766 133.637 215.732 133.557 215.732H125.952C125.86 215.732 125.779 215.766 125.71 215.835C125.653 215.893 125.624 215.968 125.624 216.06V216.818H123.572V215.991C123.572 215.554 123.676 215.163 123.882 214.818C124.089 214.473 124.365 214.197 124.71 213.99C125.067 213.783 125.458 213.68 125.883 213.68H133.609C134.034 213.68 134.419 213.783 134.764 213.99C135.12 214.197 135.402 214.473 135.609 214.818C135.816 215.163 135.92 215.554 135.92 215.991V218.802C135.92 219.227 135.816 219.618 135.609 219.974C135.402 220.319 135.12 220.601 134.764 220.819C134.419 221.026 134.034 221.13 133.609 221.13H125.952C125.86 221.13 125.779 221.158 125.71 221.216C125.653 221.273 125.624 221.348 125.624 221.44V223.716C125.624 223.808 125.653 223.889 125.71 223.958C125.779 224.015 125.86 224.044 125.952 224.044H135.92V226.096H123.572ZM139.904 226.096C139.479 226.096 139.088 225.987 138.732 225.769C138.387 225.539 138.111 225.24 137.904 224.872C137.697 224.504 137.594 224.113 137.594 223.699V216.025C137.594 215.6 137.697 215.209 137.904 214.852C138.111 214.496 138.387 214.214 138.732 214.007C139.088 213.789 139.479 213.68 139.904 213.68H147.63C148.056 213.68 148.441 213.789 148.786 214.007C149.142 214.214 149.424 214.496 149.631 214.852C149.838 215.209 149.941 215.6 149.941 216.025V223.699C149.941 224.113 149.838 224.504 149.631 224.872C149.424 225.24 149.142 225.539 148.786 225.769C148.441 225.987 148.056 226.096 147.63 226.096H139.904ZM140.474 223.941H147.578C147.659 223.941 147.728 223.912 147.785 223.854C147.854 223.785 147.889 223.711 147.889 223.63V217.784L140.474 223.941ZM139.646 221.94L147.061 215.784H139.973C139.881 215.784 139.801 215.818 139.732 215.887C139.675 215.945 139.646 216.014 139.646 216.094V221.94Z"
          fill={speed >= 20 ? "#3DA3D9" : "white"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M90.8395 226.096V222.958H82.8206V220.957L90.8912 213.68H92.8916V220.888H94.6851V222.958H92.8916V226.096H90.8395ZM85.9419 220.888H90.8395V216.749L85.9419 220.888ZM98.3146 226.096C97.8893 226.096 97.4984 225.987 97.142 225.769C96.7971 225.539 96.5212 225.24 96.3142 224.872C96.1073 224.504 96.0038 224.113 96.0038 223.699V216.025C96.0038 215.6 96.1073 215.209 96.3142 214.852C96.5212 214.496 96.7971 214.214 97.142 214.007C97.4984 213.789 97.8893 213.68 98.3146 213.68H106.04C106.466 213.68 106.851 213.789 107.196 214.007C107.552 214.214 107.834 214.496 108.041 214.852C108.248 215.209 108.351 215.6 108.351 216.025V223.699C108.351 224.113 108.248 224.504 108.041 224.872C107.834 225.24 107.552 225.539 107.196 225.769C106.851 225.987 106.466 226.096 106.04 226.096H98.3146ZM98.8837 223.941H105.989C106.069 223.941 106.138 223.912 106.196 223.854C106.265 223.785 106.299 223.711 106.299 223.63V217.784L98.8837 223.941ZM98.056 221.94L105.471 215.784H98.3836C98.2917 215.784 98.2112 215.818 98.1422 215.887C98.0847 215.945 98.056 216.014 98.056 216.094V221.94Z"
          fill={speed >= 40 ? "#3DA3D9" : "white"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M75.8363 202.424C75.4109 202.424 75.02 202.321 74.6636 202.114C74.3187 201.895 74.0428 201.614 73.8358 201.269C73.6289 200.924 73.5254 200.539 73.5254 200.113V192.318C73.5254 191.882 73.6289 191.491 73.8358 191.146C74.0428 190.801 74.3187 190.525 74.6636 190.318C75.02 190.111 75.4109 190.008 75.8363 190.008H83.8552V192.06H75.9052C75.8133 192.06 75.7328 192.094 75.6638 192.163C75.6063 192.221 75.5776 192.296 75.5776 192.387V194.698C75.5776 194.779 75.6063 194.854 75.6638 194.922C75.7328 194.991 75.8133 195.026 75.9052 195.026H83.562C83.9874 195.026 84.3725 195.129 84.7174 195.336C85.0738 195.532 85.3555 195.808 85.5624 196.164C85.7694 196.509 85.8728 196.894 85.8728 197.32V200.113C85.8728 200.539 85.7694 200.924 85.5624 201.269C85.3555 201.614 85.0738 201.895 84.7174 202.114C84.3725 202.321 83.9874 202.424 83.562 202.424H75.8363ZM75.9052 200.372H83.5103C83.5908 200.372 83.6597 200.343 83.7172 200.286C83.7862 200.217 83.8207 200.136 83.8207 200.044V197.406C83.8207 197.325 83.7862 197.256 83.7172 197.199C83.6597 197.13 83.5908 197.095 83.5103 197.095H75.5776V200.044C75.5776 200.136 75.6063 200.217 75.6638 200.286C75.7328 200.343 75.8133 200.372 75.9052 200.372ZM89.6894 202.424C89.264 202.424 88.8731 202.315 88.5167 202.096C88.1718 201.866 87.8959 201.568 87.689 201.2C87.482 200.832 87.3786 200.441 87.3786 200.027V192.353C87.3786 191.928 87.482 191.537 87.689 191.18C87.8959 190.824 88.1718 190.542 88.5167 190.335C88.8731 190.117 89.264 190.008 89.6894 190.008H97.4151C97.8405 190.008 98.2257 190.117 98.5706 190.335C98.927 190.542 99.2086 190.824 99.4156 191.18C99.6225 191.537 99.726 191.928 99.726 192.353V200.027C99.726 200.441 99.6225 200.832 99.4156 201.2C99.2086 201.568 98.927 201.866 98.5706 202.096C98.2257 202.315 97.8405 202.424 97.4151 202.424H89.6894ZM90.2585 200.268H97.3634C97.4439 200.268 97.5129 200.24 97.5704 200.182C97.6393 200.113 97.6738 200.039 97.6738 199.958V194.112L90.2585 200.268ZM89.4307 198.268L96.8461 192.112H89.7584C89.6664 192.112 89.5859 192.146 89.5169 192.215C89.4595 192.273 89.4307 192.341 89.4307 192.422V198.268Z"
          fill={speed >= 60 ? "#3DA3D9" : "white"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M61.0973 173.493C60.6719 173.493 60.281 173.39 59.9246 173.183C59.5797 172.964 59.3038 172.683 59.0969 172.338C58.8899 171.993 58.7864 171.608 58.7864 171.182V168.423C58.7864 168.205 58.8209 167.992 58.8899 167.785C58.9704 167.567 59.0681 167.354 59.1831 167.147C59.0681 166.952 58.9704 166.745 58.8899 166.526C58.8209 166.296 58.7864 166.072 58.7864 165.854V163.388C58.7864 162.951 58.8899 162.56 59.0969 162.215C59.3038 161.87 59.5797 161.594 59.9246 161.387C60.281 161.18 60.6719 161.077 61.0973 161.077H68.823C69.1909 161.077 69.5358 161.163 69.8577 161.335C70.1796 161.508 70.4556 161.738 70.6855 162.025C70.9154 162.313 71.0649 162.629 71.1339 162.974V165.854C71.1339 166.29 71.0017 166.722 70.7372 167.147C71.0017 167.538 71.1339 167.963 71.1339 168.423V171.182C71.1339 171.608 71.0304 171.993 70.8235 172.338C70.6165 172.683 70.3349 172.964 69.9785 173.183C69.6336 173.39 69.2484 173.493 68.823 173.493H61.0973ZM61.1663 171.441H68.7713C68.8518 171.441 68.9208 171.412 68.9782 171.355C69.0472 171.286 69.0817 171.205 69.0817 171.113V168.509C69.0817 168.417 69.0472 168.343 68.9782 168.285C68.9208 168.216 68.8518 168.182 68.7713 168.182H61.1663C61.0743 168.182 60.9938 168.216 60.9248 168.285C60.8673 168.343 60.8386 168.417 60.8386 168.509V171.113C60.8386 171.205 60.8673 171.286 60.9248 171.355C60.9938 171.412 61.0743 171.441 61.1663 171.441ZM61.1663 166.302H68.7713C68.8518 166.302 68.9208 166.273 68.9782 166.216C69.0472 166.147 69.0817 166.066 69.0817 165.974V163.474C69.0817 163.382 69.0472 163.307 68.9782 163.25C68.9208 163.181 68.8518 163.146 68.7713 163.146H61.1663C61.0743 163.146 60.9938 163.181 60.9248 163.25C60.8673 163.307 60.8386 163.382 60.8386 163.474V165.974C60.8386 166.066 60.8673 166.147 60.9248 166.216C60.9938 166.273 61.0743 166.302 61.1663 166.302ZM75.1862 173.493C74.7608 173.493 74.3699 173.384 74.0135 173.166C73.6686 172.936 73.3927 172.637 73.1858 172.269C72.9788 171.901 72.8753 171.51 72.8753 171.096V163.422C72.8753 162.997 72.9788 162.606 73.1858 162.249C73.3927 161.893 73.6686 161.611 74.0135 161.404C74.3699 161.186 74.7608 161.077 75.1862 161.077H82.9119C83.3373 161.077 83.7225 161.186 84.0674 161.404C84.4238 161.611 84.7054 161.893 84.9124 162.249C85.1193 162.606 85.2228 162.997 85.2228 163.422V171.096C85.2228 171.51 85.1193 171.901 84.9124 172.269C84.7054 172.637 84.4238 172.936 84.0674 173.166C83.7225 173.384 83.3373 173.493 82.9119 173.493H75.1862ZM75.7553 171.338H82.8602C82.9407 171.338 83.0097 171.309 83.0671 171.251C83.1361 171.182 83.1706 171.108 83.1706 171.027V165.181L75.7553 171.338ZM74.9275 169.337L82.3429 163.181H75.2552C75.1632 163.181 75.0827 163.215 75.0137 163.284C74.9562 163.342 74.9275 163.411 74.9275 163.491V169.337Z"
          fill={speed >= 80 ? "#3DA3D9" : "white"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M45.9804 141.934V132.38L44.7905 133.846H42.0658L45.7045 129.517H48.0498V141.934H45.9804ZM51.7855 141.934C51.3601 141.934 50.9692 141.824 50.6128 141.606C50.2679 141.376 49.992 141.077 49.7851 140.709C49.5781 140.341 49.4747 139.95 49.4747 139.537V131.863C49.4747 131.437 49.5781 131.046 49.7851 130.69C49.992 130.333 50.2679 130.052 50.6128 129.845C50.9692 129.626 51.3601 129.517 51.7855 129.517H59.5113C59.9366 129.517 60.3218 129.626 60.6667 129.845C61.0231 130.052 61.3047 130.333 61.5117 130.69C61.7186 131.046 61.8221 131.437 61.8221 131.863V139.537C61.8221 139.95 61.7186 140.341 61.5117 140.709C61.3047 141.077 61.0231 141.376 60.6667 141.606C60.3218 141.824 59.9366 141.934 59.5113 141.934H51.7855ZM52.3546 139.778H59.4595C59.54 139.778 59.609 139.749 59.6665 139.692C59.7354 139.623 59.7699 139.548 59.7699 139.468V133.622L52.3546 139.778ZM51.5268 137.778L58.9422 131.621H51.8545C51.7625 131.621 51.682 131.656 51.613 131.725C51.5556 131.782 51.5268 131.851 51.5268 131.931V137.778ZM65.8744 141.934C65.449 141.934 65.0581 141.824 64.7017 141.606C64.3568 141.376 64.0809 141.077 63.874 140.709C63.667 140.341 63.5636 139.95 63.5636 139.537V131.863C63.5636 131.437 63.667 131.046 63.874 130.69C64.0809 130.333 64.3568 130.052 64.7017 129.845C65.0581 129.626 65.449 129.517 65.8744 129.517H73.6002C74.0255 129.517 74.4107 129.626 74.7556 129.845C75.112 130.052 75.3936 130.333 75.6006 130.69C75.8075 131.046 75.911 131.437 75.911 131.863V139.537C75.911 139.95 75.8075 140.341 75.6006 140.709C75.3936 141.077 75.112 141.376 74.7556 141.606C74.4107 141.824 74.0255 141.934 73.6002 141.934H65.8744ZM66.4435 139.778H73.5484C73.6289 139.778 73.6979 139.749 73.7554 139.692C73.8243 139.623 73.8588 139.548 73.8588 139.468V133.622L66.4435 139.778ZM65.6157 137.778L73.0311 131.621H65.9434C65.8514 131.621 65.7709 131.656 65.7019 131.725C65.6445 131.782 65.6157 131.851 65.6157 131.931V137.778Z"
          fill={speed >= 100 ? "#3DA3D9" : "white"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M63.7694 107.74V98.1858L62.5795 99.6516H59.8548L63.4935 95.3231H65.8388V107.74H63.7694ZM67.2637 107.74V102.997C67.2637 102.572 67.3671 102.187 67.5741 101.842C67.781 101.485 68.0569 101.209 68.4018 101.014C68.7582 100.807 69.1491 100.704 69.5745 100.704H77.2485C77.329 100.704 77.398 100.675 77.4555 100.617C77.5244 100.548 77.5589 100.468 77.5589 100.376V97.7029C77.5589 97.6109 77.5244 97.5362 77.4555 97.4787C77.398 97.4097 77.329 97.3753 77.2485 97.3753H69.6435C69.5515 97.3753 69.471 97.4097 69.402 97.4787C69.3446 97.5362 69.3158 97.6109 69.3158 97.7029V98.4617H67.2637V97.6339C67.2637 97.1971 67.3671 96.8062 67.5741 96.4613C67.781 96.1164 68.0569 95.8404 68.4018 95.6335C68.7582 95.4266 69.1491 95.3231 69.5745 95.3231H77.3003C77.7256 95.3231 78.1108 95.4266 78.4557 95.6335C78.8121 95.8404 79.0937 96.1164 79.3007 96.4613C79.5076 96.8062 79.6111 97.1971 79.6111 97.6339V100.445C79.6111 100.87 79.5076 101.261 79.3007 101.618C79.0937 101.962 78.8121 102.244 78.4557 102.463C78.1108 102.669 77.7256 102.773 77.3003 102.773H69.6435C69.5515 102.773 69.471 102.802 69.402 102.859C69.3446 102.917 69.3158 102.991 69.3158 103.083V105.36C69.3158 105.452 69.3446 105.532 69.402 105.601C69.471 105.659 69.5515 105.687 69.6435 105.687H79.6111V107.74H67.2637ZM83.596 107.74C83.1707 107.74 82.7798 107.63 82.4234 107.412C82.0785 107.182 81.8026 106.883 81.5956 106.515C81.3887 106.147 81.2852 105.756 81.2852 105.342V97.6684C81.2852 97.243 81.3887 96.8522 81.5956 96.4958C81.8026 96.1394 82.0785 95.8577 82.4234 95.6508C82.7798 95.4323 83.1707 95.3231 83.596 95.3231H91.3218C91.7472 95.3231 92.1323 95.4323 92.4772 95.6508C92.8336 95.8577 93.1153 96.1394 93.3222 96.4958C93.5292 96.8522 93.6326 97.243 93.6326 97.6684V105.342C93.6326 105.756 93.5292 106.147 93.3222 106.515C93.1153 106.883 92.8336 107.182 92.4772 107.412C92.1323 107.63 91.7472 107.74 91.3218 107.74H83.596ZM84.1651 105.584H91.2701C91.3505 105.584 91.4195 105.555 91.477 105.498C91.546 105.429 91.5805 105.354 91.5805 105.273V99.4274L84.1651 105.584ZM83.3374 103.583L90.7527 97.427H83.665C83.573 97.427 83.4926 97.4615 83.4236 97.5305C83.3661 97.5879 83.3374 97.6569 83.3374 97.7374V103.583Z"
          fill={speed >= 120 ? "#3DA3D9" : "white"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M90.7383 76.1792V66.6255L89.5484 68.0913H86.8236L90.4623 63.7628H92.8077V76.1792H90.7383ZM101.372 76.1792V73.0406H93.353V71.0402L101.424 63.7628H103.424V70.9712H105.218V73.0406H103.424V76.1792H101.372ZM96.4744 70.9712H101.372V66.8324L96.4744 70.9712ZM108.847 76.1792C108.422 76.1792 108.031 76.07 107.674 75.8515C107.33 75.6216 107.054 75.3227 106.847 74.9548C106.64 74.5869 106.536 74.196 106.536 73.7821V66.1081C106.536 65.6827 106.64 65.2919 106.847 64.9355C107.054 64.5791 107.33 64.2974 107.674 64.0904C108.031 63.872 108.422 63.7628 108.847 63.7628H116.573C116.998 63.7628 117.383 63.872 117.728 64.0904C118.085 64.2974 118.366 64.5791 118.573 64.9355C118.78 65.2919 118.884 65.6827 118.884 66.1081V73.7821C118.884 74.196 118.78 74.5869 118.573 74.9548C118.366 75.3227 118.085 75.6216 117.728 75.8515C117.383 76.07 116.998 76.1792 116.573 76.1792H108.847ZM109.416 74.0236H116.521C116.602 74.0236 116.671 73.9948 116.728 73.9373C116.797 73.8684 116.832 73.7936 116.832 73.7132V67.8671L109.416 74.0236ZM108.588 72.0232L116.004 65.8667H108.916C108.824 65.8667 108.744 65.9012 108.675 65.9702C108.617 66.0276 108.588 66.0966 108.588 66.1771V72.0232Z"
          fill={speed >= 140 ? "#3DA3D9" : "white"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M124.427 63.0266V53.4729L123.237 54.9387H120.513L124.151 50.6102H126.497V63.0266H124.427ZM130.232 63.0266C129.807 63.0266 129.416 62.9231 129.06 62.7162C128.715 62.4978 128.439 62.2161 128.232 61.8712C128.025 61.5263 127.922 61.1412 127.922 60.7158V52.921C127.922 52.4842 128.025 52.0933 128.232 51.7484C128.439 51.4035 128.715 51.1276 129.06 50.9206C129.416 50.7137 129.807 50.6102 130.232 50.6102H138.251V52.6624H130.301C130.209 52.6624 130.129 52.6969 130.06 52.7658C130.002 52.8233 129.974 52.898 129.974 52.99V55.3008C129.974 55.3813 130.002 55.4561 130.06 55.525C130.129 55.594 130.209 55.6285 130.301 55.6285H137.958C138.384 55.6285 138.769 55.732 139.114 55.9389C139.47 56.1344 139.752 56.4103 139.959 56.7667C140.166 57.1116 140.269 57.4967 140.269 57.9221V60.7158C140.269 61.1412 140.166 61.5263 139.959 61.8712C139.752 62.2161 139.47 62.4978 139.114 62.7162C138.769 62.9231 138.384 63.0266 137.958 63.0266H130.232ZM130.301 60.9745H137.906C137.987 60.9745 138.056 60.9457 138.113 60.8882C138.182 60.8193 138.217 60.7388 138.217 60.6468V58.0083C138.217 57.9278 138.182 57.8589 138.113 57.8014C138.056 57.7324 137.987 57.6979 137.906 57.6979H129.974V60.6468C129.974 60.7388 130.002 60.8193 130.06 60.8882C130.129 60.9457 130.209 60.9745 130.301 60.9745ZM144.086 63.0266C143.66 63.0266 143.269 62.9174 142.913 62.699C142.568 62.469 142.292 62.1701 142.085 61.8022C141.878 61.4343 141.775 61.0434 141.775 60.6296V52.9555C141.775 52.5301 141.878 52.1393 142.085 51.7829C142.292 51.4265 142.568 51.1448 142.913 50.9379C143.269 50.7194 143.66 50.6102 144.086 50.6102H151.811C152.237 50.6102 152.622 50.7194 152.967 50.9379C153.323 51.1448 153.605 51.4265 153.812 51.7829C154.019 52.1393 154.122 52.5301 154.122 52.9555V60.6296C154.122 61.0434 154.019 61.4343 153.812 61.8022C153.605 62.1701 153.323 62.469 152.967 62.699C152.622 62.9174 152.237 63.0266 151.811 63.0266H144.086ZM144.655 60.871H151.76C151.84 60.871 151.909 60.8422 151.967 60.7848C152.036 60.7158 152.07 60.6411 152.07 60.5606V54.7145L144.655 60.871ZM143.827 58.8706L151.242 52.7141H144.155C144.063 52.7141 143.982 52.7486 143.913 52.8176C143.856 52.8751 143.827 52.944 143.827 53.0245V58.8706Z"
          fill={speed >= 160 ? "#3DA3D9" : "white"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M168.174 55.1372V45.5835L166.984 47.0493H164.259L167.898 42.7208H170.243V55.1372H168.174ZM173.979 55.1372C173.554 55.1372 173.163 55.0337 172.806 54.8268C172.462 54.6084 172.186 54.3267 171.979 53.9818C171.772 53.6369 171.668 53.2518 171.668 52.8264V50.0672C171.668 49.8487 171.703 49.636 171.772 49.4291C171.852 49.2107 171.95 48.998 172.065 48.791C171.95 48.5956 171.852 48.3887 171.772 48.1702C171.703 47.9403 171.668 47.7161 171.668 47.4977V45.0316C171.668 44.5948 171.772 44.2039 171.979 43.859C172.186 43.5141 172.462 43.2382 172.806 43.0312C173.163 42.8243 173.554 42.7208 173.979 42.7208H181.705C182.073 42.7208 182.418 42.807 182.74 42.9795C183.061 43.1519 183.337 43.3819 183.567 43.6693C183.797 43.9567 183.947 44.2729 184.016 44.6178V47.4977C184.016 47.9345 183.884 48.3657 183.619 48.791C183.884 49.1819 184.016 49.6073 184.016 50.0672V52.8264C184.016 53.2518 183.912 53.6369 183.705 53.9818C183.498 54.3267 183.217 54.6084 182.86 54.8268C182.515 55.0337 182.13 55.1372 181.705 55.1372H173.979ZM174.048 53.0851H181.653C181.734 53.0851 181.803 53.0563 181.86 52.9988C181.929 52.9298 181.964 52.8494 181.964 52.7574V50.1534C181.964 50.0614 181.929 49.9867 181.86 49.9292C181.803 49.8602 181.734 49.8257 181.653 49.8257H174.048C173.956 49.8257 173.876 49.8602 173.807 49.9292C173.749 49.9867 173.72 50.0614 173.72 50.1534V52.7574C173.72 52.8494 173.749 52.9298 173.807 52.9988C173.876 53.0563 173.956 53.0851 174.048 53.0851ZM174.048 47.946H181.653C181.734 47.946 181.803 47.9173 181.86 47.8598C181.929 47.7908 181.964 47.7104 181.964 47.6184V45.1179C181.964 45.0259 181.929 44.9512 181.86 44.8937C181.803 44.8247 181.734 44.7902 181.653 44.7902H174.048C173.956 44.7902 173.876 44.8247 173.807 44.8937C173.749 44.9512 173.72 45.0259 173.72 45.1179V47.6184C173.72 47.7104 173.749 47.7908 173.807 47.8598C173.876 47.9173 173.956 47.946 174.048 47.946ZM188.068 55.1372C187.643 55.1372 187.252 55.028 186.895 54.8096C186.55 54.5796 186.275 54.2807 186.068 53.9128C185.861 53.5449 185.757 53.154 185.757 52.7402V45.0661C185.757 44.6407 185.861 44.2499 186.068 43.8935C186.275 43.5371 186.55 43.2554 186.895 43.0485C187.252 42.83 187.643 42.7208 188.068 42.7208H195.794C196.219 42.7208 196.604 42.83 196.949 43.0485C197.306 43.2554 197.587 43.5371 197.794 43.8935C198.001 44.2499 198.105 44.6407 198.105 45.0661V52.7402C198.105 53.154 198.001 53.5449 197.794 53.9128C197.587 54.2807 197.306 54.5796 196.949 54.8096C196.604 55.028 196.219 55.1372 195.794 55.1372H188.068ZM188.637 52.9816H195.742C195.823 52.9816 195.892 52.9528 195.949 52.8954C196.018 52.8264 196.052 52.7516 196.052 52.6712V46.8251L188.637 52.9816ZM187.809 50.9812L195.225 44.8247H188.137C188.045 44.8247 187.965 44.8592 187.896 44.9282C187.838 44.9856 187.809 45.0546 187.809 45.1351V50.9812Z"
          fill={speed >= 180 ? "#3DA3D9" : "white"}
        />

        <path
          d="M472.609 33.8813L559.694 44.2516C562.315 44.5638 564.643 46.0769 565.992 48.3462L615.304 131.28C616.715 133.654 616.885 136.565 615.759 139.087L573.399 233.934C572.032 236.995 568.993 238.966 565.641 238.966H472.609"
          stroke="#D7D1D1"
          strokeOpacity="0.1"
          strokeWidth="1.69933"
        />

        <path
          className="transition-all duration-500 ease-in-out"
          d="M472.227 228.905C471.802 228.905 471.411 228.796 471.055 228.577C470.71 228.347 470.434 228.048 470.227 227.68C470.02 227.312 469.916 226.922 469.916 226.508V218.834C469.916 218.408 470.02 218.017 470.227 217.661C470.434 217.305 470.71 217.023 471.055 216.816C471.411 216.598 471.802 216.488 472.227 216.488H479.953C480.378 216.488 480.764 216.598 481.108 216.816C481.465 217.023 481.747 217.305 481.954 217.661C482.16 218.017 482.264 218.408 482.264 218.834V226.508C482.264 226.922 482.16 227.312 481.954 227.68C481.747 228.048 481.465 228.347 481.108 228.577C480.764 228.796 480.378 228.905 479.953 228.905H472.227ZM472.796 226.749H479.901C479.982 226.749 480.051 226.72 480.108 226.663C480.177 226.594 480.212 226.519 480.212 226.439V220.593L472.796 226.749ZM471.969 224.749L479.384 218.592H472.296C472.204 218.592 472.124 218.627 472.055 218.696C471.997 218.753 471.969 218.822 471.969 218.903V224.749Z"
          fill={gear === 0 ? "#D08241" : "#707070"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M562.618 225.783V216.229L561.428 217.695H558.703L562.342 213.366H564.687V225.783H562.618Z"
          fill={gear === 1 ? "#D08241" : "#707070"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M587.341 139.972V135.23C587.341 134.804 587.444 134.419 587.651 134.074C587.858 133.718 588.134 133.442 588.479 133.246C588.835 133.039 589.226 132.936 589.652 132.936H597.326C597.406 132.936 597.475 132.907 597.533 132.85C597.602 132.781 597.636 132.7 597.636 132.608V129.935C597.636 129.843 597.602 129.769 597.533 129.711C597.475 129.642 597.406 129.608 597.326 129.608H589.721C589.629 129.608 589.548 129.642 589.479 129.711C589.422 129.769 589.393 129.843 589.393 129.935V130.694H587.341V129.866C587.341 129.429 587.444 129.039 587.651 128.694C587.858 128.349 588.134 128.073 588.479 127.866C588.835 127.659 589.226 127.556 589.652 127.556H597.377C597.803 127.556 598.188 127.659 598.533 127.866C598.889 128.073 599.171 128.349 599.378 128.694C599.585 129.039 599.688 129.429 599.688 129.866V132.677C599.688 133.103 599.585 133.494 599.378 133.85C599.171 134.195 598.889 134.477 598.533 134.695C598.188 134.902 597.803 135.005 597.377 135.005H589.721C589.629 135.005 589.548 135.034 589.479 135.092C589.422 135.149 589.393 135.224 589.393 135.316V137.592C589.393 137.684 589.422 137.765 589.479 137.834C589.548 137.891 589.629 137.92 589.721 137.92H599.688V139.972H587.341Z"
          fill={gear === 2 ? "#D08241" : "#707070"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M566.869 96.3674C566.432 96.3674 566.041 96.264 565.696 96.057C565.351 95.8386 565.07 95.5569 564.851 95.212C564.644 94.8671 564.541 94.482 564.541 94.0566V93.4185H566.61V93.9876C566.61 94.0796 566.639 94.1601 566.696 94.2291C566.765 94.2865 566.84 94.3153 566.921 94.3153H574.526C574.618 94.3153 574.692 94.2865 574.75 94.2291C574.819 94.1601 574.853 94.0796 574.853 93.9876V91.4181C574.853 91.3261 574.819 91.2514 574.75 91.1939C574.692 91.1364 574.618 91.1077 574.526 91.1077H566.731V89.0383H574.026C574.106 89.0383 574.175 89.0096 574.233 88.9521C574.302 88.8831 574.336 88.8084 574.336 88.7279V86.3308C574.336 86.2389 574.302 86.1641 574.233 86.1067C574.175 86.0377 574.106 86.0032 574.026 86.0032H566.921C566.84 86.0032 566.765 86.0377 566.696 86.1067C566.639 86.1641 566.61 86.2389 566.61 86.3308V87.0551H564.541V86.2619C564.541 85.825 564.644 85.4341 564.851 85.0892C565.07 84.7443 565.351 84.4684 565.696 84.2614C566.041 84.0545 566.432 83.951 566.869 83.951H574.095C574.52 83.951 574.905 84.0545 575.25 84.2614C575.606 84.4684 575.888 84.7443 576.095 85.0892C576.302 85.4341 576.405 85.825 576.405 86.2619V88.7969C576.405 88.9348 576.388 89.0785 576.354 89.228C576.331 89.3775 576.296 89.5154 576.25 89.6419C576.469 89.8833 576.63 90.1535 576.733 90.4524C576.848 90.7513 576.906 91.0502 576.906 91.3491V94.0566C576.906 94.482 576.802 94.8671 576.595 95.212C576.388 95.5569 576.106 95.8386 575.75 96.057C575.405 96.264 575.02 96.3674 574.595 96.3674H566.869Z"
          fill={gear === 3 ? "#D08241" : "#707070"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M534.976 65.4209V62.2823H526.957V60.2819L535.028 53.0045H537.028V60.2129H538.822V62.2823H537.028V65.4209H534.976ZM530.079 60.2129H534.976V56.0741L530.079 60.2129Z"
          fill={gear === 4 ? "#D08241" : "#707070"}
        />
        <path
          className="transition-all duration-500 ease-in-out"
          d="M472.261 57.771C471.836 57.771 471.445 57.6675 471.088 57.4606C470.743 57.2421 470.468 56.9605 470.261 56.6156C470.054 56.2707 469.95 55.8855 469.95 55.4602V54.7186H472.002V55.3912C472.002 55.4832 472.031 55.5636 472.089 55.6326C472.158 55.6901 472.238 55.7188 472.33 55.7188H479.935C480.016 55.7188 480.084 55.6901 480.142 55.6326C480.211 55.5636 480.245 55.4832 480.245 55.3912V52.7872C480.245 52.6952 480.211 52.6205 480.142 52.563C480.084 52.494 480.016 52.4595 479.935 52.4595H469.95V45.3546H482.298V47.4067H472.33C472.238 47.4067 472.158 47.4412 472.089 47.5102C472.031 47.5677 472.002 47.6424 472.002 47.7344V50.0625C472.002 50.1545 472.031 50.2349 472.089 50.3039C472.158 50.3614 472.238 50.3901 472.33 50.3901H479.987C480.412 50.3901 480.797 50.4936 481.142 50.7005C481.499 50.9075 481.78 51.1892 481.987 51.5455C482.194 51.8904 482.298 52.2756 482.298 52.701V55.4602C482.298 55.8855 482.194 56.2707 481.987 56.6156C481.78 56.9605 481.499 57.2421 481.142 57.4606C480.797 57.6675 480.412 57.771 479.987 57.771H472.261Z"
          fill={gear === 5 ? "#D08241" : "#707070"}
        />
        <g filter="url(#filter6_d_799_3663)">
          <mask
            id="path-406-outside-1_799_3663"
            maskUnits="userSpaceOnUse"
            x="183.833"
            y="237.829"
            width="284"
            height="35"
            fill="black"
          >
            <rect
              fill="white"
              x="183.833"
              y="237.829"
              width="284"
              height="35"
            />
            <path
              fillRule="evenodd"
              clipRule="evenodd"
              d="M348.203 238.829L305.528 238.829L289.298 254.503L241.054 254.503L184.833 272.056L467.153 272.056L414.162 254.503L364.433 254.503L348.203 238.829Z"
            />
          </mask>
          <path
            fillRule="evenodd"
            clipRule="evenodd"
            d="M348.203 238.829L305.528 238.829L289.298 254.503L241.054 254.503L184.833 272.056L467.153 272.056L414.162 254.503L364.433 254.503L348.203 238.829Z"
            fill="url(#paint16_linear_799_3663)"
            shapeRendering="crispEdges"
          />
          <path
            d="M305.528 238.829L305.528 238.467H305.382L305.277 238.568L305.528 238.829ZM348.203 238.829L348.455 238.568L348.35 238.467L348.203 238.467L348.203 238.829ZM289.298 254.503V254.865H289.445L289.55 254.764L289.298 254.503ZM241.054 254.503V254.141H240.999L240.946 254.157L241.054 254.503ZM184.833 272.056L184.725 271.71L184.833 272.418V272.056ZM467.153 272.056V272.418L467.267 271.712L467.153 272.056ZM414.162 254.503L414.276 254.159L414.22 254.141H414.162V254.503ZM364.433 254.503L364.181 254.764L364.287 254.865H364.433V254.503ZM305.528 239.191L348.203 239.191L348.203 238.467L305.528 238.467L305.528 239.191ZM289.55 254.764L305.78 239.089L305.277 238.568L289.047 254.243L289.55 254.764ZM241.054 254.865L289.298 254.865V254.141L241.054 254.141V254.865ZM184.941 272.402L241.162 254.849L240.946 254.157L184.725 271.71L184.941 272.402ZM467.153 271.694L184.833 271.694V272.418L467.153 272.418V271.694ZM414.048 254.847L467.039 272.4L467.267 271.712L414.276 254.159L414.048 254.847ZM364.433 254.865L414.162 254.865V254.141L364.433 254.141V254.865ZM347.951 239.089L364.181 254.764L364.685 254.243L348.455 238.568L347.951 239.089Z"
            fill="url(#paint17_linear_799_3663)"
            mask="url(#path-406-outside-1_799_3663)"
          />
        </g>
        <path
          d="M304.908 260.5C305.004 260.232 304.817 259.949 304.498 259.873C304.437 259.858 304.383 259.843 304.323 259.833C304.317 259.383 304.208 258.948 304.009 258.554L300.735 260.515C301.886 260.459 303.044 260.565 304.16 260.843C304.48 260.919 304.817 260.768 304.908 260.5ZM302.382 264.475C302.426 264.483 302.471 264.487 302.514 264.487C302.79 264.487 303.039 264.328 303.102 264.092L303.705 261.84C303.771 261.593 303.61 261.344 303.327 261.255C302.024 260.85 300.591 260.85 299.288 261.255C299.005 261.344 298.844 261.593 298.91 261.84L299.513 264.092C299.586 264.365 299.91 264.537 300.233 264.475C300.558 264.414 300.763 264.144 300.69 263.871L300.208 262.073C300.934 261.921 301.681 261.921 302.406 262.073L301.925 263.871C301.852 264.144 302.057 264.414 302.382 264.475ZM296.598 261.748C296.712 261.885 296.899 261.96 297.086 261.96C297.207 261.96 297.333 261.93 297.436 261.864L305.879 256.81C306.15 256.649 306.21 256.335 306.017 256.108C305.824 255.88 305.45 255.83 305.179 255.992L302.9 257.356C302.858 257.329 302.813 257.308 302.77 257.284C302.986 257.035 303.117 256.731 303.117 256.401C303.117 255.567 302.303 254.885 301.307 254.885C300.312 254.885 299.498 255.567 299.498 256.401C299.498 256.732 299.631 257.037 299.848 257.288C299.038 257.733 298.452 258.529 298.322 259.474C298.304 259.59 298.292 259.711 298.292 259.833C298.232 259.843 298.178 259.858 298.117 259.873C297.81 259.944 297.623 260.212 297.701 260.469L296.736 261.046C296.465 261.207 296.405 261.521 296.598 261.748Z"
          fill={
            Object.values(seatBelts).some((p) => p === true)
              ? "#E27837"
              : "#898989"
          }
        />
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M332.015 261.424V258.727C332.015 258.637 331.972 258.552 331.897 258.488C331.822 258.425 331.719 258.39 331.613 258.39C331.506 258.39 331.404 258.425 331.328 258.488C331.253 258.552 331.21 258.637 331.21 258.727V259.738H330.406V259.064C330.406 258.885 330.321 258.714 330.17 258.587C330.019 258.461 329.814 258.39 329.601 258.39H328.963L327.558 257.213L323.009 263.391L323.023 263.396C323.12 263.43 323.225 263.447 323.331 263.447H326.618C326.724 263.447 326.829 263.43 326.926 263.396C327.024 263.362 327.113 263.312 327.187 263.249L328.963 261.761H329.601C329.814 261.761 330.019 261.69 330.17 261.564C330.321 261.437 330.406 261.266 330.406 261.087V260.413H331.21V261.424C331.21 261.513 331.253 261.599 331.328 261.662C331.404 261.726 331.506 261.761 331.613 261.761C331.719 261.761 331.822 261.726 331.897 261.662C331.972 261.599 332.015 261.513 332.015 261.424ZM322.238 262.81L326.73 256.71C326.693 256.706 326.656 256.704 326.618 256.704H325.578V256.03H326.785C326.892 256.03 326.994 255.994 327.069 255.931C327.145 255.868 327.187 255.782 327.187 255.692C327.187 255.603 327.145 255.517 327.069 255.454C326.994 255.391 326.892 255.355 326.785 255.355H323.566C323.46 255.355 323.357 255.391 323.282 255.454C323.207 255.517 323.164 255.603 323.164 255.692C323.164 255.782 323.207 255.868 323.282 255.931C323.357 255.994 323.46 256.03 323.566 256.03H324.773V256.704H321.555C321.342 256.704 321.137 256.775 320.986 256.901C320.835 257.028 320.75 257.199 320.75 257.378V259.738H319.946V258.727C319.946 258.637 319.903 258.552 319.828 258.488C319.752 258.425 319.65 258.39 319.543 258.39C319.437 258.39 319.334 258.425 319.259 258.488C319.183 258.552 319.141 258.637 319.141 258.727V261.424C319.141 261.513 319.183 261.599 319.259 261.662C319.334 261.726 319.437 261.761 319.543 261.761C319.65 261.761 319.752 261.726 319.828 261.662C319.903 261.599 319.946 261.513 319.946 261.424V260.413H320.75V261.284C320.75 261.373 320.771 261.461 320.811 261.543C320.852 261.624 320.911 261.699 320.986 261.761L322.238 262.81Z"
          fill={settings.carSettings.engineHasProblem ? "#E27837" : "#898989"}
        />
        <path
          d="M344.3 263.393C344.325 263.522 344.458 263.618 344.615 263.618H352.744C353.173 263.618 353.593 263.479 353.884 263.214C353.955 263.149 354.02 263.078 354.082 263.004H344.226L344.3 263.393ZM344.123 262.121H354.298C354.386 262.121 354.467 262.141 354.54 262.173C354.765 261.477 354.715 260.652 354.274 259.926C354.167 259.752 354.007 259.604 353.819 259.488L349.915 257.077C348.889 256.445 347.65 256.103 346.376 256.103H343.286C343.09 256.103 342.941 256.249 342.972 256.411L344.059 262.126C344.081 262.124 344.101 262.121 344.123 262.121ZM346.438 260.588C346.438 260.637 346.391 260.677 346.332 260.677H344.786C344.728 260.677 344.68 260.637 344.68 260.588V260.381C344.68 260.332 344.728 260.292 344.786 260.292H346.333C346.391 260.292 346.438 260.332 346.438 260.381L346.438 260.588ZM346.376 256.769C347.486 256.769 348.547 257.061 349.445 257.615L351.958 259.166H344.302L343.845 256.769H346.376ZM354.298 262.33H344.123C343.97 262.33 343.845 262.434 343.845 262.563C343.845 262.691 343.97 262.796 344.123 262.796H354.298C354.451 262.796 354.576 262.691 354.576 262.563C354.576 262.434 354.451 262.33 354.298 262.33Z"
          fill={settings.carSettings.doorIsOpen ? "#E27837" : "#898989"}
        />
        <defs>
          <filter
            id="filter0_d_799_3663"
            x="292.123"
            y="53.7294"
            width="71.0037"
            height="148.332"
            filterUnits="userSpaceOnUse"
            colorInterpolationFilters="sRGB"
          >
            <feFlood floodOpacity="0" result="BackgroundImageFix" />
            <feColorMatrix
              in="SourceAlpha"
              type="matrix"
              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
              result="hardAlpha"
            />
            <feOffset />
            <feGaussianBlur stdDeviation="1.97333" />
            <feComposite in2="hardAlpha" operator="out" />
            <feColorMatrix
              type="matrix"
              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"
            />
            <feBlend
              mode="normal"
              in2="BackgroundImageFix"
              result="effect1_dropShadow_799_3663"
            />
            <feBlend
              mode="normal"
              in="SourceGraphic"
              in2="effect1_dropShadow_799_3663"
              result="shape"
            />
          </filter>
          <filter
            id="filter1_d_799_3663"
            x="16.1797"
            y="87.5937"
            width="176.362"
            height="168.024"
            filterUnits="userSpaceOnUse"
            colorInterpolationFilters="sRGB"
          >
            <feFlood floodOpacity="0" result="BackgroundImageFix" />
            <feColorMatrix
              in="SourceAlpha"
              type="matrix"
              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
              result="hardAlpha"
            />
            <feOffset />
            <feGaussianBlur stdDeviation="7.90186" />
            <feComposite in2="hardAlpha" operator="out" />
            <feColorMatrix
              type="matrix"
              values="0 0 0 0 0.235294 0 0 0 0 0.447059 0 0 0 0 0.662745 0 0 0 1 0"
            />
            <feBlend
              mode="normal"
              in2="BackgroundImageFix"
              result="effect1_dropShadow_799_3663"
            />
            <feBlend
              mode="normal"
              in="SourceGraphic"
              in2="effect1_dropShadow_799_3663"
              result="shape"
            />
          </filter>
          <filter
            id="filter2_d_799_3663"
            x="69.9676"
            y="125.285"
            width="79.6469"
            height="23.1481"
            filterUnits="userSpaceOnUse"
            colorInterpolationFilters="sRGB"
          >
            <feFlood floodOpacity="0" result="BackgroundImageFix" />
            <feColorMatrix
              in="SourceAlpha"
              type="matrix"
              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
              result="hardAlpha"
            />
            <feOffset />
            <feGaussianBlur stdDeviation="5.00694" />
            <feComposite in2="hardAlpha" operator="out" />
            <feColorMatrix
              type="matrix"
              values="0 0 0 0 0.231373 0 0 0 0 0.552941 0 0 0 0 0.662745 0 0 0 0.45 0"
            />
            <feBlend
              mode="normal"
              in2="BackgroundImageFix"
              result="effect1_dropShadow_799_3663"
            />
            <feBlend
              mode="normal"
              in="SourceGraphic"
              in2="effect1_dropShadow_799_3663"
              result="shape"
            />
          </filter>
          <filter
            id="filter3_d_799_3663"
            x="456.809"
            y="126.948"
            width="173.735"
            height="128.671"
            filterUnits="userSpaceOnUse"
            colorInterpolationFilters="sRGB"
          >
            <feFlood floodOpacity="0" result="BackgroundImageFix" />
            <feColorMatrix
              in="SourceAlpha"
              type="matrix"
              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
              result="hardAlpha"
            />
            <feOffset />
            <feGaussianBlur stdDeviation="7.90186" />
            <feComposite in2="hardAlpha" operator="out" />
            <feColorMatrix
              type="matrix"
              values="0 0 0 0 0.662745 0 0 0 0 0.34902 0 0 0 0 0.231373 0 0 0 0.99 0"
            />
            <feBlend
              mode="normal"
              in2="BackgroundImageFix"
              result="effect1_dropShadow_799_3663"
            />
            <feBlend
              mode="normal"
              in="SourceGraphic"
              in2="effect1_dropShadow_799_3663"
              result="shape"
            />
          </filter>
          <filter
            id="filter4_d_799_3663"
            x="577.485"
            y="117.699"
            width="32.0593"
            height="32.1287"
            filterUnits="userSpaceOnUse"
            colorInterpolationFilters="sRGB"
          >
            <feFlood floodOpacity="0" result="BackgroundImageFix" />
            <feColorMatrix
              in="SourceAlpha"
              type="matrix"
              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
              result="hardAlpha"
            />
            <feOffset />
            <feGaussianBlur stdDeviation="4.92804" />
            <feComposite in2="hardAlpha" operator="out" />
            <feColorMatrix
              type="matrix"
              values="0 0 0 0 0.662745 0 0 0 0 0.403922 0 0 0 0 0.231373 0 0 0 1 0"
            />
            <feBlend
              mode="normal"
              in2="BackgroundImageFix"
              result="effect1_dropShadow_799_3663"
            />
            <feBlend
              mode="normal"
              in="SourceGraphic"
              in2="effect1_dropShadow_799_3663"
              result="shape"
            />
          </filter>
          <filter
            id="filter5_d_799_3663"
            x="497.341"
            y="125.285"
            width="79.6469"
            height="23.1481"
            filterUnits="userSpaceOnUse"
            colorInterpolationFilters="sRGB"
          >
            <feFlood floodOpacity="0" result="BackgroundImageFix" />
            <feColorMatrix
              in="SourceAlpha"
              type="matrix"
              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
              result="hardAlpha"
            />
            <feOffset />
            <feGaussianBlur stdDeviation="5.00694" />
            <feComposite in2="hardAlpha" operator="out" />
            <feColorMatrix
              type="matrix"
              values="0 0 0 0 0.827451 0 0 0 0 0.501961 0 0 0 0 0.258824 0 0 0 0.45 0"
            />
            <feBlend
              mode="normal"
              in2="BackgroundImageFix"
              result="effect1_dropShadow_799_3663"
            />
            <feBlend
              mode="normal"
              in="SourceGraphic"
              in2="effect1_dropShadow_799_3663"
              result="shape"
            />
          </filter>
          <filter
            id="filter6_d_799_3663"
            x="178.929"
            y="229.772"
            width="294.135"
            height="45.5447"
            filterUnits="userSpaceOnUse"
            colorInterpolationFilters="sRGB"
          >
            <feFlood floodOpacity="0" result="BackgroundImageFix" />
            <feColorMatrix
              in="SourceAlpha"
              type="matrix"
              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
              result="hardAlpha"
            />
            <feOffset dy="-2.89827" />
            <feGaussianBlur stdDeviation="2.89827" />
            <feComposite in2="hardAlpha" operator="out" />
            <feColorMatrix
              type="matrix"
              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.16 0"
            />
            <feBlend
              mode="normal"
              in2="BackgroundImageFix"
              result="effect1_dropShadow_799_3663"
            />
            <feBlend
              mode="normal"
              in="SourceGraphic"
              in2="effect1_dropShadow_799_3663"
              result="shape"
            />
          </filter>
          <linearGradient
            id="paint0_linear_799_3663"
            x1="63.3889"
            y1="135.153"
            x2="654.846"
            y2="135.153"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="#060606" />
            <stop offset="0.463058" stopColor="#0C0C0C" />
            <stop offset="1" stopColor="#060606" />
          </linearGradient>
          <radialGradient
            id="paint1_radial_799_3663"
            cx="0"
            cy="0"
            r="1"
            gradientUnits="userSpaceOnUse"
            gradientTransform="translate(323.937 150.546) rotate(90) scale(90.3177 88.2194)"
          >
            <stop stopColor="white" />
            <stop offset="1" stopColor="white" stopOpacity="0" />
          </radialGradient>
          <radialGradient
            id="paint2_radial_799_3663"
            cx="0"
            cy="0"
            r="1"
            gradientUnits="userSpaceOnUse"
            gradientTransform="translate(325.769 150.373) rotate(90) scale(73.3831 71.6783)"
          >
            <stop stopColor="white" />
            <stop offset="1" stopColor="white" stopOpacity="0" />
          </radialGradient>
          <radialGradient
            id="paint3_radial_799_3663"
            cx="0"
            cy="0"
            r="1"
            gradientUnits="userSpaceOnUse"
            gradientTransform="translate(327.462 149.894) rotate(90) scale(65.7815 65.771)"
          >
            <stop stopColor="white" />
            <stop offset="1" stopColor="white" stopOpacity="0" />
          </radialGradient>
          <linearGradient
            id="paint4_linear_799_3663"
            x1="378.916"
            y1="151.573"
            x2="283.185"
            y2="151.573"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="#E27538" />
            <stop offset="1" stopColor="#E29E38" />
          </linearGradient>
          <radialGradient
            id="paint5_radial_799_3663"
            cx="0"
            cy="0"
            r="1"
            gradientUnits="userSpaceOnUse"
            gradientTransform="translate(327.625 127.895) rotate(41.0065) scale(181.738 69.6397)"
          >
            <stop stopColor="#1D1D1D" />
            <stop offset="1" />
          </radialGradient>
          <linearGradient
            id="paint6_linear_799_3663"
            x1="301.173"
            y1="59.5368"
            x2="349.365"
            y2="186.21"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="#CECECE" stopOpacity="0.76" />
            <stop offset="0.25" stopColor="#838383" stopOpacity="0.53" />
            <stop
              offset="0.484375"
              stopColor="#C4C4C4"
              stopOpacity="0.515625"
            />
            <stop offset="0.677083" stopColor="#E1E1E1" stopOpacity="0.6" />
            <stop offset="0.854167" stopColor="#CFCFCF" stopOpacity="0.23" />
            <stop offset="1" stopColor="#CFCFCF" stopOpacity="0.63" />
          </linearGradient>
          <linearGradient
            id="paint7_linear_799_3663"
            x1="337.801"
            y1="102.451"
            x2="357.85"
            y2="138.195"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="white" />
            <stop offset="0.182292" stopColor="white" stopOpacity="0.51" />
            <stop offset="0.546875" stopColor="white" />
            <stop offset="0.786458" stopColor="white" stopOpacity="0.44" />
            <stop offset="0.994792" stopColor="white" />
          </linearGradient>
          <linearGradient
            id="paint8_linear_799_3663"
            x1="283.536"
            y1="100.575"
            x2="303.733"
            y2="139.644"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="white" />
            <stop offset="0.182292" stopColor="white" stopOpacity="0.51" />
            <stop offset="0.546875" stopColor="white" />
            <stop offset="0.786458" stopColor="white" stopOpacity="0.44" />
            <stop offset="0.994792" stopColor="white" />
          </linearGradient>
          <linearGradient
            id="paint9_linear_799_3663"
            x1="284.758"
            y1="74.3104"
            x2="349.728"
            y2="201.302"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="white" stopOpacity="0.31" />
            <stop offset="0.291667" stopColor="white" />
            <stop offset="0.536458" stopColor="white" stopOpacity="0.26" />
            <stop offset="0.770833" stopColor="white" />
            <stop offset="1" stopColor="white" stopOpacity="0.25" />
          </linearGradient>
          <linearGradient
            id="paint10_linear_799_3663"
            x1="285.708"
            y1="132.702"
            x2="301.213"
            y2="170.913"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="white" />
            <stop offset="0.182292" stopColor="white" stopOpacity="0.51" />
            <stop offset="0.546875" stopColor="white" />
            <stop offset="0.786458" stopColor="white" stopOpacity="0.44" />
            <stop offset="0.994792" stopColor="white" />
          </linearGradient>
          <linearGradient
            id="paint11_linear_799_3663"
            x1="344.446"
            y1="130.357"
            x2="357.332"
            y2="169.14"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="white" />
            <stop offset="0.182292" stopColor="white" stopOpacity="0.51" />
            <stop offset="0.546875" stopColor="white" />
            <stop offset="0.786458" stopColor="white" stopOpacity="0.44" />
            <stop offset="0.994792" stopColor="white" />
          </linearGradient>
          <linearGradient
            id="paint12_linear_799_3663"
            x1="42.5735"
            y1="107.992"
            x2="207.76"
            y2="205.008"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="#3A8EA9" />
            <stop offset="1" stopColor="#3D3AA9" />
          </linearGradient>
          <linearGradient
            id="paint13_linear_799_3663"
            x1="136.495"
            y1="137.379"
            x2="85.2464"
            y2="138.41"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="#3E77A7" />
            <stop offset="1" stopColor="#3B8DA9" />
          </linearGradient>
          <linearGradient
            id="paint14_linear_799_3663"
            x1="606.777"
            y1="107.993"
            x2="441.59"
            y2="205.01"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="#A96F3A" />
            <stop offset="1" stopColor="#A9513A" />
          </linearGradient>
          <linearGradient
            id="paint15_linear_799_3663"
            x1="510.461"
            y1="137.379"
            x2="561.709"
            y2="138.41"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="#A96A3B" />
            <stop offset="1" stopColor="#F89347" />
          </linearGradient>
          <linearGradient
            id="paint16_linear_799_3663"
            x1="325.993"
            y1="237.039"
            x2="325.919"
            y2="272.994"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="#0C0C0C" />
            <stop offset="1" stopColor="#060606" />
          </linearGradient>
          <linearGradient
            id="paint17_linear_799_3663"
            x1="325.993"
            y1="274.681"
            x2="325.993"
            y2="238.186"
            gradientUnits="userSpaceOnUse"
          >
            <stop stopColor="#BBBBBB" stopOpacity="0" />
            <stop offset="1" stopColor="#787878" />
          </linearGradient>
        </defs>
      </svg>
    </div>
  );
};

export default SpeedoMeter10;
