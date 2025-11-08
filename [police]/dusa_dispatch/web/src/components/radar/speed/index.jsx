import React from "react"
import s from "./speed.module.scss"

function RadarSpeed({ config, direct, menu, type, speed, color, lang }) {
  let same
  let opp
  let xmıt
  if(direct === "front") {
    same = config.frontSame
    opp = config.frontOpp
    xmıt = config.frontXmıt
  } else {
    same = config.rearSame
    opp = config.rearOpp
    xmıt = config.rearXmıt
  }
  return (
    <>
      <div className={s.speedMain}>
        {menu && (
          <div className={s.menuCont}>
            {type === 1 && (
              <>
                <p style={{ color: color, opacity: same ? "1" : "0.3" }}>{lang.same}</p>
                <p style={{ color: color, opacity: opp ? "1" : "0.3" }}>{lang.OPP}</p>
                <p style={{ color: color, opacity: xmıt ? "1" : "0.3" }}>{lang.XMIT}</p>
              </>
            )}
            {type === 2 && (
              <>
                <p style={{ color: color, opacity: config.lock ? "1" : "0.3" }}>{lang.Lock}</p>
                <p style={{ color: color, opacity: config.fast ? "1" : "0.3" }}>{lang.Fast}</p>
              </>
            )}
          </div>
        )}
        <div
          className={s.speedCont}
          style={{
            width: type === 3 ? "12vw" : "",
          }}
        >
          <h2
            style={{
              color: color,
              textShadow: `0px 0px 17.072px ${color}`,
            }}
          >
            {speed}
          </h2>
        </div>
      </div>
    </>
  )
}

export default RadarSpeed
