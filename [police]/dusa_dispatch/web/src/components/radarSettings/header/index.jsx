import s from "./style.module.scss"

function RadarSettingsHeader({ text }) {
  return (
    <div className={s.radarItemHead}>
      <p> {text} </p>
    </div>
  )
}

export default RadarSettingsHeader