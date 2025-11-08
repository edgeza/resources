import { useData } from "../../../../hooks/useData"
import { useState } from "react"
import s from "./style.module.scss"
import { motion } from "framer-motion"
import { useLanguage } from "../../../../hooks/useLanguage"
import { postNui } from "../../../../utils/postNui"
import { useNotify } from "../../../../hooks/notify"

function SettingsUnit({ activeSettings, setMenu }) {
  const { data, setData } = useData()
  const [name, setName] = useState(activeSettings.name)
  const [maxCount, setMaxCount] = useState(activeSettings.maxCount)
  const { language } = useLanguage()
  const handleName = (e) => {
    setName(e.target.value)
  }
  const handleMaxCount = (e) => {
    setMaxCount(e.target.value)
  }
  const handleSave = () => {
    if (name.length <= 2 || maxCount <= 0) return
    let newList = [...data.dispatch.unitList]
    let index = newList.indexOf(activeSettings)
    newList[index].name = name
    newList[index].maxCount = maxCount
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        unitList: newList,
      },
    })
    setName("")
    setMaxCount("")
    setMenu("units")
    useNotify(language.unitSaved)
  }
  const handleDelete = () => {
    let newList = [...data.dispatch.unitList]
    let newUserList = [...data.dispatch.unitUserList]
    let newDispatchList = [...data.dispatch.dispatchList]
    let index = newList.indexOf(activeSettings)
    newList[index].userList.map((item) => {
      newUserList.push(item)
    })
    newDispatchList.map((item) => {
      item.userList.map((unit) => {
        if (unit.id === activeSettings.id) {
          item.userList.splice(item.userList.indexOf(unit), 1)
        }
      })
    })
    useNotify(language.unitDeleted)
    postNui('removeUnit', {removed: newList[index].id})
    newList.splice(index, 1)
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        unitList: newList,
        unitUserList: newUserList,
        dispatchList: newDispatchList,
      },
    })
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
      className={s.body}
    >
      <div className={s.header}>
        <h3> {language.settingsUnit} </h3>
        <p> {language.settingsUnitDesc} </p>
      </div>
      <div className={s.actions}>
        <div className={s.input}>
          <div className={s.text}>
            <h4> {language.unitName} </h4>
            <p> {language.setaUnitName} </p>
          </div>
          <input
            type="text"
            value={name}
            onChange={handleName}
            placeholder={language.enterName}
          />
        </div>
        <div className={s.input}>
          <div className={s.text}>
            <h4> {language.maxAgents} </h4>
            <p> {language.setaMaxAgents} </p>
          </div>
          <input
            type="number"
            value={maxCount}
            onChange={handleMaxCount}
            placeholder={language.enterMaxAgents}
          />
        </div>
        <div className={s.buttons}>
          <div className={s.create} onClick={handleSave}>
            <p> {language.save} </p>
          </div>
          <div className={s.delete} onClick={handleDelete}>
            <p> {language.deleteUnit} </p>
          </div>
          <div className={s.cancel} onClick={handleCancel}>
            <p> {language.cancel} </p>
          </div>
        </div>
      </div>
    </motion.div>
  )
}

export default SettingsUnit
