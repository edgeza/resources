import s from "./style.module.scss"
import { motion } from "framer-motion"
import { useState } from "react"
import { useLanguage } from "../../../../hooks/useLanguage"
import { randomId } from "../../../../utils/misc"
import { useData } from "./../../../../hooks/useData"
import { postNui } from "../../../../utils/postNui"
import { useNotify } from "../../../../hooks/notify"

function GpsCreate() {
  const [channelName, setChannelName] = useState("")
  const [everyone, setEveryone] = useState(false)
  const { language } = useLanguage()
  const { data, setData } = useData()
  const handleName = (e) => {
    setChannelName(e.target.value)
  }
  const handleEveryone = () => {
    setEveryone(!everyone)
  }
  const handleCreate = () => {
    if (channelName.length > 0) {
      let newChannel = {
        name: channelName,
        everyone: everyone,
        owner: data.dispatch.name,
        ownerJob: data.dispatch.job,
        ownerJobRank: data.dispatch.jobRank,
        ownerCitizen: data.dispatch.citizenId,
        channelId: randomId(),
        users: [],
      }
      setData({
        ...data,
        dispatch: {
          ...data.dispatch,
          gpsHeist: [...data.dispatch.gpsHeist, newChannel],
        },
      })
      useNotify(language.createGps)
      postNui("createGps", { created: newChannel })
      setChannelName("")
      setEveryone(false)
    }
  }
  const getButtonColor = () => {
    if (data.dispatch.job === "ambulance") {
      return "#ff3939"
    } else {
      return "#1fa2ec"
    }
  }
  return (
    <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }} className={s.body}>
      <div className={s.input}>
        <p> {language.gpsName} </p>
        <input onChange={handleName} value={channelName} placeholder={language.enterName} type="text" />
      </div>
      <div className={s.button}>
        <div className={s.buttonInner} onClick={handleEveryone}>
          <motion.div
            animate={{ left: everyone ? "3.2vw" : "0.3vw", background: everyone ? getButtonColor() : "#fff" }}
            className={s.buttonCircle}
          ></motion.div>
        </div>
        <p> {language.everyone} </p>
      </div>
      <div className={s.create} onClick={handleCreate}>
        <p> {language.createChannel} </p>
      </div>
    </motion.div>
  )
}

export default GpsCreate
