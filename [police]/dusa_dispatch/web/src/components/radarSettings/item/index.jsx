import s from "./style.module.scss"
import { useLanguage } from "./../../../hooks/useLanguage"

function RadarSettingsItem({
  type,
  title,
  description,
  value,
  onChange,
  buttonText,
}) {
  const { language } = useLanguage()
  return (
    <>
      <div className={s.radarChange}>
        <div className={s.radarText}>
          <h2>{title}</h2>
          <p>{description}</p>
        </div>
        <div className={s.radarAction}>
          {type === "onoff" && (
            <>
              <div className={s.radarSwitch} onClick={onChange}>
                <p className={`${value && s.activeSwitch}`}>
                  {" "}
                  {language.on}{" "}
                </p>
                <p className={`${!value && s.activeSwitch}`}>
                  {language.off}
                </p>
                <div
                  className={`${s.switchItem} ${
                    value && s.switchActive
                  }`}
                ></div>
              </div>
            </>
          )}
          {type === "button" && (
            <>
              <div className={s.radarButton}>
                <div
                  onClick={() => {
                    onChange("same")
                  }}
                  className={` ${s.radarButtonItem} ${
                    value[0] && s.activeButton
                  }`}
                >
                  <p> {language.same} </p>
                </div>
                <div
                  onClick={() => {
                    onChange("opp")
                  }}
                  className={` ${s.radarButtonItem} ${
                    value[1] && s.activeButton
                  }`}
                >
                  <p>{language.OPP} </p>
                </div>
              </div>
            </>
          )}
          {type === "input" && (
            <>
              <div className={s.radarInput}>
                <input
                  type="number"
                  value={value}
                  onChange={onChange}
                />
              </div>
            </>
          )}
          {type === "reset" && (
            <>
              <div className={s.radarReset} onClick={onChange}>
                  { buttonText }
              </div>
            </>
          )}
        </div>
      </div>
    </>
  )
}

export default RadarSettingsItem
