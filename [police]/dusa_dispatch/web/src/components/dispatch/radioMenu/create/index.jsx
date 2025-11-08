import s from "./style.module.scss"
import { motion } from "framer-motion"
import { useState } from "react"
import { useLanguage } from "../../../../hooks/useLanguage"
import { randomId } from "../../../../utils/misc"
import { useData } from "./../../../../hooks/useData"
import { postNui } from "./../../../../utils/postNui"
import { useNotify } from "../../../../hooks/notify"

function RadioCreate() {
  const [channelName, setChannelName] = useState("")
  const [channelFrequency, setChannelFrequency] = useState("")
  const [alert, setAlert] = useState(false)
  const [everyone, setEveryone] = useState(false)
  const { language } = useLanguage()
  const { data, setData } = useData()
  const handleName = (e) => {
    setChannelName(e.target.value)
  }
  const handleFrequency = (e) => {
    setChannelFrequency(e.target.value)
  }
  const handleEveryone = () => {
    setEveryone(!everyone)
  }
  const handleCreate = () => {
    if (channelName.length > 0) {
      let findChannel = data.dispatch.radioHeist.find((channel) => channel.channelId === channelFrequency)
      if (findChannel) {
        setAlert(true)
        setTimeout(() => {
          setAlert(false)
        }, 6000)
        return
      } else {
        let newChannel = {
          name: channelName,
          everyone: everyone,
          owner: data.dispatch.name,
          ownerJob: data.dispatch.job,
          ownerJobRank: data.dispatch.jobRank,
          ownerCitizen: data.dispatch.citizenId,
          channelId: channelFrequency,
          frequency: channelFrequency,
          users: [],
        }
        setData({
          ...data,
          dispatch: {
            ...data.dispatch,
            radioHeist: [...data.dispatch.radioHeist, newChannel],
          },
        })
        useNotify(language.radioChannelCreated + " " + channelName)
        postNui("createRadio", { created: newChannel })
        setChannelName("")
        setChannelFrequency("")
        setEveryone(false)
      }
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
        <p> {language.radioName} </p>
        <input onChange={handleName} value={channelName} placeholder={language.enterName} type="text" />
      </div>
      <div className={s.input}>
        <p> {language.radioFrequency} </p>
        <input onChange={handleFrequency} value={channelFrequency} placeholder={language.enterFrequency} type="number" />
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
        <p> {language.createFrequency} </p>
      </div>
      <motion.div initial={{ opacity: 0 }} animate={{ opacity: alert ? 1 : 0 }} className={s.alert}>
        <p> {language.frequencyAlert} </p>
      </motion.div>
    </motion.div>
  )
}

export default RadioCreate
