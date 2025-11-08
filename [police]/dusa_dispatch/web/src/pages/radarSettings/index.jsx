import s from "./style.module.scss"
import { useEffect } from "react"
import { useData } from "./../../hooks/useData"
import { useLanguage } from "./../../hooks/useLanguage"
import RadarSettingsHeader from "./../../components/radarSettings/header/index"
import RadarSettingsItem from "./../../components/radarSettings/item/index"
import { useRoute } from "./../../hooks/useRoute"
import { postNui } from "./../../utils/postNui"

function RadarSettings() {
  const { data, setData } = useData()
  const { language } = useLanguage()
  const { route, navigateTo } = useRoute()
  const handleRearXmıt = () => {
    setData({
      ...data,
      radarSettings: {
        ...data.radarSettings,
        rearXmıt: !data.radarSettings.rearXmıt,
      },
    })
    postNui("radarAction", { type: "rear_xmit", action: !data.radarSettings.rearXmıt })
  }
  const handeRearAntene = (type) => {
    if (type === "same") {
      setData({
        ...data,
        radarSettings: {
          ...data.radarSettings,
          rearSame: true,
          rearOpp: false,
        },
      })
      postNui("radarAction", { type: "rear_mode", action: "same" })
    }
    if (type === "opp") {
      setData({
        ...data,
        radarSettings: {
          ...data.radarSettings,
          rearOpp: true,
          rearSame: false,
        },
      })
      postNui("radarAction", { type: "rear_mode", action: "opp" })
    }
  }
  const handleFrontXmıt = () => {
    setData({
      ...data,
      radarSettings: {
        ...data.radarSettings,
        frontXmıt: !data.radarSettings.frontXmıt,
      },
    })
    postNui("radarAction", { type: "front_xmit", action: !data.radarSettings.frontXmıt })
  }
  const handleFrontAntene = (type) => {
    if (type === "same") {
      setData({
        ...data,
        radarSettings: {
          ...data.radarSettings,
          frontSame: true,
          frontOpp: false,
        },
      })
      postNui("radarAction", { type: "front_mode", action: "same" })
    }
    if (type === "opp") {
      setData({
        ...data,
        radarSettings: {
          ...data.radarSettings,
          frontOpp: true,
          frontSame: false,
        },
      })
      postNui("radarAction", { type: "front_mode", action: "opp" })
    }
  }
  const handleLockSpeed = (e) => {
    setData({
      ...data,
      radar: {
        ...data.radar,
        lockSpeed: e.target.value,
      },
    })
    postNui("radarAction", { type: "speed_limit", action: e.target.value })
  }
  const handleLockSpeed2 = (e) => {
    setData({
      ...data,
      radar: {
        ...data.radar,
        lockSpeed2: e.target.value,
      },
    })
    postNui("radarAction", { type: "speed_limit2", action: e.target.value })
  }
  const handleReset = () => {
    setData({
      ...data,
      radar: {
        ...data.radar,
        lockSpeed: 0,
        lockSpeed2: 0,
      },
    })
  }
  const handleToggleRadar = () => {
    setData({
      ...data,
      radarSettings: {
        ...data.radarSettings,
        toogle: !data.radarSettings.toogle,
      },
    })
    postNui("radarAction", { type: "toggle_radar", action: !data.radarSettings.toogle })
  }
  const handlePlateLock = () => {
    setData({
      ...data,
      radarSettings: {
        ...data.radarSettings,
        lock: !data.radarSettings.lock,
      },
    })
    postNui("radarAction", { type: "lock", action: !data.radarSettings.lock })
  }
  const handleEditRadar = () => {
    setData({
      ...data,
      radar: {
        ...data.radar,
        toolbar: true,
      },
    })
    navigateTo("radar")
  }
  useEffect(() => {
    window.addEventListener("keydown", (e) => {
      if (e.key === "Escape") {
        navigateTo("")
        postNui("closeNuiFocus")
      }
    })
    return () => {
      window.removeEventListener("keydown", (e) => {
        if (e.key === "Escape") {
          navigateTo("")
          postNui("closeNuiFocus")
        }
      })
    }
  }, [])
  return (
    <div className={s.body}>
      <div className={s.radarBody}>
        <div className={s.radarHead}>
          <h1> {language.radarSettings} </h1>
          <p> {language.radarDec} </p>
        </div>
        <div className={s.radarItem}>
          <RadarSettingsHeader text={language.frontAntena} />
          <RadarSettingsItem
            type={"onoff"}
            onChange={handleFrontXmıt}
            title={language.XMIT}
            description={language.turnOnOff}
            value={data.radarSettings.frontXmıt}
          />
          <RadarSettingsItem
            type={"button"}
            onChange={handleFrontAntene}
            title={language.antennaScan}
            description={language.turnOnOff}
            value={[data.radarSettings.frontSame, data.radarSettings.frontOpp]}
          />
          <RadarSettingsItem
            type={"input"}
            onChange={handleLockSpeed}
            title={language.fastLimit}
            description={language.enterValue}
            value={data.radar.lockSpeed}
          />
        </div>
        <div className={s.radarItem}>
          <RadarSettingsHeader text={language.rearAntena} />
          <RadarSettingsItem
            type={"onoff"}
            onChange={handleRearXmıt}
            title={language.XMIT}
            description={language.turnOnOff}
            value={data.radarSettings.rearXmıt}
          />
          <RadarSettingsItem
            type={"button"}
            onChange={handeRearAntene}
            title={language.antennaScan}
            description={language.turnOnOff}
            value={[data.radarSettings.rearSame, data.radarSettings.rearOpp]}
          />
          <RadarSettingsItem
            type={"input"}
            onChange={handleLockSpeed2}
            title={language.fastLimit}
            description={language.enterValue}
            value={data.radar.lockSpeed2}
          />
        </div>
        <div className={s.radarItem}>
          <RadarSettingsHeader text={language.misc} />
          <RadarSettingsItem
            type={"onoff"}
            onChange={handleToggleRadar}
            title={language.toggleRadar}
            description={language.turnOnOff}
            value={data.radarSettings.toogle}
          />
          <RadarSettingsItem
            type={"reset"}
            onChange={handleReset}
            title={language.fasLimitReset}
            description={language.resetSettings}
            buttonText={language.reset}
          />
          <RadarSettingsItem
            type={"reset"}
            onChange={handleEditRadar}
            title={language.editRadar}
            description={language.customizableRadar}
            buttonText={language.edit}
          />
          <RadarSettingsItem
            type={"onoff"}
            onChange={handlePlateLock}
            title={language.plateLock}
            description={language.turnOnOff}
            value={data.radarSettings.lock}
          />
        </div>
      </div>
    </div>
  )
}

export default RadarSettings
