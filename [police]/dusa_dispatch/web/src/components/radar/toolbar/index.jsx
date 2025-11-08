import s from "./style.module.scss"
import { useState } from "react"
import { useLanguage } from "../../../hooks/useLanguage"
import { HexColorPicker } from "react-colorful"

function RadarToolBar({
  drag,
  setDrag,
  scale,
  changeScale,
  color,
  changeColor,
  color2,
  changeSecondColor,
  color3,
  changeThirdColor,
  resetSettings,
  saveSettings,
}) {
  const { language } = useLanguage()
  const [colorActive, setColor1] = useState(false)
  const [colorActive2, setColor2] = useState(false)
  const [colorActive3, setColor3] = useState(false)
  return (
    <div className={s.toolBar}>
      <div className={s.toolbarInner}>
        <div
          onClick={() => setDrag((drag = !drag))}
          className={`${s.dragButton} ${
            !drag && s.dragButtonActive
          } `}
        >
          <img src="./radar/drag.svg" alt="drag" />
        </div>
        <div className={s.toolBarScale}>
          <p> {language.size}: </p>
          {/* <input type="number" value={scale} onChange={changeScale} /> */}
          <input min={40} max={110} value={scale} onChange={changeScale} type="range" />
        </div>
        <div className={s.changeColor}>
          <div
            className={s.colorShow}
            style={{ background: color }}
            onClick={() => {
              setColor1(!colorActive)
              setColor2(false)
              setColor3(false)
            }}
          ></div>
          <HexColorPicker
            className={s.colorPicker}
            style={{ visibility: colorActive ? "visible" : "hidden" }}
            color={color}
            onChange={changeColor}
          />
        </div>
        <div className={s.changeColor}>
          <div
            className={s.colorShow}
            style={{ background: color2 }}
            onClick={() => {
              setColor2(!colorActive2)
              setColor1(false)
              setColor3(false)
            }}
          ></div>
          <HexColorPicker
            className={s.colorPicker}
            style={{
              visibility: colorActive2 ? "visible" : "hidden",
            }}
            color={color2}
            onChange={changeSecondColor}
          />
        </div>
        <div className={s.changeColor}>
          <div
            className={s.colorShow}
            style={{ background: color3 }}
            onClick={() => {
              setColor3(!colorActive3)
              setColor1(false)
              setColor2(false)
            }}
          ></div>
          <HexColorPicker
            className={s.colorPicker}
            style={{
              visibility: colorActive3 ? "visible" : "hidden",
            }}
            color={color3}
            onChange={changeThirdColor}
          />
        </div>
        <div onClick={resetSettings} className={s.resetButton}>
            <img src="./radar/reset.svg" alt="reset" />
        </div>
        <div onClick={saveSettings} className={s.resetButton}>
            <img src="./radar/save.svg" alt="save" />
        </div>
      </div>
    </div>
  )
}

export default RadarToolBar
