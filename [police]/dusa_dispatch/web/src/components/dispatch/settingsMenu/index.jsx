import { useState, useEffect } from "react"
import { motion } from "framer-motion"
import { useData } from "../../../hooks/useData"
import { useLanguage } from "../../../hooks/useLanguage"
import Dropdown from "react-dropdown"
import "react-dropdown/style.css"
import s from "./style.module.scss"
import { postNui } from "../../../utils/postNui"
import { useNotify } from "../../../hooks/notify"

function SettingsMenu() {
  const { data, setData, uiData, setUiData } = useData()
  const { language } = useLanguage()
  const [callSign, setCallSign] = useState("")
  const [dispatchManager, setDispatchManager] = useState("")
  const [alertNot, setAlertNot] = useState(false)
  const [mapFilter, setMapFilter] = useState({
    police: false,
    ambulance: true,
    sheriff: true,
    bcso: true,
    highway: true,
    state: true,
    ranger: true,
  })
  const callSignData = data.dispatch.callSign
  const alertNotData = data.dispatch.alertNot
  const handleDispatchManager = (e) => {
    setDispatchManager(e.label)
    useNotify(language.dispatchManagerSet + " " + e.label)
    postNui('setNewManager', {name: e.label, id: e.value} )
  }
  const handleCallSign = (e) => {
    if (e.target.value.length > 5) return
    setCallSign(e.target.value)
  }
  const handleAlertNot = () => {
    postNui('alertNotification', {alertNot: !alertNot})
    if (!alertNot) useNotify(language.alertGUIEnabled)
    else useNotify(language.alertGUIDisabled)
    setAlertNot(!alertNot)
  }
  const handleSave = () => {
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        callSign: callSign.length > 0 ? callSign : callSignData,
        alertNot: alertNot,
        mapFilter: mapFilter,
        dispatchManager: dispatchManager,
      },
    })
    useNotify(language.settingsSaved)
    postNui("saveSettings", {
      callsign: callSign.length > 0 ? callSign : callSignData,
      filters: mapFilter,
      alertEnabled: alertNot,
      operator: dispatchManager,
    })

    setCallSign("")
  }
  const handleMapFilter = (data) => {
    setMapFilter({
      ...mapFilter,
      [data]: !mapFilter[data],
    })
  }

  const getButtonColor = () =>{
       if(data.dispatch.job === "ambulance"){
          return "#ff3939"
       }
       else{
          return "#1fa2ec"
       }
  }
  useEffect(() => {
    setAlertNot(alertNotData)
    setMapFilter(data.dispatch.mapFilter)
    setDispatchManager(data.dispatch.dispatchManager)
  }, [])

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{
        opacity: 1,
        height: uiData.dispatch.menuVisible.settingsMenu
          ? "90%"
          : "15%",
      }}
      exit={{ opacity: 0 }}
      className={`${s.menu} ${
        data.dispatch.job === "police" ? s.police : s.ambulance
      }`}
    >
      <div className={s.menuHead}>
        <div className={s.headBorder}></div>
        <h2>{language.settings}</h2>
        <p>{language.settingsDesc}</p>
        <div className={s.smallIcon}>
          <motion.img
            animate={{
              rotate: uiData.dispatch.menuVisible.settingsMenu
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
                    settingsMenu:
                      !uiData.dispatch.menuVisible.settingsMenu,
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
        <div className={s.input}>
          <p> {language.callSign} </p>
          <input
            onChange={handleCallSign}
            value={callSign}
            placeholder={callSignData}
            type="text"
          />
        </div>
        {data.dispatch.jobAcces.selectManager && (
          <div className={s.input}>
            <p> {language.dispatchManager} </p>
            <Dropdown
              options={data.dispatch.settingsUserList}
              className="settings-dropdown"
              onChange={handleDispatchManager}
              value={dispatchManager}
              placeholder={language.selectManager}
            />
          </div>
        )}


        <div className={s.button}>
          <div className={s.buttonInner} onClick={handleAlertNot}>
            <motion.div
              animate={{
                left: alertNot ? "3.2vw" : "0.3vw",
                background: alertNot ? getButtonColor() : "#fff",
              }}
              className={s.buttonCircle}
            ></motion.div>
          </div>
          <p> {language.alertNotification} </p>
        </div>
        <div className={s.filterMap}>
          <div className={s.filterHeader}>
            <p> {language.mapFilter} </p>
          </div>
          <div className={s.filterList}>
            <div className={s.filterItem}>
              <input
                type="checkbox"
                checked={mapFilter.police}
                onChange={() => {
                  handleMapFilter("police")
                }}
              />
              <p> {language.police} </p>
            </div>
            <div className={s.filterItem}>
              <input
                type="checkbox"
                checked={mapFilter.ambulance}
                onChange={() => {
                  handleMapFilter("ambulance")
                }}
              />
              <p> {language.ambulance} </p>
            </div>
            <div className={s.filterItem}>
              <input
                type="checkbox"
                checked={mapFilter.sheriff}
                onChange={() => {
                  handleMapFilter("sheriff")
                }}
              />
              <p> {language.sheriff} </p>
            </div>
            <div className={s.filterItem}>
              <input
                type="checkbox"
                checked={mapFilter.bcso}
                onChange={() => {
                  handleMapFilter("bcso")
                }}
              />
              <p> {language.bcso} </p>
            </div>
            <div className={s.filterItem}>
              <input
                type="checkbox"
                checked={mapFilter.highway}
                onChange={() => {
                  handleMapFilter("highway")
                }}
              />
              <p> {language.highway} </p>
            </div>
            <div className={s.filterItem}>
              <input
                type="checkbox"
                checked={mapFilter.state}
                onChange={() => {
                  handleMapFilter("state")
                }}
              />
              <p> {language.state} </p>
            </div>
            <div className={s.filterItem}>
              <input
                type="checkbox"
                checked={mapFilter.ranger}
                onChange={() => {
                  handleMapFilter("ranger")
                }}
              />
              <p> {language.ranger} </p>
            </div>
          </div>
        </div>
        <div className={s.create} onClick={handleSave}>
          <p> {language.save} </p>
        </div>
      </div>
    </motion.div>
  )
}

export default SettingsMenu
