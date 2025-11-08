import s from "./style.module.scss"
import { motion } from "framer-motion"
import { useData } from "../../../../hooks/useData"
import { useLanguage } from "../../../../hooks/useLanguage"
import { postNui } from "../../../../utils/postNui"
import { useNotify } from "../../../../hooks/notify"

function RadioCommon() {
  const { data, setData, uiData, setUiData } = useData()
  const { language } = useLanguage()
  const selected = uiData.dispatch.selectRadio
  const active = data.dispatch.activeRadio
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
    if (data.dispatch.activeRadio !== null) {
      let find = data.dispatch.radioHeist.find((item) => item.channelId === data.dispatch.activeRadio)
      if (find) {
        if (find.users.find((user) => user.citizenId === data.dispatch.citizenId)) {
          // delete user from active gps
          const newGpsHeist = data.dispatch.radioHeist.map((item) => {
            if (item.channelId === data.dispatch.activeRadio) {
              item.users = item.users.filter((user) => user.citizenId !== data.dispatch.citizenId)
            }
            return item
          })
          setData({
            ...data,
            dispatch: {
              ...data.dispatch,
              radioHeist: newGpsHeist,
              activeRadio: null,
            },
          })
        }
      }
    }
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        activeRadio: selected,
      },
    })

    const selectedChannel = data.dispatch.radioCommon.find((item) => item.item.some((channel) => channel.channelId === selected))

    if (selectedChannel) {
      const channel = selectedChannel.item.find((channel) => channel.channelId === selected)
      if (channel) {
        useNotify(language.radioChannelConnected + " " + channel.name)
        postNui("connectRadio", {
          channel: channel,
          job: selectedChannel.job,
        })
      }
    }
  }
  const getActiveButtonId = () => {
    let id = ""
    data.dispatch.radioCommon.forEach((item) => {
      item.item.forEach((channel) => {
        if (channel.channelId === data.dispatch.activeRadio && channel.channelId === selected) {
          id = item.id
        }
      })
    })
    return id
  }

  return (
    <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }} className={s.body}>
      {data.dispatch.radioCommon.map((item, index) => (
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
                        selectRadio: "",
                      },
                    })
                    return
                  }
                  setUiData({
                    ...uiData,
                    dispatch: {
                      ...uiData.dispatch,
                      selectRadio: channel.channelId,
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
                setData({
                  ...data,
                  dispatch: {
                    ...data.dispatch,
                    activeRadio: "0 MHz",
                  },
                });
                useNotify(language.radioChannelDisconnected);
                postNui('leaveRadio');
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

export default RadioCommon
