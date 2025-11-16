import { useState, useEffect, useMemo } from "react";
import { useSettings } from "../../../contexts/SettingsContext";
import { HexColorPicker } from "react-colorful";

const defaultVisibilityThresholds = {
  health: 100,
  thirst: 100,
  hunger: 100,
  energy: 100,
  armor: 100,
  stress: 100,
};

const StatusStyleVisibilitySetting = () => {
  const { settings, updateSettings, openSettings, setOpenSettings } =
    useSettings();

  const defaultColors = useMemo(() => {
    if (openSettings) {
      return settings.styleVisibility[openSettings.toString()].visibilityColor;
    } else {
      return settings.styleVisibility[1].visibilityColor;
    }
  }, [openSettings]);

  const [visibilityThresholds, setVisibilityThresholds] = useState(
    defaultVisibilityThresholds
  );
  const [visibilityColors, setVisibilityColors] = useState(defaultColors);

  useEffect(() => {
    setVisibilityColors(defaultColors);
  }, [defaultColors]);

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
      [openSettings]: {
        visibilityThresholds: { ...visibilityThresholds },
        visibilityColor: {
          health: visibilityColors.health,
          thirst: visibilityColors.thirst,
          hunger: visibilityColors.hunger,
          energy: visibilityColors.energy,
          armor: visibilityColors.armor,
          stress: visibilityColors.stress,
        },
      },
    };
    updateSettings("styleVisibility", updatedVisibilitySettings);
    setOpenSettings(null);
  };

  const handleChangeColor = (changeColor, index) => {
    setVisibilityColors((prev) => ({ ...prev, [changeColor]: index }));
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

  const [showColorPicker, setShowColorPicker] = useState(-1);

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
        <div className="flex flex-col gap-y-2">
          <div className="flex items-center w-[311px] px-1  justify-between">
            <div className="relative w-10 h-10 bg-black bg-opacity-15 rounded-full flex items-center justify-center">
              <svg
                width="19"
                height="18"
                viewBox="0 0 19 18"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M17.0026 1.712C15.2122 -0.153707 12.3051 -0.153707 10.5147 1.712L9.29601 2.97501L8.07732 1.70757C6.28251 -0.158138 3.37981 -0.158138 1.58944 1.70757C-0.426947 3.80372 -0.426947 7.20719 1.58944 9.30335L9.29601 17.329L17.0026 9.30778C19.019 7.21163 19.019 3.80815 17.0026 1.712Z"
                  fill={visibilityColors["health"]}
                />
              </svg>
            </div>
            <div className="relative w-10 h-10 bg-black bg-opacity-15 rounded-full flex items-center justify-center">
              <svg
                width="17"
                height="22"
                viewBox="0 0 17 22"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M8.7186 21.5606C13.0492 21.5606 16.5925 18.0173 16.5925 13.6867C16.5925 9.35609 8.7186 0.563599 8.7186 0.563599C8.7186 0.563599 0.844727 9.48732 0.844727 13.6867C0.844727 17.8861 4.38797 21.5606 8.7186 21.5606Z"
                  fill={visibilityColors["thirst"]}
                />
              </svg>
            </div>
            <div className="relative w-10 h-10 bg-black bg-opacity-15 rounded-full flex items-center justify-center">
              <svg
                width="22"
                height="19"
                viewBox="0 0 22 19"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2.60967 7.14676C2.47126 6.97647 2.37278 6.77732 2.32151 6.56394C2.27023 6.35057 2.26744 6.12842 2.31336 5.91383C2.99496 2.69206 6.68459 0.352783 11.0879 0.352783C15.4913 0.352783 19.1809 2.69206 19.8625 5.91383C19.9089 6.12857 19.9065 6.351 19.8555 6.5647C19.8045 6.7784 19.7062 6.97793 19.5678 7.14855C19.4294 7.31918 19.2544 7.45656 19.0558 7.55057C18.8573 7.64457 18.6401 7.69279 18.4204 7.69167L3.75546 7.69167C3.53588 7.69234 3.31894 7.64372 3.12064 7.54942C2.92235 7.45511 2.74773 7.31751 2.60967 7.14676ZM20.3771 12.139L16.604 13.5151L13.1979 12.1473C13.023 12.0774 12.8279 12.0774 12.6529 12.1473L9.25871 13.5059L5.85897 12.1473C5.6916 12.0804 5.50547 12.0775 5.33607 12.139L1.29968 13.6068C1.12908 13.6819 0.99345 13.8191 0.920311 13.9905C0.847172 14.162 0.842008 14.3548 0.905865 14.5299C0.969722 14.7051 1.09782 14.8493 1.26415 14.9334C1.43048 15.0175 1.62259 15.0352 1.80148 14.9829L3.01515 14.5434L3.01515 15.0306C3.01515 16.0038 3.40175 16.9371 4.0899 17.6253C4.77806 18.3134 5.7114 18.7 6.68459 18.7L15.4913 18.7C16.4645 18.7 17.3978 18.3134 18.086 17.6253C18.7741 16.9371 19.1607 16.0038 19.1607 15.0306L19.1607 14.1435L20.8789 13.5188C20.9753 13.4906 21.0648 13.4429 21.142 13.3787C21.2192 13.3145 21.2824 13.2352 21.3277 13.1456C21.373 13.056 21.3995 12.9581 21.4054 12.8579C21.4113 12.7577 21.3967 12.6573 21.3623 12.563C21.3279 12.4687 21.2745 12.3824 21.2054 12.3096C21.1364 12.2367 21.0531 12.1788 20.9608 12.1394C20.8684 12.1 20.769 12.08 20.6686 12.0805C20.5682 12.0811 20.469 12.1023 20.3771 12.1427L20.3771 12.139ZM1.54737 10.6272L20.6285 10.6272C20.8231 10.6272 21.0098 10.5499 21.1474 10.4123C21.2851 10.2746 21.3624 10.088 21.3624 9.89334C21.3624 9.6987 21.2851 9.51203 21.1474 9.3744C21.0098 9.23677 20.8231 9.15945 20.6285 9.15945L1.54737 9.15945C1.35273 9.15945 1.16606 9.23677 1.02843 9.3744C0.890797 9.51203 0.813477 9.6987 0.813477 9.89334C0.813477 10.088 0.890797 10.2746 1.02843 10.4123C1.16606 10.5499 1.35273 10.6272 1.54737 10.6272Z"
                  fill={visibilityColors["hunger"]}
                />
              </svg>
            </div>
            <div className="relative w-10 h-10 bg-black bg-opacity-15 rounded-full flex items-center justify-center">
              <svg
                width="18"
                height="25"
                viewBox="0 0 18 25"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M8.50806 24.0602C8.38518 24.0601 8.26326 24.0385 8.14775 23.9966C7.92494 23.915 7.73595 23.761 7.61105 23.5593C7.48616 23.3575 7.43259 23.1197 7.45892 22.8839L8.27492 15.3703H2.03302C1.8405 15.3706 1.65153 15.3184 1.48642 15.2194C1.32131 15.1204 1.18629 14.9783 1.09586 14.8083C1.00543 14.6384 0.963008 14.447 0.973152 14.2547C0.983296 14.0625 1.04562 13.8766 1.15343 13.7171L9.51482 1.21212C9.64706 1.01642 9.84089 0.870514 10.0655 0.797556C10.2902 0.724597 10.5327 0.728771 10.7547 0.809415C10.9681 0.888645 11.1504 1.03449 11.2744 1.22535C11.3985 1.41622 11.4578 1.64196 11.4436 1.86916L10.6276 9.43573H16.8695C17.062 9.43544 17.2509 9.4876 17.4161 9.58661C17.5812 9.68562 17.7162 9.82774 17.8066 9.9977C17.897 10.1677 17.9395 10.3591 17.9293 10.5513C17.9192 10.7436 17.8569 10.9294 17.749 11.0889L9.38765 23.5939C9.29044 23.7377 9.15939 23.8555 9.00602 23.9368C8.85265 24.0181 8.68165 24.0605 8.50806 24.0602Z"
                  fill={visibilityColors["energy"]}
                />
              </svg>
            </div>
            <div className="relative w-10 h-10 bg-black bg-opacity-15 rounded-full flex items-center justify-center">
              <svg
                width="21"
                height="22"
                viewBox="0 0 21 22"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M20.3147 4.39731L19.9248 4.36732C15.4864 4.0203 10.9065 1.13273 10.8637 1.10703L10.6323 0.957092L10.401 1.10703C10.3581 1.13273 5.77829 4.0203 1.33984 4.36732L0.949991 4.39731L0.941414 4.78719C0.941414 4.89858 0.885716 15.8705 10.4138 21.5428L10.6323 21.6713L10.8508 21.5428C20.3789 15.8705 20.3232 4.89858 20.3232 4.78719L20.3147 4.39731Z"
                  fill={visibilityColors["armor"]}
                />
              </svg>
            </div>
            <div className="relative w-10 h-10 bg-black bg-opacity-15 rounded-full flex items-center justify-center">
              <svg
                width="24"
                height="19"
                viewBox="0 0 24 19"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M20.1615 4.73033V4.3453C20.1605 3.51099 19.9131 2.69556 19.4504 2.00134C18.9876 1.30712 18.3302 0.765035 17.5605 0.443109C16.7907 0.121183 15.9431 0.0337588 15.1239 0.191806C14.3047 0.349854 13.5504 0.746333 12.9557 1.33149C12.9205 1.36695 12.8927 1.40902 12.8739 1.45528C12.8551 1.50154 12.8456 1.55107 12.846 1.60101V10.141C12.8462 10.2104 12.8651 10.2784 12.9008 10.338C12.9365 10.3975 12.9877 10.4463 13.0488 10.4791C13.11 10.512 13.1789 10.5277 13.2482 10.5246C13.3176 10.5215 13.3848 10.4997 13.4428 10.4615C14.175 9.99199 15.0256 9.74028 15.8954 9.73571C16.0968 9.73197 16.2919 9.80552 16.4407 9.94123C16.5894 10.0769 16.6806 10.2645 16.6953 10.4653C16.7008 10.5698 16.685 10.6743 16.6487 10.7725C16.6125 10.8706 16.5566 10.9603 16.4846 11.0362C16.4125 11.112 16.3258 11.1724 16.2296 11.2136C16.1334 11.2548 16.0299 11.276 15.9253 11.2758C15.1083 11.2758 14.3249 11.6003 13.7472 12.178C13.1695 12.7557 12.845 13.5391 12.845 14.3561V17.6172C12.8449 17.6748 12.8578 17.7317 12.8826 17.7837C12.9074 17.8357 12.9436 17.8814 12.9884 17.9176C13.5349 18.3698 14.1783 18.6899 14.8686 18.853C15.5588 19.0162 16.2775 19.0179 16.9685 18.8581C17.6596 18.6983 18.3045 18.3813 18.8531 17.9317C19.4017 17.4821 19.8393 16.912 20.1317 16.2658C20.1611 16.2008 20.1719 16.1289 20.1629 16.0582C20.1539 15.9874 20.1254 15.9205 20.0805 15.865C20.0357 15.8095 19.9763 15.7676 19.9091 15.7438C19.8418 15.7201 19.7692 15.7155 19.6995 15.7306C19.2196 15.8406 18.7288 15.8961 18.2364 15.8962H17.4923C17.2937 15.8986 17.1014 15.8259 16.9541 15.6925C16.8069 15.5592 16.7154 15.3751 16.6982 15.1771C16.6912 15.0718 16.7059 14.9661 16.7415 14.8667C16.7771 14.7674 16.8327 14.6763 16.9049 14.5993C16.9771 14.5223 17.0644 14.461 17.1613 14.4191C17.2582 14.3773 17.3627 14.3558 17.4683 14.3561H18.2383C19.0429 14.3573 19.8356 14.163 20.5485 13.7901C21.3927 13.3504 22.094 12.6791 22.5702 11.855C23.0465 11.0309 23.2778 10.0881 23.2372 9.13709C23.1966 8.18613 22.8857 7.26647 22.3409 6.48595C21.7962 5.70543 21.0401 5.09642 20.1615 4.73033ZM19.0065 8.19559H18.6214C17.7024 8.19559 16.821 7.8305 16.1711 7.18064C15.5212 6.53078 15.1562 5.64938 15.1562 4.73033V4.3453C15.1562 4.14107 15.2373 3.9452 15.3817 3.80079C15.5261 3.65638 15.722 3.57525 15.9262 3.57525C16.1304 3.57525 16.3263 3.65638 16.4707 3.80079C16.6151 3.9452 16.6963 4.14107 16.6963 4.3453V4.73033C16.6963 4.98315 16.7461 5.23348 16.8428 5.46705C16.9396 5.70062 17.0814 5.91285 17.2601 6.09162C17.6212 6.45265 18.1108 6.65548 18.6214 6.65548H19.0065C19.2107 6.65548 19.4066 6.73661 19.551 6.88102C19.6954 7.02544 19.7765 7.2213 19.7765 7.42553C19.7765 7.62977 19.6954 7.82563 19.551 7.97005C19.4066 8.11446 19.2107 8.19559 19.0065 8.19559ZM8.22563 0.109986C7.10275 0.11126 6.02622 0.557888 5.23222 1.35189C4.43822 2.14589 3.99159 3.22242 3.99031 4.3453V4.73033C3.1118 5.09661 2.35594 5.70579 1.81136 6.48641C1.26678 7.26704 0.956063 8.18676 0.915648 9.13771C0.875234 10.0887 1.1068 11.0314 1.58318 11.8554C2.05956 12.6795 2.76102 13.3506 3.60529 13.7901C4.31814 14.163 5.11093 14.3573 5.91546 14.3561H6.65953C6.85853 14.3531 7.05125 14.4256 7.19894 14.559C7.34663 14.6924 7.43832 14.8768 7.45558 15.0751C7.46257 15.1804 7.44783 15.2861 7.41228 15.3855C7.37672 15.4849 7.32111 15.5759 7.24889 15.6529C7.17668 15.7299 7.0894 15.7912 6.99249 15.8331C6.89557 15.8749 6.79108 15.8964 6.68552 15.8962H5.91546C5.4227 15.8964 4.93151 15.8405 4.45139 15.7296C4.38171 15.7144 4.30918 15.7189 4.24188 15.7425C4.17459 15.7661 4.11517 15.8079 4.07025 15.8633C4.02534 15.9187 3.99669 15.9855 3.9875 16.0562C3.97832 16.127 3.98896 16.1988 4.01823 16.2639C4.31059 16.9103 4.74809 17.4805 5.2967 17.9303C5.84531 18.3801 6.49026 18.6973 7.18142 18.8573C7.87257 19.0173 8.59131 19.0157 9.28177 18.8527C9.97222 18.6898 10.6158 18.3697 11.1624 17.9176C11.2073 17.8814 11.2435 17.8357 11.2683 17.7837C11.2931 17.7317 11.3059 17.6748 11.3059 17.6172V14.3561C11.3059 13.5391 10.9813 12.7557 10.4037 12.178C9.82603 11.6003 9.04256 11.2758 8.22563 11.2758C8.12102 11.276 8.01746 11.2548 7.9213 11.2136C7.82514 11.1724 7.73838 11.112 7.66631 11.0362C7.59425 10.9603 7.5384 10.8706 7.50217 10.7725C7.46594 10.6743 7.45008 10.5698 7.45558 10.4653C7.47032 10.2643 7.56158 10.0766 7.71057 9.94089C7.85956 9.80515 8.05493 9.73172 8.25644 9.73571C9.12625 9.74028 9.97684 9.99199 10.7091 10.4615C10.767 10.4997 10.8343 10.5215 10.9036 10.5246C10.973 10.5277 11.0419 10.512 11.103 10.4791C11.1642 10.4463 11.2153 10.3975 11.251 10.338C11.2867 10.2784 11.3057 10.2104 11.3059 10.141V1.60101C11.3062 1.49994 11.2668 1.40279 11.1961 1.33053C10.4055 0.548172 9.33794 0.109539 8.22563 0.109986ZM8.99569 4.73033C8.99569 5.64938 8.6306 6.53078 7.98074 7.18064C7.33088 7.8305 6.44948 8.19559 5.53043 8.19559H5.1454C4.94117 8.19559 4.7453 8.11446 4.60089 7.97005C4.45647 7.82563 4.37534 7.62977 4.37534 7.42553C4.37534 7.2213 4.45647 7.02544 4.60089 6.88102C4.7453 6.73661 4.94117 6.65548 5.1454 6.65548H5.53043C5.78324 6.65548 6.03358 6.60568 6.26715 6.50893C6.50072 6.41219 6.71295 6.27038 6.89171 6.09162C7.07048 5.91285 7.21229 5.70062 7.30903 5.46705C7.40578 5.23348 7.45558 4.98315 7.45558 4.73033V4.3453C7.45558 4.14107 7.53671 3.9452 7.68112 3.80079C7.82554 3.65638 8.0214 3.57525 8.22563 3.57525C8.42987 3.57525 8.62573 3.65638 8.77015 3.80079C8.91456 3.9452 8.99569 4.14107 8.99569 4.3453V4.73033Z"
                  fill={visibilityColors["stress"]}
                />
              </svg>
            </div>
          </div>

          <div className="flex items-center w-[311px] pl-1 gap-x-1 justify-between">
            {Object.keys(defaultVisibilityThresholds).map((field, index) => (
              <input
                className="w-10 text-[8.44px] text-center h-[21.44px] text-white bg-neutral-600 bg-opacity-25 rounded-sm border border-zinc-300 border-opacity-40"
                key={index}
                type="number"
                value={visibilityThresholds[field]}
                onChange={(e) => handleChange(field, Number(e.target.value))}
              />
            ))}
          </div>
          <div className="flex items-center w-[311px] pl-1 gap-x-1 justify-between">
            {["health", "thirst", "hunger", "energy", "armor", "stress"].map(
              (field, index) => (
                <>
                  <div
                    onClick={() => setShowColorPicker(field)}
                    className="w-10 h-[12.50px] rounded-sm border border-zinc-300 border-opacity-40"
                    style={{ backgroundColor: visibilityColors[field] }}
                  />
                  {showColorPicker === field && (
                    <div className="bg-black p-2 flex flex-col gap-y-2 items-end justify-end z-20">
                      <HexColorPicker
                        color={visibilityColors[field]}
                        onChange={(e) => {
                          handleChangeColor(field, e);
                        }}
                      />
                      <button
                        onClick={() => setShowColorPicker(null)}
                        className="p-2 text-white border border-white border-opacity-30 hover:bg-slate-900 rounded-lg"
                      >
                        {settings.language.saveColor}
                      </button>
                    </div>
                  )}
                </>
              )
            )}
          </div>
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

export default StatusStyleVisibilitySetting;
