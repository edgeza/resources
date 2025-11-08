import s from "./style.module.scss"
import { motion } from "framer-motion"
import { useData } from "../../../../hooks/useData"
import { useLanguage } from "../../../../hooks/useLanguage"
import { postNui } from "../../../../utils/postNui"
import { useNotify } from "../../../../hooks/notify"
function GpsCommon() {
  const { data, setData, uiData, setUiData } = useData()
  const { language } = useLanguage()
  const selected = uiData.dispatch.selectGps
  const active = data.dispatch.activeGps
  const getColor = (job) => {
    if (!data.dispatch.jobColor[job]) return "white"
    return data.dispatch.jobColor[job]
  }
  const hexToRgb = (hex) => {
    if (!hex) return "255,255,255"
    const r = parseInt(hex.slice(1, 3), 16)
    const g = parseInt(hex.slice(3, 5), 16)
    const b = parseInt(hex.slice(5, 7), 16)

    return ` rgb(${r},${g},${b}, 0.17)`
  }
  const connectChannel = () => {
    if (data.dispatch.activeGps !== null) {
      let find = data.dispatch.gpsHeist.find((item) => item.channelId === data.dispatch.activeGps)
      if (find) {
        if (find.users.find((user) => user.citizenId === data.dispatch.citizenId)) {
          // delete user from active gps
          const newGpsHeist = data.dispatch.gpsHeist.map((item) => {
            if (item.channelId === data.dispatch.activeGps) {
              item.users = item.users.filter((user) => user.citizenId !== data.dispatch.citizenId)
            }
            return item
          })
          setData({
            ...data,
            dispatch: {
              ...data.dispatch,
              gpsHeist: newGpsHeist,
              activeGps: null,
            },
          })
          // console.log("deleted from active gps", data.dispatch.activeGps)
          // postNui('disconnectGps', {channel: data.dispatch.activeGps})
        }
      }
    }
    const selectedChannel = data.dispatch.gpsCommon.find((item) => item.item.some((channel) => channel.channelId === selected))

    if (selectedChannel) {
      const channel = selectedChannel.item.find((channel) => channel.channelId === selected)
      
      if (channel) {
        useNotify(language.connectGps)
        postNui("connectGps", {
          channel: channel,
          job: selectedChannel.job,
        })
      }
    }
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        activeGps: selected,
      },
    })
    // postNui("connectGps", { channel: selectedChannel })
  }
  const getActiveButtonId = () => {
    let id = ""
    data.dispatch.gpsCommon.forEach((item) => {
      item.item.forEach((channel) => {
        if (channel.channelId === data.dispatch.activeGps && channel.channelId === selected) {
          id = item.id
        }
      })
    })
    return id
  }
  return (
    <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }} className={s.body}>
      {data.dispatch.gpsCommon.map((item, index) => (
        <div key={index} className={s.common}>
          <div className={s.title} style={{ backgroundColor: hexToRgb(getColor(item.job)) }}>
            {" "}
            <h3 style={{ color: getColor(item.job) }}>{item.title}</h3>
          </div>
          <div className={s.commonList}>
            {item.item.map((channel, index) => (
              <div
                key={index}
                className={`${s.item} ${selected == channel.channelId && s.active} ${active == channel.channelId && s.connect} `}
                onClick={() => {
                  if (selected == channel.channelId) {
                    setUiData({
                      ...uiData,
                      dispatch: {
                        ...uiData.dispatch,
                        selectGps: "",
                      },
                    })
                    return
                  }
                  setUiData({
                    ...uiData,
                    dispatch: {
                      ...uiData.dispatch,
                      selectGps: channel.channelId,
                    },
                  })
                }}
              >
                <p>{channel.name}</p>
              </div>
            ))}
          </div>
          {getActiveButtonId() == item.id ? (
            <div
              className={s.commonConnect}
              onClick={() => {
                useNotify(language.leftGps)
                postNui("disconnectGps", { channel: selected })
                setData({
                  ...data,
                  dispatch: {
                    ...data.dispatch,
                    activeGps: null,
                  },
                })
              }}
              style={{ backgroundColor: getColor(item.job) }}
            >
              <p> {language.disconnectChannel} </p>
            </div>
          ) : (
            <div
              className={s.commonConnect}
              onClick={() => {
                if (selected == "") return
                connectChannel()
              }}
              style={{ backgroundColor: getColor(item.job) }}
            >
              <p> {language.connectChannel} </p>
            </div>
          )}
        </div>
      ))}
    </motion.div>
  )
}

export default GpsCommon
