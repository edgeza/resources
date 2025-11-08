import s from "./style.module.scss"
import { useState } from "react"
import { useData } from "../../../hooks/useData"
import { useLanguage } from "./../../../hooks/useLanguage"
import { useDraw } from "../../../hooks/useDraw"
import { motion } from "framer-motion"
import { postNui } from "../../../utils/postNui"
import { useNotify } from "../../../hooks/notify"

function DrawMenu() {
  const { data, setData, uiData, setUiData } = useData()
  const { saveData, deleteData } = useDraw()
  const { language } = useLanguage()
  const [activeId, setActive] = useState()
  const [save, setSave] = useState(false)
  const saveAnimation = {
    hidden: { opacity: 0, y: 100, pointerEvents: "none" },
    visible: { opacity: 1, y: 0, pointerEvents: "all" },
  }
  const handleSaveName = (e) => {
    setUiData({
      ...uiData,
      dispatch: {
        ...uiData.dispatch,
        groupTitle: e.target.value,
      },
    })
  }
  const handleSaveDescription = (e) => {
    setUiData({
      ...uiData,
      dispatch: {
        ...uiData.dispatch,
        groupDescription: e.target.value,
      },
    })
  }
  const handleSaveData = () => {
    if (uiData.dispatch.groupTitle === "") return
    useNotify(language.saveDraw)
    saveData()
    setUiData({
      ...uiData,
      dispatch: {
        ...uiData.dispatch,
        groupTitle: "",
        groupDescription: "",
        layerItems: [],
      },
    })
    setSave(false)
  }
  const closeSave = () => {
    setSave(false)
    setUiData({
      ...uiData,
      dispatch: {
        ...uiData.dispatch,
        groupTitle: "",
        groupDescription: "",
      },
    })
  }
  const handleActive = (id) => {
    if (activeId === id) {
      setActive(null)
      return
    }
    setActive(id)
  }
  const handleSave = () => {
    if (uiData.dispatch.layerItems.length === 0) return
    setSave(!save)
    // postNui('createDraw', { created: id })
  }
  const handleDelete = (id) => {
    deleteData(id)
    useNotify(language.deleteDraw)
    postNui('removeDraw', { removed: id })
  }

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{
        opacity: 1,
        height: uiData.dispatch.menuVisible.drawMenu ? "65%" : "15%",
      }}
      exit={{ opacity: 0 }}
      className={`${s.menu} ${
        data.dispatch.job === "police" ? s.police : s.ambulance
      }`}
    >
      <div className={s.menuHead}>
        <div className={s.headBorder}></div>
        <h2>{language.draws}</h2>
        <p>{language.drawsDesc}</p>
        <div className={s.smallIcon}>
          <motion.img
            animate={{
              rotate: uiData.dispatch.menuVisible.drawMenu ? 180 : 0,
            }}
            onClick={() => {
              setUiData({
                ...uiData,
                dispatch: {
                  ...uiData.dispatch,
                  menuVisible: {
                    ...uiData.dispatch.menuVisible,
                    drawMenu: !uiData.dispatch.menuVisible.drawMenu,
                  },
                },
              })
            }}
            src="./collapse.svg"
            alt="collapse"
          />
        </div>
      </div>
      <div className={s.menuBody}>
        {data.dispatch.draw.drawnItems.map((item, index) => {
          return (
            <div
              className={`${s.menuItem} ${
                activeId === item.groupId && s.menuActive
              }`}
              onClick={() => {
                handleActive(item.groupId)
              }}
              key={index}
            >
              <div className={s.itemImg}>
                <img src={item.img} alt="circle" />
              </div>
              <div className={s.itemText}>
                <h3> {item.name} </h3>
                <p> {item.description} </p>
              </div>
              <div className={s.deleteIcon}>
                <img
                  src="./dispatch/delete.svg"
                  alt="delete"
                  onClick={() => {
                    handleDelete(item.groupId)
                  }}
                />
              </div>
            </div>
          )
        })}
      </div>
      <motion.div
        style={{
          pointerEvents: uiData.dispatch.menuVisible.drawMenu
            ? "all"
            : "none",
          opacity: uiData.dispatch.menuVisible.drawMenu ? 1 : 0,
        }}
        className={s.saveButton}
        onClick={handleSave}
      >
        <p> {language.save} </p>
      </motion.div>
      <motion.div
        initial="hidden"
        animate={
          save && uiData.dispatch.menuVisible.drawMenu
            ? "visible"
            : "hidden"
        }
        variants={saveAnimation}
        transition={{ duration: 0.5 }}
        className={s.saveArea}
        style={{
          pointerEvents:
            save && uiData.dispatch.menuVisible.drawMenu
              ? "all"
              : "none",
        }}
      >
        <div className={s.headBorder}></div>
        <input
          type="text"
          onChange={handleSaveName}
          value={uiData.dispatch.groupTitle}
          placeholder={language.title}
        />
        <textarea
          cols="30"
          rows="10"
          onChange={handleSaveDescription}
          value={uiData.dispatch.groupDescription}
          placeholder={language.description}
        ></textarea>
        <div className={s.saveAreaButton}>
          <div onClick={handleSaveData}> {language.save} </div>
          <div onClick={closeSave}> {language.cancel} </div>
        </div>
      </motion.div>
    </motion.div>
  )
}

export default DrawMenu
