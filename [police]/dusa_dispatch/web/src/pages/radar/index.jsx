import React, { useState, useRef } from "react"
import style from "./radar.module.scss"
import RadarSpeed from "../../components/radar/speed"
import RadarText from "../../components/radar/text"
import RadarPlate from "../../components/radar/plate"
import RadarToolBar from "./../../components/radar/toolbar"
import Draggable from "react-draggable"
import { useData } from "./../../hooks/useData"
import { useLanguage } from "./../../hooks/useLanguage"
import { useRoute } from "./../../hooks/useRoute"
import { useNuiEvent } from "../../hooks/useNuiEvent"
import { motion } from "framer-motion"
import { debugData } from "../../utils/debugData"



// True yaparsan gizlenir false yaparsan açılır
debugData([
  {
    action: "RADAR_SHOW",
    data: false,
  }
])


function Radar() {
  const { data, setData } = useData()
  const { language } = useLanguage()
  const { route, navigateTo } = useRoute()
  const [drag, setDrag] = useState(true)
  const [show, setShow] = useState(false)

  // useNuiEvent("RADAR_UPDATE", (data) => {
  //   setData({
  //     ...data,
  //     radarSettings: {
  //       ...data.radarSettings,
  //       frontXmıt: data.fwdMode,
  //       rearXmıt: data.bwdMode,
  //     },
  //   })
  // })


  useNuiEvent("RADAR_SHOW", (data) => {
    setShow(data)
  })

  useNuiEvent("SET_REAR_RADAR_PLATE", (data) => {
    setData((prevData) => {
      return {
        ...prevData,
        radar: {
          ...prevData.radar,
          rearPlate: data,
        },
      }
    })
  })

  useNuiEvent("SET_REAR_RADAR_SPEED", (data) => {
    setData((prevData) => {
      return {
        ...prevData,
        radar: {
          ...prevData.radar,
          rearSpeed: data,
        },
      }
    })
  })

  useNuiEvent("SET_FRONT_RADAR_PLATE", (data) => {
    setData((prevData) => {
      return {
        ...prevData,
        radar: {
          ...prevData.radar,
          frontPlate: data,
        },
      }
    })
  })

  useNuiEvent("SET_FRONT_RADAR_SPEED", (data) => {
    setData((prevData) => {
      return {
        ...prevData,
        radar: {
          ...prevData.radar,
          frontSpeed: data,
        },
      }
    })
  })

  useNuiEvent("SET_PATROL_SPEED", (data) => {
    setData((prevData) => {
      return {
        ...prevData,
        radar: {
          ...prevData.radar,
          speed: data,
        },
      }
    })
  })

  const changeScale = (e) => {
    let scale = e.target.value

    setData({
      ...data,
      radar: {
        ...data.radar,
        menuScale: scale,
        menuPosition: { x: 0, y: 0 },
      },
    })
  }
  const changeColor = (color) => {
    setData({
      ...data,
      radar: {
        ...data.radar,
        menuFırstColor: color,
      },
    })
  }
  const changeSecondColor = (color) => {
    setData({
      ...data,
      radar: {
        ...data.radar,
        menuSecondColor: color,
      },
    })
  }
  const changeThirdColor = (color) => {
    ;-setData({
      ...data,
      radar: {
        ...data.radar,
        menuThirdColor: color,
      },
    })
  }
  const changePosition = (position) => {
    setData({
      ...data,
      radar: {
        ...data.radar,
        menuPosition: position,
      },
    })
  }
  const resetSettings = () => {
    setData({
      ...data,
      radar: {
        ...data.radar,
        menuScale: 100,
        menuPosition: { x: 0, y: 0 },
        menuFırstColor: "#FFC736",
        menuSecondColor: "#FF3667",
        menuThirdColor: "#2CE7BB",
      },
    })
  }
  const saveSettings = () => {
    setData({
      ...data,
      radar: {
        ...data.radar,
        toolbar: false,
      },
    })
    navigateTo("radarSettings")
  }

  const radarData = data.radar
  const radarSettings = data.radarSettings
  return (
    <>
      <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: show ? 0 : 1 }}
      className={style.radarMain}>
        {data.radar.toolbar ? (
          <RadarToolBar
            drag={drag}
            setDrag={setDrag}
            scale={radarData.menuScale}
            changeScale={changeScale}
            color={radarData.menuFırstColor}
            changeColor={changeColor}
            color2={radarData.menuSecondColor}
            changeSecondColor={changeSecondColor}
            color3={radarData.menuThirdColor}
            changeThirdColor={changeThirdColor}
            resetSettings={resetSettings}
            saveSettings={saveSettings}
          />
        ) : null}
        <div
          style={{
            transform: `scale(${radarData.menuScale / 100})`,
          }}
        >
          <Draggable
            disabled={drag}
            scale={radarData.menuScale / 100}
            position={radarData.menuPosition}
            onStop={(e, data) => changePosition(data)}
          >
            <div className={style.radarInner}>
              <div className={style.radarTop}>
                <div className={style.radarTopI}>
                  <RadarSpeed
                    config={radarSettings}
                    direct={"front"}
                    menu={true}
                    type={1}
                    speed={radarData.frontSpeed}
                    color={radarData.menuFırstColor}
                    lang={language}
                  />
                  <RadarSpeed
                    config={radarSettings}
                    menu={true}
                    type={2}
                    speed={radarData.lockSpeed}
                    color={radarData.menuSecondColor}
                    lang={language}
                  />
                  <RadarText text={language.Front} />
                </div>
                <img className={style.centerButton} src="./radar/center-button.svg" alt="button" />
                <div className={style.radarTopI}>
                  <RadarSpeed
                    config={radarSettings}
                    direct={"rear"}
                    menu={true}
                    type={1}
                    speed={radarData.rearSpeed}
                    color={radarData.menuFırstColor}
                    lang={language}
                  />
                  <RadarSpeed
                    config={radarSettings}
                    menu={true}
                    type={2}
                    speed={radarData.lockSpeed2}
                    color={radarData.menuSecondColor}
                    lang={language}
                  />
                  <RadarText text={language.Rear} />
                </div>
              </div>
              <div className={style.radarBottom}>
                <div className={style.radarBottomI}>
                  <div className={style.radarPlate}>
                    <RadarPlate plate={radarData.frontPlate} />
                    <RadarText text={language.Front} />
                  </div>
                  <div className={style.radarPlate}>
                    <RadarPlate plate={radarData.rearPlate} />
                    <RadarText text={language.Rear} />
                  </div>
                </div>
                <div className={style.radarBottomI}>
                  <RadarSpeed
                    config={radarSettings}
                    menu={false}
                    type={3}
                    speed={radarData.speed}
                    color={radarData.menuThirdColor}
                    lang={language}
                  />
                  <RadarText text={language.Speed} />
                </div>
              </div>
            </div>
          </Draggable>
        </div>
      </motion.div>
    </>
  )
}

export default Radar
