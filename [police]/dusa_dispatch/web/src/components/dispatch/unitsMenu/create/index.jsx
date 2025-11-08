import { useData } from "../../../../hooks/useData"
import { useState } from "react"
import s from "./style.module.scss"
import { motion } from "framer-motion"
import { useLanguage } from "../../../../hooks/useLanguage"
import { randomId } from "../../../../utils/misc"
import { postNui } from "../../../../utils/postNui"
import { useNotify } from "../../../../hooks/notify"
function CreateUnit({ setMenu }) {
  const { data, setData } = useData()
  const [name, setName] = useState("")
  const [maxCount, setMaxCount] = useState()
  const { language } = useLanguage()

  const handleName = (e) => {
    setName(e.target.value)
  }
  const handleMaxCount = (e) => {
    setMaxCount(e.target.value)
  }
  const handleCreate = () => {
    if (name.length <= 2 || maxCount <= 0) return
    let newList = [...data.dispatch.unitList]
    let createUnit = {
      name: name,
      maxCount: maxCount,
      active: false,
      userList: [],
      id: randomId(),
      dropId: randomId(),
    }
    newList.push(createUnit)
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        unitList: newList,
      },
    })
    useNotify(language.unitCreated + " " + name)
    postNui("createUnit", { created: createUnit, table: newList })
    setName("")
    setMaxCount("")
    setMenu("units")
  }
  const handleCancel = () => {
    setName("")
    setMaxCount("")
    setMenu("units")
  }
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className={`${s.body} ${data.dispatch.job === "police" ? s.police : s.ambulance}`}
    >
      <div className={s.header}>
        <h3> {language.createUnit} </h3>
        <p> {language.createUnitDesc} </p>
      </div>
      <div className={s.actions}>
        <div className={s.input}>
          <div className={s.text}>
            <h4> {language.unitName} </h4>
            <p> {language.setaUnitName} </p>
          </div>
          <input type="text" value={name} placeholder={language.enterName} onChange={handleName} />
        </div>
        <div className={s.input}>
          <div className={s.text}>
            <h4> {language.maxAgents} </h4>
            <p> {language.setaMaxAgents} </p>
          </div>
          <input type="number" value={maxCount} placeholder={language.enterMaxAgents} onChange={handleMaxCount} />
        </div>
        <div className={s.buttons}>
          <div className={s.create} onClick={handleCreate}>
            <p> {language.create} </p>
          </div>
          <div className={s.cancel} onClick={handleCancel}>
            <p> {language.cancel} </p>
          </div>
        </div>
      </div>
    </motion.div>
  )
}

export default CreateUnit
