import { useState, useEffect } from "react";
import { useSettings } from "../../../contexts/SettingsContext";

const defaultVisibilityThresholds = {
  health: 100,
  thirst: 100,
  hunger: 100,
  energy: 100,
  armor: 100,
  stress: 100,
};

export const Status10 = () => (
  <svg
    width="300"
    height="86"
    viewBox="0 0 300 86"
    fill="none"
    xmlns="http://www.w3.org/2000/svg"
  >
    <rect
      x="185.006"
      y="34.8689"
      width="93.9123"
      height="3.79444"
      rx="0.948609"
      fill="#5FBCFF"
      fillOpacity="0.41"
    />
    <g filter="url(#filter0_d_800_3672)">
      <rect
        x="245.716"
        y="34.8689"
        width="33.2013"
        height="3.79444"
        rx="0.948609"
        fill="#5FBCFF"
      />
    </g>
    <rect
      width="93.9123"
      height="3.79444"
      rx="0.948609"
      transform="matrix(-1 0 0 1 114.809 34.8695)"
      fill="#FF5F98"
      fillOpacity="0.41"
    />
    <g filter="url(#filter1_d_800_3672)">
      <rect
        width="33.2013"
        height="3.79444"
        rx="0.948609"
        transform="matrix(-1 0 0 1 54.0978 34.8695)"
        fill="#FF5F98"
      />
    </g>
    <circle
      cx="263.475"
      cy="61.777"
      r="15.5244"
      fill="#33FF85"
      fillOpacity="0.08"
    />
    <path
      d="M277.382 61.7768C277.382 69.4576 271.155 75.6841 263.474 75.6841C255.794 75.6841 249.567 69.4576 249.567 61.7768C249.567 54.096 255.794 47.8695 263.474 47.8695C271.155 47.8695 277.382 54.096 277.382 61.7768ZM251.541 61.7768C251.541 68.3677 256.883 73.7106 263.474 73.7106C270.065 73.7106 275.408 68.3677 275.408 61.7768C275.408 55.186 270.065 49.8431 263.474 49.8431C256.883 49.8431 251.541 55.186 251.541 61.7768Z"
      fill="#33FF85"
      fillOpacity="0.14"
    />
    <g filter="url(#filter2_d_800_3672)">
      <path
        d="M277.382 61.7768C277.382 59.6513 276.894 57.5541 275.958 55.6463C275.021 53.7385 273.659 52.0708 271.977 50.7713C270.295 49.4719 268.337 48.5752 266.255 48.1503C264.172 47.7253 262.02 47.7834 259.963 48.32L260.462 50.2296C262.226 49.7692 264.073 49.7194 265.86 50.084C267.647 50.4486 269.327 51.218 270.77 52.3331C272.214 53.4481 273.382 54.8792 274.186 56.5163C274.99 58.1534 275.408 59.953 275.408 61.7768H277.382Z"
        fill="#33FF85"
      />
    </g>
    <path
      d="M263.165 67.861C263.098 67.8609 263.032 67.8493 262.969 67.8265C262.849 67.7823 262.746 67.6988 262.678 67.5894C262.611 67.48 262.582 67.351 262.596 67.2232L263.038 63.1491H259.654C259.549 63.1492 259.447 63.1209 259.357 63.0672C259.268 63.0136 259.195 62.9365 259.146 62.8443C259.097 62.7522 259.074 62.6484 259.079 62.5442C259.085 62.4399 259.118 62.3391 259.177 62.2526L263.711 55.472C263.782 55.3659 263.887 55.2868 264.009 55.2472C264.131 55.2077 264.263 55.2099 264.383 55.2536C264.499 55.2966 264.598 55.3757 264.665 55.4792C264.732 55.5827 264.764 55.7051 264.756 55.8283L264.314 59.9311H267.699C267.803 59.931 267.905 59.9593 267.995 60.0129C268.085 60.0666 268.158 60.1437 268.207 60.2359C268.256 60.328 268.279 60.4318 268.273 60.536C268.268 60.6403 268.234 60.7411 268.176 60.8276L263.642 67.6082C263.589 67.6862 263.518 67.75 263.435 67.7941C263.352 67.8382 263.259 67.8612 263.165 67.861Z"
      fill="#33FF85"
    />
    <circle
      cx="74.526"
      cy="62.6783"
      r="15.524"
      fill="#33DAFF"
      fillOpacity="0.08"
    />
    <path
      d="M88.4323 62.6777C88.4323 70.3582 82.2059 76.5846 74.5254 76.5846C66.8448 76.5846 60.6185 70.3582 60.6185 62.6777C60.6185 54.9971 66.8448 48.7708 74.5254 48.7708C82.2059 48.7708 88.4323 54.9971 88.4323 62.6777ZM62.592 62.6777C62.592 69.2683 67.9347 74.6111 74.5254 74.6111C81.116 74.6111 86.4588 69.2683 86.4588 62.6777C86.4588 56.087 81.116 50.7442 74.5254 50.7442C67.9347 50.7442 62.592 56.087 62.592 62.6777Z"
      fill="#33DAFF"
      fillOpacity="0.14"
    />
    <g filter="url(#filter3_d_800_3672)">
      <path
        d="M88.4323 62.6777C88.4323 60.5522 87.9451 58.4551 87.0082 56.5473C86.0713 54.6395 84.7096 52.9719 83.0276 51.6725C81.3457 50.3731 79.3883 49.4765 77.3057 49.0515C75.2232 48.6266 73.071 48.6846 71.0145 49.2212L71.5127 51.1308C73.2774 50.6704 75.1242 50.6205 76.9112 50.9852C78.6982 51.3498 80.3778 52.1192 81.8211 53.2342C83.2643 54.3492 84.4328 55.7802 85.2368 57.4173C86.0407 59.0543 86.4588 60.8538 86.4588 62.6777H88.4323Z"
        fill="#33DAFF"
      />
    </g>
    <path
      d="M69.4023 60.7558C69.3195 60.6539 69.2605 60.5346 69.2298 60.4068C69.1991 60.2791 69.1974 60.146 69.2249 60.0175C69.6331 58.0882 71.8425 56.6874 74.4794 56.6874C77.1163 56.6874 79.3258 58.0882 79.7339 60.0175C79.7617 60.1461 79.7603 60.2793 79.7297 60.4073C79.6992 60.5353 79.6403 60.6547 79.5574 60.7569C79.4745 60.8591 79.3698 60.9414 79.2509 60.9977C79.1319 61.0539 79.0019 61.0828 78.8703 61.0822L70.0885 61.0822C69.957 61.0826 69.8271 61.0534 69.7083 60.997C69.5896 60.9405 69.485 60.8581 69.4023 60.7558ZM80.0421 63.7454L77.7826 64.5694L75.7429 63.7503C75.6382 63.7085 75.5213 63.7085 75.4166 63.7503L73.384 64.5639L71.3481 63.7503C71.2479 63.7103 71.1364 63.7085 71.035 63.7454L68.6179 64.6243C68.5157 64.6693 68.4345 64.7515 68.3907 64.8541C68.3469 64.9568 68.3438 65.0723 68.382 65.1771C68.4203 65.282 68.497 65.3684 68.5966 65.4188C68.6962 65.4691 68.8112 65.4797 68.9184 65.4484L69.6452 65.1852L69.6452 65.4769C69.6452 66.0597 69.8767 66.6186 70.2888 67.0307C70.7008 67.4428 71.2598 67.6743 71.8425 67.6743L77.1163 67.6743C77.6991 67.6743 78.258 67.4428 78.6701 67.0307C79.0822 66.6186 79.3137 66.0597 79.3137 65.4769L79.3137 64.9457L80.3426 64.5716C80.4003 64.5547 80.4539 64.5262 80.5001 64.4877C80.5464 64.4493 80.5842 64.4018 80.6113 64.3482C80.6385 64.2945 80.6543 64.2359 80.6579 64.1759C80.6614 64.1158 80.6526 64.0557 80.632 63.9993C80.6114 63.9428 80.5795 63.8911 80.5381 63.8475C80.4968 63.8039 80.4469 63.7692 80.3916 63.7456C80.3363 63.722 80.2768 63.71 80.2166 63.7104C80.1565 63.7107 80.0971 63.7234 80.0421 63.7476L80.0421 63.7454ZM68.7662 62.8401L80.1926 62.8401C80.3092 62.8401 80.421 62.7938 80.5034 62.7113C80.5858 62.6289 80.6321 62.5171 80.6321 62.4006C80.6321 62.284 80.5858 62.1723 80.5034 62.0898C80.421 62.0074 80.3092 61.9611 80.1926 61.9611L68.7662 61.9611C68.6496 61.9611 68.5379 62.0074 68.4554 62.0898C68.373 62.1723 68.3267 62.284 68.3267 62.4006C68.3267 62.5171 68.373 62.6289 68.4554 62.7113C68.5379 62.7938 68.6496 62.8401 68.7662 62.8401Z"
      fill="#33DAFF"
    />
    <circle
      cx="223.297"
      cy="61.777"
      r="15.5244"
      fill="#FFE24D"
      fillOpacity="0.08"
    />
    <path
      d="M237.204 61.7768C237.204 69.4576 230.977 75.6841 223.296 75.6841C215.616 75.6841 209.389 69.4576 209.389 61.7768C209.389 54.096 215.616 47.8695 223.296 47.8695C230.977 47.8695 237.204 54.096 237.204 61.7768ZM211.363 61.7768C211.363 68.3677 216.706 73.7106 223.296 73.7106C229.887 73.7106 235.23 68.3677 235.23 61.7768C235.23 55.186 229.887 49.8431 223.296 49.8431C216.706 49.8431 211.363 55.186 211.363 61.7768Z"
      fill="#FFE24D"
      fillOpacity="0.14"
    />
    <g filter="url(#filter4_d_800_3672)">
      <path
        d="M237.204 61.7768C237.204 59.6513 236.716 57.5541 235.78 55.6463C234.843 53.7385 233.481 52.0708 231.799 50.7713C230.117 49.4719 228.159 48.5752 226.077 48.1503C223.994 47.7253 221.842 47.7834 219.785 48.32L220.284 50.2296C222.048 49.7692 223.895 49.7194 225.682 50.084C227.469 50.4486 229.149 51.218 230.592 52.3331C232.036 53.4481 233.204 54.8792 234.008 56.5163C234.812 58.1534 235.23 59.953 235.23 61.7768H237.204Z"
        fill="#FFE24D"
      />
    </g>
    <path
      d="M222.951 67.438C225.56 67.438 227.694 65.3037 227.694 62.695C227.694 60.0863 222.951 54.7899 222.951 54.7899C222.951 54.7899 218.208 60.1654 218.208 62.695C218.208 65.2246 220.342 67.438 222.951 67.438Z"
      fill="#FFE24D"
    />
    <g filter="url(#filter5_d_800_3672)">
      <circle
        cx="149.405"
        cy="37.2128"
        r="18.3224"
        fill="white"
        fillOpacity="0.08"
      />
      <g filter="url(#filter6_d_800_3672)">
        <path
          d="M162.764 27.6762C161.16 25.4286 159.014 23.6221 156.526 22.4239C154.038 21.2258 151.288 20.6748 148.53 20.8219L148.634 22.7603C151.065 22.6306 153.49 23.1164 155.684 24.1729C157.878 25.2293 159.77 26.8222 161.184 28.804L162.764 27.6762Z"
          fill="white"
        />
      </g>
      <g filter="url(#filter7_d_800_3672)">
        <path
          d="M143.651 21.8406C141.064 22.8086 138.764 24.4135 136.963 26.5067C135.162 28.5999 133.918 31.1137 133.346 33.8154L135.102 34.187C135.611 31.7808 136.719 29.542 138.324 27.6777C139.928 25.8135 141.977 24.3842 144.28 23.522L143.651 21.8406Z"
          fill="white"
        />
      </g>
      <g filter="url(#filter8_d_800_3672)">
        <path
          d="M133.068 38.792C133.333 41.5407 134.288 44.1779 135.844 46.4595C137.4 48.7412 139.506 50.5934 141.967 51.8448L142.485 50.8265C140.195 49.6622 138.235 47.9389 136.788 45.816C135.34 43.6932 134.452 41.2395 134.205 38.6821L133.068 38.792Z"
          fill="white"
          fillOpacity="0.28"
          shapeRendering="crispEdges"
        />
      </g>
      <g filter="url(#filter9_d_800_3672)">
        <path
          d="M146.702 53.4023C149.426 53.8571 152.221 53.6174 154.827 52.7053C157.434 51.7932 159.768 50.2382 161.614 48.1842L160.764 47.4207C159.047 49.3316 156.875 50.7784 154.45 51.6271C152.025 52.4757 149.425 52.6988 146.891 52.2756L146.702 53.4023Z"
          fill="white"
          fillOpacity="0.28"
          shapeRendering="crispEdges"
        />
      </g>
      <g filter="url(#filter10_d_800_3672)">
        <path
          d="M163.233 46.0537C164.721 43.7271 165.597 41.0628 165.781 38.3074C165.966 35.5521 165.452 32.7948 164.287 30.2908L163.251 30.7725C164.335 33.1022 164.813 35.6676 164.642 38.2312C164.47 40.7948 163.655 43.2737 162.271 45.4384L163.233 46.0537Z"
          fill="white"
          fillOpacity="0.28"
          shapeRendering="crispEdges"
        />
      </g>
      <g filter="url(#filter11_d_800_3672)">
        <path
          d="M149.556 40.345C151.143 40.345 152.435 39.0297 152.435 37.4139V33.0172C152.435 31.4007 151.143 30.0861 149.556 30.0861C147.968 30.0861 146.677 31.4007 146.677 33.0172V37.4139C146.677 39.0297 147.968 40.345 149.556 40.345ZM154.594 37.4139V35.9483C154.594 35.754 154.518 35.5676 154.383 35.4302C154.248 35.2928 154.065 35.2155 153.874 35.2155C153.683 35.2155 153.5 35.2928 153.365 35.4302C153.23 35.5676 153.154 35.754 153.154 35.9483V37.4139C153.154 39.4342 151.54 41.0778 149.556 41.0778C147.572 41.0778 145.957 39.4342 145.957 37.4139V35.9483C145.957 35.754 145.881 35.5676 145.746 35.4302C145.612 35.2928 145.428 35.2155 145.238 35.2155C145.047 35.2155 144.864 35.2928 144.729 35.4302C144.594 35.5676 144.518 35.754 144.518 35.9483V37.4139C144.518 39.9933 146.398 42.1272 148.836 42.4848V43.2762H146.677C146.486 43.2762 146.303 43.3534 146.168 43.4908C146.033 43.6282 145.957 43.8146 145.957 44.009C145.957 44.2033 146.033 44.3897 146.168 44.5271C146.303 44.6645 146.486 44.7417 146.677 44.7417H152.435C152.625 44.7417 152.809 44.6645 152.943 44.5271C153.078 44.3897 153.154 44.2033 153.154 44.009C153.154 43.8146 153.078 43.6282 152.943 43.4908C152.809 43.3534 152.625 43.2762 152.435 43.2762H150.275V42.4848C152.713 42.1272 154.594 39.9933 154.594 37.4139Z"
          fill="white"
        />
      </g>
    </g>
    <circle
      cx="34.524"
      cy="62.6783"
      r="15.524"
      fill="#C85D70"
      fillOpacity="0.08"
    />
    <path
      d="M48.4303 62.6777C48.4303 70.3582 42.2039 76.5846 34.5234 76.5846C26.8428 76.5846 20.6165 70.3582 20.6165 62.6777C20.6165 54.9971 26.8428 48.7708 34.5234 48.7708C42.2039 48.7708 48.4303 54.9971 48.4303 62.6777ZM22.5899 62.6777C22.5899 69.2683 27.9327 74.6111 34.5234 74.6111C41.114 74.6111 46.4568 69.2683 46.4568 62.6777C46.4568 56.087 41.114 50.7442 34.5234 50.7442C27.9327 50.7442 22.5899 56.087 22.5899 62.6777Z"
      fill="#FF3357"
      fillOpacity="0.439216"
    />
    <g filter="url(#filter12_d_800_3672)">
      <path
        d="M47.62 62.77C47.62 69.9497 41.7997 75.77 34.62 75.77C27.4403 75.77 21.62 69.9497 21.62 62.77C21.62 55.5903 27.4403 49.77 34.62 49.77C41.7997 49.77 47.62 55.5903 47.62 62.77ZM22.4247 62.77C22.4247 69.5053 27.8847 74.9653 34.62 74.9653C41.3553 74.9653 46.8153 69.5053 46.8153 62.77C46.8153 56.0347 41.3553 50.5747 34.62 50.5747C27.8847 50.5747 22.4247 56.0347 22.4247 62.77Z"
        fill="#FF3357"
      />
    </g>
    <path
      d="M39.1162 60.1875V59.9749C39.1156 59.5142 38.979 59.0639 38.7234 58.6805C38.4679 58.2971 38.1048 57.9977 37.6797 57.82C37.2547 57.6422 36.7866 57.5939 36.3342 57.6812C35.8818 57.7685 35.4652 57.9874 35.1368 58.3106C35.1174 58.3301 35.102 58.3534 35.0916 58.3789C35.0812 58.4045 35.076 58.4318 35.0762 58.4594V63.1755C35.0763 63.2138 35.0868 63.2514 35.1065 63.2843C35.1262 63.3172 35.1545 63.3441 35.1882 63.3623C35.222 63.3804 35.2601 63.3891 35.2983 63.3874C35.3366 63.3856 35.3738 63.3736 35.4058 63.3525C35.8102 63.0932 36.2799 62.9542 36.7602 62.9517C36.8714 62.9496 36.9792 62.9903 37.0613 63.0652C37.1435 63.1402 37.1938 63.2437 37.202 63.3546C37.205 63.4123 37.1962 63.47 37.1762 63.5242C37.1562 63.5784 37.1254 63.628 37.0856 63.6699C37.0458 63.7118 36.9979 63.7451 36.9448 63.7679C36.8917 63.7906 36.8345 63.8023 36.7767 63.8022C36.3256 63.8022 35.8929 63.9814 35.5739 64.3004C35.2549 64.6195 35.0757 65.0521 35.0757 65.5033V67.3042C35.0756 67.336 35.0827 67.3675 35.0964 67.3962C35.1101 67.4249 35.1301 67.4501 35.1549 67.4701C35.4567 67.7198 35.8119 67.8966 36.1932 67.9867C36.5744 68.0768 36.9712 68.0777 37.3528 67.9895C37.7345 67.9012 38.0906 67.7262 38.3936 67.4779C38.6966 67.2296 38.9382 66.9148 39.0997 66.5579C39.1159 66.522 39.1219 66.4823 39.1169 66.4432C39.1119 66.4042 39.0962 66.3672 39.0714 66.3366C39.0467 66.3059 39.0139 66.2827 38.9767 66.2696C38.9396 66.2565 38.8995 66.254 38.861 66.2623C38.596 66.3231 38.3249 66.3538 38.053 66.3538H37.6421C37.5324 66.3551 37.4262 66.315 37.3449 66.2413C37.2636 66.1677 37.2131 66.066 37.2036 65.9567C37.1997 65.8985 37.2078 65.8402 37.2275 65.7853C37.2471 65.7304 37.2778 65.6801 37.3177 65.6376C37.3576 65.5951 37.4058 65.5612 37.4593 65.5381C37.5128 65.515 37.5705 65.5031 37.6288 65.5033H38.0541C38.4984 65.5039 38.9362 65.3967 39.3299 65.1907C39.7961 64.9479 40.1834 64.5772 40.4464 64.1221C40.7093 63.667 40.8371 63.1463 40.8147 62.6211C40.7923 62.096 40.6206 61.5881 40.3197 61.1571C40.0189 60.726 39.6014 60.3897 39.1162 60.1875ZM38.4783 62.1012H38.2656C37.7581 62.1012 37.2714 61.8996 36.9125 61.5407C36.5536 61.1818 36.352 60.6951 36.352 60.1875V59.9749C36.352 59.8621 36.3968 59.754 36.4765 59.6742C36.5563 59.5945 36.6645 59.5496 36.7772 59.5496C36.89 59.5496 36.9982 59.5945 37.0779 59.6742C37.1577 59.754 37.2025 59.8621 37.2025 59.9749V60.1875C37.2025 60.3271 37.23 60.4654 37.2834 60.5944C37.3369 60.7234 37.4152 60.8406 37.5139 60.9393C37.7133 61.1387 37.9837 61.2507 38.2656 61.2507H38.4783C38.5911 61.2507 38.6992 61.2955 38.779 61.3752C38.8587 61.455 38.9035 61.5632 38.9035 61.6759C38.9035 61.7887 38.8587 61.8969 38.779 61.9766C38.6992 62.0564 38.5911 62.1012 38.4783 62.1012ZM32.5247 57.636C31.9046 57.6367 31.3101 57.8833 30.8716 58.3218C30.4331 58.7603 30.1864 59.3548 30.1857 59.9749V60.1875C29.7006 60.3898 29.2832 60.7262 28.9824 61.1573C28.6817 61.5884 28.5101 62.0963 28.4878 62.6215C28.4655 63.1466 28.5933 63.6673 28.8564 64.1223C29.1195 64.5774 29.5069 64.948 29.9731 65.1907C30.3668 65.3967 30.8046 65.5039 31.2489 65.5033H31.6598C31.7697 65.5016 31.8761 65.5417 31.9577 65.6154C32.0392 65.689 32.0899 65.7909 32.0994 65.9003C32.1033 65.9585 32.0951 66.0169 32.0755 66.0718C32.0559 66.1266 32.0251 66.1769 31.9853 66.2194C31.9454 66.262 31.8972 66.2958 31.8437 66.3189C31.7901 66.342 31.7324 66.3539 31.6741 66.3538H31.2489C30.9768 66.3539 30.7055 66.323 30.4404 66.2618C30.4019 66.2534 30.3618 66.2559 30.3247 66.2689C30.2875 66.282 30.2547 66.3051 30.2299 66.3356C30.2051 66.3662 30.1893 66.4031 30.1842 66.4422C30.1791 66.4812 30.185 66.5209 30.2012 66.5568C30.3626 66.9138 30.6042 67.2287 30.9072 67.4771C31.2101 67.7255 31.5663 67.9007 31.948 67.989C32.3297 68.0774 32.7266 68.0765 33.1079 67.9865C33.4892 67.8965 33.8446 67.7198 34.1465 67.4701C34.1713 67.4501 34.1912 67.4249 34.2049 67.3962C34.2186 67.3675 34.2257 67.336 34.2257 67.3042V65.5033C34.2257 65.0521 34.0465 64.6195 33.7275 64.3004C33.4085 63.9814 32.9758 63.8022 32.5247 63.8022C32.4669 63.8023 32.4097 63.7906 32.3566 63.7679C32.3035 63.7451 32.2556 63.7118 32.2158 63.6699C32.176 63.628 32.1451 63.5784 32.1251 63.5242C32.1051 63.47 32.0964 63.4123 32.0994 63.3546C32.1075 63.2436 32.1579 63.14 32.2402 63.065C32.3225 62.9901 32.4304 62.9495 32.5417 62.9517C33.022 62.9542 33.4918 63.0932 33.8961 63.3525C33.9281 63.3736 33.9653 63.3856 34.0036 63.3874C34.0419 63.3891 34.0799 63.3804 34.1137 63.3623C34.1474 63.3441 34.1757 63.3172 34.1954 63.2843C34.2151 63.2514 34.2256 63.2138 34.2257 63.1755V58.4594C34.2259 58.4036 34.2041 58.3499 34.1651 58.31C33.7285 57.878 33.1389 57.6357 32.5247 57.636ZM32.9499 60.1875C32.9499 60.6951 32.7483 61.1818 32.3894 61.5407C32.0305 61.8996 31.5438 62.1012 31.0363 62.1012H30.8236C30.7108 62.1012 30.6027 62.0564 30.5229 61.9766C30.4432 61.8969 30.3984 61.7887 30.3984 61.6759C30.3984 61.5632 30.4432 61.455 30.5229 61.3752C30.6027 61.2955 30.7108 61.2507 30.8236 61.2507H31.0363C31.1759 61.2507 31.3141 61.2232 31.4431 61.1698C31.5721 61.1163 31.6893 61.038 31.788 60.9393C31.8867 60.8406 31.965 60.7234 32.0185 60.5944C32.0719 60.4654 32.0994 60.3271 32.0994 60.1875V59.9749C32.0994 59.8621 32.1442 59.754 32.224 59.6742C32.3037 59.5945 32.4119 59.5496 32.5247 59.5496C32.6374 59.5496 32.7456 59.5945 32.8254 59.6742C32.9051 59.754 32.9499 59.8621 32.9499 59.9749V60.1875Z"
      fill="#FF3357"
    />
    <defs>
      <filter
        id="filter0_d_800_3672"
        x="225.226"
        y="14.3789"
        width="74.1812"
        height="44.7743"
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
        <feMorphology
          radius="2.84583"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="8.82206" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 0.372549 0 0 0 0 0.737255 0 0 0 0 1 0 0 0 0.47 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter1_d_800_3672"
        x="0.406596"
        y="14.3796"
        width="74.1812"
        height="44.7743"
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
        <feMorphology
          radius="2.84583"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="8.82206" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 0.372549 0 0 0 0 0.596078 0 0 0 0.47 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter2_d_800_3672"
        x="249.771"
        y="37.6769"
        width="37.8035"
        height="34.2926"
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
        <feMorphology
          radius="2.12346"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="4.03457" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 0.498039 0 0 0 0 0.364706 0 0 0 0 0.784314 0 0 0 0.91 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter3_d_800_3672"
        x="61.4138"
        y="39.1701"
        width="36.6191"
        height="33.1082"
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
        <feMorphology
          radius="2.00014"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="3.80026" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 0.2 0 0 0 0 0.854902 0 0 0 0 1 0 0 0 0.91 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter4_d_800_3672"
        x="209.593"
        y="37.6769"
        width="37.8035"
        height="34.2926"
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
        <feMorphology
          radius="2.12346"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="4.03457" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 0.886275 0 0 0 0 0.301961 0 0 0 0.91 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter5_d_800_3672"
        x="113.164"
        y="0.97139"
        width="72.4828"
        height="72.4828"
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
        <feGaussianBlur stdDeviation="8.9595" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.11 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter6_d_800_3672"
        x="136.501"
        y="8.76905"
        width="38.2928"
        height="32.0644"
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
        <feMorphology
          radius="2.50615"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="4.76169" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.21 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter7_d_800_3672"
        x="121.316"
        y="9.81104"
        width="34.9931"
        height="36.4055"
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
        <feMorphology
          radius="2.50615"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="4.76169" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.21 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter8_d_800_3672"
        x="121.038"
        y="26.6526"
        width="33.4764"
        height="37.2218"
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
        <feMorphology
          radius="2.50615"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="4.76169" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.21 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter9_d_800_3672"
        x="134.673"
        y="35.3911"
        width="38.9706"
        height="30.2649"
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
        <feMorphology
          radius="2.50615"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="4.76169" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.21 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter10_d_800_3672"
        x="150.241"
        y="18.2612"
        width="27.6064"
        height="39.822"
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
        <feMorphology
          radius="2.50615"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="4.76169" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.21 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter11_d_800_3672"
        x="138.544"
        y="24.1124"
        width="22.0232"
        height="26.603"
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
        <feGaussianBlur stdDeviation="2.98685" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.4 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
      <filter
        id="filter12_d_800_3672"
        x="12.0193"
        y="40.1694"
        width="45.2013"
        height="45.2013"
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
        <feMorphology
          radius="2.00014"
          operator="dilate"
          in="SourceAlpha"
          result="effect1_dropShadow_800_3672"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="3.80026" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 0.2 0 0 0 0 0.341176 0 0 0 0.91 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_800_3672"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_800_3672"
          result="shape"
        />
      </filter>
    </defs>
  </svg>
);

const Status10Edit = () => {
  const { settings, updateSettings, openSettings, setOpenSettings } =
    useSettings();
  const [visibilityThresholds, setVisibilityThresholds] = useState(
    defaultVisibilityThresholds
  );

  useEffect(() => {
    if (openSettings) {
      const currentThresholds =
        settings.styleVisibility[openSettings]?.visibilityThresholds ||
        defaultVisibilityThresholds;
      setVisibilityThresholds(currentThresholds);
    }
  }, [openSettings, setVisibilityThresholds, settings.styleVisibility]);

  const handleChange = (field, value) => {
    setVisibilityThresholds((prev) => ({ ...prev, [field]: value }));
  };

  const handleSave = () => {
    const updatedVisibilitySettings = {
      ...settings.styleVisibility,
      [openSettings + 1]: {
        visibilityThresholds: { ...visibilityThresholds },
      },
    };
    updateSettings("styleVisibility", updatedVisibilitySettings);
  };

  const handleRestore = () => {
    setVisibilityThresholds(defaultVisibilityThresholds);
  };

  const handleCancel = () => {
    const currentThresholds =
      settings.styleVisibility[openSettings + 1]?.visibilityThresholds ||
      defaultVisibilityThresholds;
    setVisibilityThresholds(currentThresholds);
    setOpenSettings(null);
  };

  if (!openSettings) return null;

  return (
    <div className="w-full flex flex-col justify-between items-center h-[230px] p-4 bg-gradient-to-r from-zinc-800 to-neutral-800 rounded border border-white border-opacity-20">
      <div className="flex items-start w-full justify-between">
        <div className="flex flex-col gap-y-1 items-start justify-start">
          <div className="text-center text-neutral-400 text-base font-semibold font-['Qanelas Soft']">
            {settings.language.statusStyleType} Settings #1
          </div>
          <div className="text-center text-gray-200 text-[9.65px] font-semibold font-['Qanelas Soft']">
            {settings.language.selectedNow}
          </div>
        </div>
        <div className="flex gap-x-1 items-center">
          <svg
            width="12"
            height="12"
            viewBox="0 0 12 12"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M5.80365 0.261841C4.6558 0.261841 3.53372 0.602219 2.57932 1.23993C1.62491 1.87765 0.881044 2.78405 0.441779 3.84453C0.00251463 4.90501 -0.112417 6.07193 0.111518 7.19773C0.335453 8.32353 0.888198 9.35764 1.69985 10.1693C2.51151 10.9809 3.54562 11.5337 4.67142 11.7576C5.79722 11.9816 6.96414 11.8666 8.02462 11.4274C9.08509 10.9881 9.9915 10.2442 10.6292 9.28983C11.2669 8.33542 11.6073 7.21335 11.6073 6.06549C11.6057 4.52677 10.9937 3.05153 9.90566 1.96349C8.81762 0.875442 7.34238 0.263466 5.80365 0.261841ZM5.58044 2.94045C5.71288 2.94045 5.84235 2.97972 5.95248 3.05331C6.0626 3.12689 6.14843 3.23147 6.19911 3.35384C6.2498 3.4762 6.26306 3.61084 6.23722 3.74074C6.21138 3.87064 6.1476 3.98996 6.05395 4.08362C5.9603 4.17727 5.84098 4.24105 5.71108 4.26689C5.58118 4.29273 5.44654 4.27946 5.32417 4.22878C5.20181 4.17809 5.09722 4.09226 5.02364 3.98214C4.95006 3.87202 4.91078 3.74255 4.91078 3.6101C4.91078 3.4325 4.98134 3.26217 5.10692 3.13659C5.23251 3.011 5.40283 2.94045 5.58044 2.94045ZM6.25009 9.19054C6.01329 9.19054 5.78618 9.09647 5.61873 8.92902C5.45129 8.76157 5.35722 8.53447 5.35722 8.29767V6.06549C5.23882 6.06549 5.12527 6.01846 5.04154 5.93473C4.95782 5.85101 4.91078 5.73746 4.91078 5.61906C4.91078 5.50066 4.95782 5.3871 5.04154 5.30338C5.12527 5.21966 5.23882 5.17262 5.35722 5.17262C5.59402 5.17262 5.82113 5.26669 5.98857 5.43414C6.15602 5.60158 6.25009 5.82869 6.25009 6.06549V8.29767C6.36849 8.29767 6.48204 8.3447 6.56577 8.42842C6.64949 8.51215 6.69652 8.6257 6.69652 8.7441C6.69652 8.8625 6.64949 8.97606 6.56577 9.05978C6.48204 9.1435 6.36849 9.19054 6.25009 9.19054Z"
              fill="#969696"
            />
          </svg>
          <div className="text-center flex gap-x-2 items-center text-neutral-400 text-[11.10px] font-semibold font-['Qanelas Soft']">
            100 = {settings.language.neverHide}
          </div>
        </div>
      </div>
      <div className="flex flex-col gap-y-8">
        <div className="flex flex-col gap-y-2 relative">
          <input
            className="w-10 text-[8.44px] left-4 absolute text-center h-[21.44px] text-white bg-neutral-600 bg-opacity-25 rounded-sm border border-zinc-300 border-opacity-40"
            type="number"
            value={visibilityThresholds["health"] || ""}
            onChange={(e) => handleChange("health", Number(e.target.value))}
          />
          <input
            className="w-10 text-[8.44px] right-6 absolute text-center h-[21.44px] text-white bg-neutral-600 bg-opacity-25 rounded-sm border border-zinc-300 border-opacity-40"
            type="number"
            value={visibilityThresholds["armor"] || ""}
            onChange={(e) => handleChange("armor", Number(e.target.value))}
          />
          <input
            className="w-10 text-[8.44px] -bottom-5 left-3 absolute text-center h-[21.44px] text-white bg-neutral-600 bg-opacity-25 rounded-sm border border-zinc-300 border-opacity-40"
            type="number"
            value={visibilityThresholds["stress"] || ""}
            onChange={(e) => handleChange("stress", Number(e.target.value))}
          />
          <input
            className="w-10 text-[8.44px] -bottom-5 left-14 absolute text-center h-[21.44px] text-white bg-neutral-600 bg-opacity-25 rounded-sm border border-zinc-300 border-opacity-40"
            type="number"
            value={visibilityThresholds["hunger"] || ""}
            onChange={(e) => handleChange("hunger", Number(e.target.value))}
          />
          <input
            className="w-10 text-[8.44px] -bottom-5 right-[24px] absolute text-center h-[21.44px] text-white bg-neutral-600 bg-opacity-25 rounded-sm border border-zinc-300 border-opacity-40"
            type="number"
            value={visibilityThresholds["thirst"] || ""}
            onChange={(e) => handleChange("hydration", Number(e.target.value))}
          />
          <input
            className="w-10 text-[8.44px] -bottom-5 right-[69px] absolute text-center h-[21.44px] text-white bg-neutral-600 bg-opacity-25 rounded-sm border border-zinc-300 border-opacity-40"
            type="number"
            value={visibilityThresholds["energy"] || ""}
            onChange={(e) => handleChange("energy", Number(e.target.value))}
          />
          <Status10 />
        </div>

        <div className="flex gap-x-2 pl-1">
          <button
            onClick={handleSave}
            className="py-2 px-6 bg-neutral-200 rounded-sm border border-neutral-200 flex items-center justify-center"
          >
            <div className="text-black text-[8.44px] font-bold font-['Satoshi'] leading-none tracking-tight">
              {settings.language.saveSettings}
            </div>
          </button>
          <button
            onClick={handleRestore}
            className="py-2 px-6 bg-neutral-200 bg-opacity-10 rounded-sm border border-neutral-200 flex items-center justify-center"
          >
            <div className="text-center text-neutral-200 text-[8.44px] font-bold font-['Satoshi'] leading-none tracking-tight">
              {settings.language.restoreDefaults}
            </div>
          </button>
          <button
            onClick={handleCancel}
            className="py-2 px-8 bg-neutral-200 bg-opacity-10 rounded-sm border border-neutral-200 flex items-center justify-center"
          >
            <div className="text-center text-neutral-200 text-[8.44px] font-bold font-['Satoshi'] leading-none tracking-tight">
              {settings.language.cancel}
            </div>
          </button>
        </div>
      </div>
    </div>
  );
};

export default Status10Edit;
