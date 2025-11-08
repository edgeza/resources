import s from "./text.module.scss"

function RadarText({ text }) {
  return (
    <>
      <div className={s.radarText}>
        <img src="./radar/left-arrow.svg" alt="border" />
        <p> {text} </p>
        <img src="./radar/right-arrow.svg" alt="border" />
      </div>
    </>
  )
}

export default RadarText
