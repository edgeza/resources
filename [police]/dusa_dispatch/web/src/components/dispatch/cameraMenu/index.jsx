import s from "./style.module.scss"
import { useState } from "react"
import { AnimatePresence, motion } from "framer-motion"
import CreateCamera from "./create"
import ManagaCamera from "./manage"
import { useData } from "../../../hooks/useData"
import { useLanguage } from "../../../hooks/useLanguage"
function CameraMenu() {
  const { data, uiData, setUiData } = useData()
  const { language } = useLanguage()
  const [menu, setMenu] = useState("manage")
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{
        opacity: 1,
        height: uiData.dispatch.menuVisible.cameraMenu
          ? "65%"
          : "15%",
      }}
      exit={{ opacity: 0 }}
      className={`${s.menu} ${
        data.dispatch.job === "police" ? s.police : s.ambulance
      }`}
    >
      <div className={s.menuHead}>
        <div className={s.headBorder}></div>
        <div className={s.button} style={{ display: !data.dispatch.jobAcces.createCamera && "none" }}>
          {menu !== "manage" ? (
            <div
              className={s.manageB}
              onClick={() => setMenu("manage")}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="18"
                height="15"
                viewBox="0 0 18 15"
                fill="none"
              >
                <path
                  d="M17.2284 9.15005C17.0825 9.15005 16.9426 9.208 16.8395 9.31113C16.7363 9.41427 16.6784 9.55416 16.6784 9.70002V10.7999H13.6062L12.3474 9.53915L15.8081 6.07783C16.0142 5.87157 16.13 5.59191 16.13 5.30032C16.13 5.00873 16.0142 4.72907 15.8081 4.52281L13.2178 1.9318L11.9563 0.673079C11.8541 0.570915 11.7329 0.489873 11.5994 0.434581C11.4659 0.379289 11.3229 0.35083 11.1784 0.35083C11.034 0.35083 10.8909 0.379289 10.7575 0.434581C10.624 0.489873 10.5027 0.570915 10.4006 0.673079L0.380278 10.7271C0.28436 10.8233 0.219103 10.9458 0.192747 11.0791C0.166391 11.2123 0.180118 11.3504 0.232195 11.4759C0.284272 11.6014 0.372363 11.7086 0.485345 11.7841C0.598327 11.8595 0.731133 11.8998 0.866995 11.8999H3.57349L6.00158 14.3273C6.20783 14.5334 6.48749 14.6492 6.77908 14.6492C7.07068 14.6492 7.35034 14.5334 7.55659 14.3273L11.5679 10.3187L12.8287 11.5774C12.9304 11.68 13.0516 11.7614 13.1851 11.8167C13.3185 11.8721 13.4617 11.9003 13.6062 11.8999H16.6784V12.9998C16.6784 13.1456 16.7363 13.2855 16.8395 13.3887C16.9426 13.4918 17.0825 13.5497 17.2284 13.5497C17.3742 13.5497 17.5141 13.4918 17.6172 13.3887C17.7204 13.2855 17.7783 13.1456 17.7783 12.9998V9.70002C17.7783 9.55416 17.7204 9.41427 17.6172 9.31113C17.5141 9.208 17.3742 9.15005 17.2284 9.15005ZM11.1788 1.45059L12.0512 2.32296L3.57349 10.7999H1.86105L11.1788 1.45059Z"
                  fill="white"
                />
              </svg>
              {language.manage}
            </div>
          ) : (
            <div
              className={s.createB}
              onClick={() => setMenu("create")}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="18"
                height="15"
                viewBox="0 0 18 15"
                fill="none"
              >
                <path
                  d="M17.2284 9.15005C17.0825 9.15005 16.9426 9.208 16.8395 9.31113C16.7363 9.41427 16.6784 9.55416 16.6784 9.70002V10.7999H13.6062L12.3474 9.53915L15.8081 6.07783C16.0142 5.87157 16.13 5.59191 16.13 5.30032C16.13 5.00873 16.0142 4.72907 15.8081 4.52281L13.2178 1.9318L11.9563 0.673079C11.8541 0.570915 11.7329 0.489873 11.5994 0.434581C11.4659 0.379289 11.3229 0.35083 11.1784 0.35083C11.034 0.35083 10.8909 0.379289 10.7575 0.434581C10.624 0.489873 10.5027 0.570915 10.4006 0.673079L0.380278 10.7271C0.28436 10.8233 0.219103 10.9458 0.192747 11.0791C0.166391 11.2123 0.180118 11.3504 0.232195 11.4759C0.284272 11.6014 0.372363 11.7086 0.485345 11.7841C0.598327 11.8595 0.731133 11.8998 0.866995 11.8999H3.57349L6.00158 14.3273C6.20783 14.5334 6.48749 14.6492 6.77908 14.6492C7.07068 14.6492 7.35034 14.5334 7.55659 14.3273L11.5679 10.3187L12.8287 11.5774C12.9304 11.68 13.0516 11.7614 13.1851 11.8167C13.3185 11.8721 13.4617 11.9003 13.6062 11.8999H16.6784V12.9998C16.6784 13.1456 16.7363 13.2855 16.8395 13.3887C16.9426 13.4918 17.0825 13.5497 17.2284 13.5497C17.3742 13.5497 17.5141 13.4918 17.6172 13.3887C17.7204 13.2855 17.7783 13.1456 17.7783 12.9998V9.70002C17.7783 9.55416 17.7204 9.41427 17.6172 9.31113C17.5141 9.208 17.3742 9.15005 17.2284 9.15005ZM11.1788 1.45059L12.0512 2.32296L3.57349 10.7999H1.86105L11.1788 1.45059Z"
                  fill="white"
                />
              </svg>
              {language.create}
            </div>
          )}
        </div>
        <div className={s.smallIcon}>
          <motion.img
            animate={{
              rotate: uiData.dispatch.menuVisible.cameraMenu
                ? 180
                : 0,
            }}
            onClick={() => {
              setUiData({
                ...uiData,
                dispatch: {
                  ...uiData.dispatch,
                  menuVisible: {
                    ...uiData.dispatch.menuVisible,
                    cameraMenu:
                      !uiData.dispatch.menuVisible.cameraMenu,
                  },
                },
              })
            }}
            src="./collapse.svg"
            alt="collapse"
          />
        </div>
      </div>
      <div className={s.body}>
        <AnimatePresence mode="wait">
          {menu === "manage" && <ManagaCamera />}
          {menu === "create" && <CreateCamera />}
        </AnimatePresence>
      </div>
    </motion.div>
  )
}

export default CameraMenu
