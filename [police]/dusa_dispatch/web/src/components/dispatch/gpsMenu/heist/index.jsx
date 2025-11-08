import s from "./style.module.scss"
import { useState } from "react"
import { motion } from "framer-motion"
import { useData } from "../../../../hooks/useData"
import { useLanguage } from "../../../../hooks/useLanguage"
import { Menu, Item, useContextMenu } from "react-contexify"

import "react-contexify/dist/ReactContexify.css"
import { postNui } from "../../../../utils/postNui"
import { useNotify } from "../../../../hooks/notify"

const MENU_ID = "gps-heist-menu"

function GpsHeist() {
  const { data, setData, uiData, setUiData } = useData()
  const [ownerMenu, setOwnerMenu] = useState(false)
  const [userConnected, setUserConnected] = useState(false)
  const [activeChannel, setActiveChannel] = useState("")
  const dispatchUserCitizen = data.dispatch.citizenId
  const { language } = useLanguage()
  const { show } = useContextMenu({
    id: MENU_ID,
  })
  function checkConnected(item) {
    let find = item.users.find(
      (user) => user.citizenId === dispatchUserCitizen
    )
    if (find) {
      return "rgb(0, 255, 68)"
    } else {
      return "rgba(255, 255, 255, 0.53)"
    }
  }
  function openMenu(e, item) {
    if (item.ownerCitizen === dispatchUserCitizen) {
      setOwnerMenu(true)
    } else {
      setOwnerMenu(false)
    }
    if (
      item.users.find(
        (user) => user.citizenId === dispatchUserCitizen
      )
    ) {
      setUserConnected(true)
    } else {
      setUserConnected(false)
    }
    setActiveChannel(item.channelId)
    show({ event: e })
  }
  function handleJoin() {
    if (data.dispatch.activeGps !== null) {
      let find = data.dispatch.gpsHeist.find(
        (item) => item.channelId === data.dispatch.activeGps
      )
      if (find) {
        if (
          find.users.find(
            (user) => user.citizenId === dispatchUserCitizen
          )
        ) {
          // delete user from active gps
          const newGpsHeist = data.dispatch.gpsHeist.map((item) => {
            if (item.channelId === data.dispatch.activeGps) {
              item.users = item.users.filter(
                (user) => user.citizenId !== dispatchUserCitizen
              )
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
        }
      }
    }
    const newGpsHeist = data.dispatch.gpsHeist.map((item) => {
      if (item.channelId === activeChannel) {
        item.users.push({
          name: data.dispatch.name,
          callSign: data.dispatch.callSign,
          citizenId: dispatchUserCitizen,
          job: data.dispatch.job,
        })
        useNotify(language.joinGps)
        postNui("joinGps", {
          heistChannel: item,
          heistChannelId: item.channelId,
        })
      }
      return item
    })
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        gpsHeist: newGpsHeist,
        activeGps: activeChannel,
      },
    })
  }
  function handleLeave() {
    const newGpsHeist = data.dispatch.gpsHeist.map((item) => {
      if (item.channelId === activeChannel) {
        item.users = item.users.filter(
          (user) => user.citizenId !== dispatchUserCitizen
        )
        useNotify(language.leftGps)
        postNui("leaveGps", {
          heistChannel: item,
          heistChannelId: item.channelId,
        })
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
  }
  function handleRemove() {
    const newGpsHeist = data.dispatch.gpsHeist.filter(
      (item) => item.channelId !== activeChannel
    )
    if (data.dispatch.activeGps === activeChannel) {
      setData({
        ...data,
        dispatch: {
          ...data.dispatch,
          gpsHeist: newGpsHeist,
          activeGps: null,
        },
      })
    } else {
      setData({
        ...data,
        dispatch: {
          ...data.dispatch,
          gpsHeist: newGpsHeist,
        },
      })
    }
    postNui("removeGps", { removed: activeChannel })
  }
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
  const checkEveryone = () => {
    const activeChannelData = data.dispatch.gpsHeist.find(
      (item) => item.channelId === activeChannel
    )
    if (activeChannelData) {
      if (activeChannelData.everyone) {
        return false
      } else {
        const ownerJob = activeChannelData.ownerJob
        if(ownerJob === data.dispatch.job) return false
        else return true
      }
    }
    return true
  }

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className={s.body}
    >
      <Menu id={MENU_ID}>
        {!userConnected && <Item onClick={handleJoin} disabled={checkEveryone}>✔️ Join</Item>}
        {userConnected && <Item onClick={handleLeave}>❌ Leave</Item>}
        {ownerMenu && <Item onClick={handleRemove}>🗑️ Remove</Item>}
      </Menu>
      {data.dispatch.gpsHeist.map((item, index) => (
        <div
          key={index}
          className={s.item}
          onContextMenu={(e) => {
            openMenu(e, item)
          }}
        >
          <div
            className={s.title}
            style={{ color: checkConnected(item) }}
          >
            {item.name}
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="79"
              height="88"
              viewBox="0 0 79 88"
              fill="none"
            >
              <path
                d="M0.25 -3L0.250004 93M6.25 -3L6.25 93M12.25 -3L12.25 93M18.25 -3L18.25 93M24.25 -3L24.25 93M30.25 -3L30.25 93M36.25 -3L36.25 93M42.25 -3L42.25 93M48.25 -3L48.25 93M54.25 -3L54.25 93M60.25 -3L60.25 93M66.25 -3L66.25 93M72.25 -3L72.25 93M78.25 -3L78.25 93"
                stroke="white"
                strokeOpacity="0.04"
                strokeWidth="0.5"
              />
            </svg>
          </div>
          <div className={s.userList}>
            {item.users.map((user, index) => (
              <div key={index} className={s.user}>
                <div
                  className={s.border}
                  style={{ backgroundColor: getColor(user.job) }}
                ></div>
                <div className={s.name}>
                  <p> {user.name} </p>
                </div>
                <div
                  className={s.callsign}
                  style={{
                    backgroundColor: hexToRgb(getColor(user.job)),
                    color: getColor(user.job),
                  }}
                >
                  <p> #{user.callSign} </p>
                </div>
              </div>
            ))}
          </div>
        </div>
      ))}
    </motion.div>
  )
}

export default GpsHeist
