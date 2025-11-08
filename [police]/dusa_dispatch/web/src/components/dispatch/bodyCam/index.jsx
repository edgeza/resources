import s from "./style.module.scss"
import { motion } from "framer-motion"
import { useData } from "../../../hooks/useData"
import { useLanguage } from "./../../../hooks/useLanguage"
import { postNui } from "../../../utils/postNui"
import { useState } from "react"
import { act } from "react"

function BodyCamList() {
  const { data, uiData, setUiData, setData } = useData()
  const { language } = useLanguage()
  const [active, setActive] = useState("")

  const handleClick = (item) => {
    if (active === item.citizenId) {
      setActive("")
      // postNui("BODYCAM_CLOSE")
      return
    }
    const gameId = item.gameId
    setActive(item.citizenId)
    postNui("BODYCAM_WATCH", { gameId })
  }
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{
        opacity: 1,
        height: uiData.dispatch.menuVisible.bodyCamMenu
          ? "80%"
          : "14%",
      }}
      exit={{ opacity: 0 }}
      className={`${s.menu} ${
        data.dispatch.job === "police" ? s.police : s.ambulance
      }`}
    >
      <div className={s.menuHead}>
        <div className={s.headBorder}></div>
        <h2>{language.bodyCamList}</h2>
        <p>{language.bodyCamDesc}</p>
        <div className={s.smallIcon}>
          <motion.img
            animate={{
              rotate: uiData.dispatch.menuVisible.bodyCamMenu ? 180 : 0,
            }}
            onClick={() => {
              setUiData({
                ...uiData,
                dispatch: {
                  ...uiData.dispatch,
                  menuVisible: {
                    ...uiData.dispatch.menuVisible,
                    bodyCamMenu: !uiData.dispatch.menuVisible.bodyCamMenu,
                  },
                },
               })
            }}
            src="./collapse.svg"
            alt="collapse"
          />
        </div>
      </div>
      <div className={s.menuBody}>
        {data.dispatch.bodyCamList.map((item, index) => (
          <div
            onClick={() => handleClick(item)}
            key={index}
            className={`${s.menuItem} ${
              active === item.citizenId ? s.active : ""
            }`}
          >
            <div className={s.itemLeft}>
              <div className={s.itemTitle}>
                <h2> {item.name} </h2>
              </div>
              <div className={s.itemDesc}>
                <div className={s.itemDot}></div>
                <p> {language.clickToWatch} </p>
              </div>
            </div>
            <div className={s.itemRight}>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="20"
                height="13"
                viewBox="0 0 20 13"
                fill="none"
              >
                <g filter="url(#filter0_i_1_3698)">
                  <path
                    d="M14.6666 1.76399V11.0973C14.6666 11.4509 14.5261 11.79 14.2761 12.0401C14.026 12.2901 13.6869 12.4306 13.3333 12.4306H1.33333C0.979707 12.4306 0.64057 12.2901 0.390522 12.0401C0.140475 11.79 0 11.4509 0 11.0973V1.76399C0 1.41037 0.140475 1.07123 0.390522 0.821186C0.64057 0.571139 0.979707 0.430664 1.33333 0.430664H13.3333C13.6869 0.430664 14.026 0.571139 14.2761 0.821186C14.5261 1.07123 14.6666 1.41037 14.6666 1.76399ZM19.4999 1.78482C19.4059 1.76181 19.308 1.75897 19.2128 1.77649C19.1175 1.79402 19.0271 1.8315 18.9474 1.88649L16.1483 3.75231C16.1026 3.78278 16.0652 3.82405 16.0393 3.87246C16.0134 3.92087 15.9999 3.97492 15.9999 4.02981V8.83146C15.9999 8.88635 16.0134 8.9404 16.0393 8.98881C16.0652 9.03722 16.1026 9.07849 16.1483 9.10896L18.9632 10.9856C19.0686 11.0559 19.1918 11.0947 19.3184 11.0975C19.4451 11.1003 19.5699 11.067 19.6782 11.0014C19.7785 10.9377 19.8607 10.8493 19.9171 10.7447C19.9734 10.6401 20.0019 10.5227 19.9999 10.4039V2.43065C20 2.2828 19.9509 2.13912 19.8604 2.0222C19.7699 1.90529 19.6431 1.82179 19.4999 1.78482Z"
                    fill="#FF3939"
                  />
                </g>
                <defs>
                  <filter
                    id="filter0_i_1_3698"
                    x="0"
                    y="0.430664"
                    width="20"
                    height="12"
                    filterUnits="userSpaceOnUse"
                    colorInterpolationFilters="sRGB"
                  >
                    <feFlood
                      floodOpacity="0"
                      result="BackgroundImageFix"
                    />
                    <feBlend
                      mode="normal"
                      in="SourceGraphic"
                      in2="BackgroundImageFix"
                      result="shape"
                    />
                    <feColorMatrix
                      in="SourceAlpha"
                      type="matrix"
                      values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                      result="hardAlpha"
                    />
                    <feOffset />
                    <feGaussianBlur stdDeviation="7.65" />
                    <feComposite
                      in2="hardAlpha"
                      operator="arithmetic"
                      k2="-1"
                      k3="1"
                    />
                    <feColorMatrix
                      type="matrix"
                      values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.57 0"
                    />
                    <feBlend
                      mode="normal"
                      in2="shape"
                      result="effect1_innerShadow_1_3698"
                    />
                  </filter>
                </defs>
              </svg>
            </div>
          </div>
        ))}
      </div>
    </motion.div>
  )
}

export default BodyCamList
