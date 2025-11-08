import s from "./style.module.scss"
import { useState } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { useData } from "../../../hooks/useData"
import { useLanguage } from "../../../hooks/useLanguage"
import RadioCommon from "./common"
import RadioHeist from "./heist"
import RadioCreate from "./create"

function RadioMenu() {
  const { data, uiData, setUiData } = useData()
  const { language } = useLanguage()
  const [activeMenu, setActiveMenu] = useState("common")
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ 
        opacity: 1 ,
        height: uiData.dispatch.menuVisible.radioMenu ? "80%" : "14%",
      }}
      exit={{ opacity: 0 }}
      className={`${s.menu} ${
        data.dispatch.job === "police" ? s.police : s.ambulance
      }`}
    >
      <div className={s.menuHead}>
        <div className={s.headBorder}></div>
        <h2>{language.radioFrequences}</h2>
        <p>{language.radioDesc}</p>
        <div className={s.smallIcon}>
          <motion.img
            animate={{
              rotate: uiData.dispatch.menuVisible.radioMenu ? 180 : 0,
            }}
            onClick={() => {
              setUiData({
                ...uiData,
                dispatch: {
                  ...uiData.dispatch,
                  menuVisible: {
                    ...uiData.dispatch.menuVisible,
                    radioMenu: !uiData.dispatch.menuVisible.radioMenu,
                  },
                },
               })
            }}
            src="./collapse.svg"
            alt="collapse"
          />
        </div>
      </div>
      <div className={s.gpsMenu}>
        <div className={s.tab}>
          <p
            className={`${activeMenu == "common" && s.active}`}
            onClick={() => setActiveMenu("common")}
          >
            {language.commonChannels}{" "}
          </p>
          <p
            className={`${activeMenu == "heist" && s.active}`}
            onClick={() => setActiveMenu("heist")}
          >
            {" "}
            {language.heistChannels}{" "}
          </p>
        </div>
        <div className={s.create} style={{ display: !data.dispatch.jobAcces.createGps && "none" }}
        onClick={() => setActiveMenu("create")}
        >
          <p> {language.create} </p>
        </div>
      </div>
      <div className={s.body}>
        <AnimatePresence mode="wait">
          {activeMenu == "common" && <RadioCommon />}
          {activeMenu == "heist" && <RadioHeist />}
          {activeMenu == "create" && <RadioCreate />}
        </AnimatePresence>
      </div>
    </motion.div>
  )
}

export default RadioMenu
