import s from "./style.module.scss"
import { useData } from "../../../hooks/useData"
import { useLanguage } from "../../../hooks/useLanguage"
import { AnimatePresence } from "framer-motion"
import DrawMenu from "../drawMenu"
import BodyCamList from "../bodyCam"
import GpsMenu from "../gpsMenu"
import RadioMenu from "../radioMenu"
import SettingsMenu from "../settingsMenu"
import CameraMenu from "../cameraMenu"
import DispatchMenu from "../dispatchMenu"
import UnitsMenu from "../unitsMenu"
function DispatchTab() {
  const { data } = useData()
  const { language } = useLanguage()
  const router = data.dispatch.menu
  const getActiveGpsName = () => {
    let name = ""
    data.dispatch.gpsHeist.forEach(element => {
      if (element.code === data.dispatch.activeGps) {
        name = element.code
      }
    });
    data.dispatch.gpsCommon.forEach(element => {
      element.item.forEach(item => {
        if (item.code === data.dispatch.activeGps) {
          name = item.code
        }
      })
    });
    if(name === "") name = language.notEntered
    return name
  }
  const getActiveRadioName = () => {  
    let name = data.dispatch.activeRadio + " MHz";
    if(name === "") name = language.notEntered
    return name
  }
  return (
    <>
      <div className={s.body}>
        <div
          className={`${s.activeRadio} ${
            data.dispatch.job === "police" ? s.police : s.ambulance
          }`}
        >
          <div className={s.item}>
            <div className={s.boder}></div>
            <p>
              {" "}
              {language.gps}: {getActiveGpsName()}{" "}
            </p>
          </div>
          <div className={s.item}>
            <div className={s.boder}></div>
            <p>
              {" "}
              {language.radio}: {getActiveRadioName()}{" "}
            </p>
          </div>
        </div>
        <AnimatePresence>
          {router === "draw" && <DrawMenu />}
          {router === "bodycam" && <BodyCamList />}
          {router === "gps" && <GpsMenu />}
          {router === "radio" && <RadioMenu />}
          {router === "settings" && <SettingsMenu />}
          {router === "camera" && <CameraMenu />}
          {router === "dispatchList" && <DispatchMenu />}
          {router === "units" && <UnitsMenu />}
        </AnimatePresence>
      </div>
    </>
  )
}

export default DispatchTab
