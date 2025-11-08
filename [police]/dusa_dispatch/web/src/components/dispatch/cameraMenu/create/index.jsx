import s from "./style.module.scss"
import React from "react"
import { useLanguage } from "../../../../hooks/useLanguage"
import { useData } from "../../../../hooks/useData"
import { useState } from "react"
import { motion } from "framer-motion"
import { randomId } from "../../../../utils/misc"
import "react-dropdown/style.css"
import { postNui } from "../../../../utils/postNui"

function CreateCamera() {
  const [name, setName] = useState("")
  const [type, setType] = useState("")
  const { data, setData } = useData()
  const { language } = useLanguage()
  const handleName = (e) => {
    setName(e.target.value)
  }
  const handleAdd = () => {
    if (name.length > 3) {
      let id = randomId()
      var camTable = {
        name: name,
        adress: "Los Santos Police Department",
        id: id,
        position: [0, 0],
        camId: id,
        type: type,
      }

      setData({
        ...data,
        dispatch: {
          ...data.dispatch,
          cameraList: [
            ...data.dispatch.cameraList,
            camTable,
          ],
        },
      })
      postNui("createCamera", camTable)
      setName("")
      setType("")
    }
  }
  const handleCancel = () => {
    setName("")
    setType("")
  }
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className={`${s.body} ${
        data.dispatch.job === "police" ? s.police : s.ambulance
      }`}
    >
      <div className={s.header}>
        <h3> {language.addaCamera} </h3>
        <p> {language.addCameraDesc} </p>
      </div>
      <div className={s.main}>
        <div className={s.input}>
          <div className={s.text}>
            <h3> {language.cameraName} </h3>
            <p> {language.setCameraName} </p>
          </div>
          <div className={s.action}>
            <input
              type="text"
              value={name}
              onChange={handleName}
              placeholder={language.enterName}
            />
          </div>
        </div>
        <div className={s.button}>
          <div className={s.add} onClick={handleAdd}>
            <p> {language.add} </p>
          </div>
          <div className={s.cancel} onClick={handleCancel}>
            <p> {language.cancel} </p>
          </div>
        </div>
      </div>
    </motion.div>
  )
}

export default CreateCamera
