import s from "./style.module.scss"
import { useDroppable } from "@dnd-kit/core"
import { useLanguage } from "../../../../hooks/useLanguage"
import { useData } from "../../../../hooks/useData"
import { useDraw } from "../../../../hooks/useDraw"
import { motion } from "framer-motion"
import { useState } from "react"

function DispatchDrop({ item, deleteItem, openMenu }) {
  const { isOver, setNodeRef } = useDroppable({
    id: item.dropId,
    data: item.dropId,
  })
  const { map } = useDraw()
  const [openImage, setOpenImage] = useState(false)
  const dropId = item.dropId
  const { language } = useLanguage()
  const { data, setData, uiData, setUiData } = useData()
  const handleSelect = () => {
    if (item.active) {
      let newList = data.dispatch.dispatchList.map((dispatch) => {
        if (dispatch.id === item.id) {
          dispatch.active = false
        }
        return dispatch
      })
      setData({
        ...data,
        dispatch: {
          ...data.dispatch,
          dispatchList: newList,
        },
      })
      return
    }
    setUiData({
      ...uiData,
      dispatch: {
        ...uiData.dispatch,
        menuVisible: {
          ...uiData.dispatch.menuVisible,
          dispatchPlayers: false,
        },
      },
    })
    let newList = data.dispatch.dispatchList.map((dispatch) => {
      if (dispatch.id === item.id) {
        dispatch.active = true
      } else {
        dispatch.active = false
      }
      return dispatch
    })
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        dispatchList: newList,
      },
    })
    map.current.setView(item.coords, 5)
  }
  return (
    <div
      className={`${s.body} ${isOver && s.activeDrop} ${item.active && s.active} ${
        data.dispatch.job === "police" ? s.police : s.ambulance
      }`}
      ref={setNodeRef}
      onContextMenu={(e) => {
        openMenu(e, item)
      }}
    >
      <div className={s.header}>
        <div className={s.id}>#{item.id}</div>
        <div className={s.time}>{item.time}</div>
        {item.img !== "" && (
          <div className={s.imageIcon} onClick={() => setOpenImage(!openImage)}>
            <img src="./photos-icon.svg" alt="photo" />
          </div>
        )}
        <div className={s.location} onClick={handleSelect}>
          <svg
            fill="#000000"
            height="800px"
            width="800px"
            id="Layer_1"
            xmlns="http://www.w3.org/2000/svg"
            xmlnsXlink="http://www.w3.org/1999/xlink"
            viewBox="0 0 368.666 368.666"
            xmlSpace="preserve"
          >
            <g id="XMLID_2_">
              <g>
                <g>
                  <path d="M184.333,0C102.01,0,35.036,66.974,35.036,149.297c0,33.969,11.132,65.96,32.193,92.515 c27.27,34.383,106.572,116.021,109.934,119.479l7.169,7.375l7.17-7.374c3.364-3.46,82.69-85.116,109.964-119.51 c21.042-26.534,32.164-58.514,32.164-92.485C333.63,66.974,266.656,0,184.333,0z M285.795,229.355 c-21.956,27.687-80.92,89.278-101.462,110.581c-20.54-21.302-79.483-82.875-101.434-110.552 c-18.228-22.984-27.863-50.677-27.863-80.087C55.036,78.002,113.038,20,184.333,20c71.294,0,129.297,58.002,129.296,129.297 C313.629,178.709,304.004,206.393,285.795,229.355z" />
                  <path d="M184.333,59.265c-48.73,0-88.374,39.644-88.374,88.374c0,48.73,39.645,88.374,88.374,88.374s88.374-39.645,88.374-88.374 S233.063,59.265,184.333,59.265z M184.333,216.013c-37.702,0-68.374-30.673-68.374-68.374c0-37.702,30.673-68.374,68.374-68.374 s68.373,30.673,68.374,68.374C252.707,185.341,222.035,216.013,184.333,216.013z" />
                </g>
              </g>
            </g>
          </svg>
        </div>
        <div className={s.priority}>
          {item.priority === "0" ? (
            <div className={s.low}>{language.low}</div>
          ) : item.priority === "1" ? (
            <div className={s.medium}>{language.medium}</div>
          ) : (
            <div className={s.high}>{language.high}</div>
          )}
        </div>
      </div>
      <div className={s.text}>
        <h3> {item.title} </h3>
        <p> {item.description} </p>
      </div>
      {item.img !== "" && (
        <motion.div
          initial={{ height: 0 }}
          animate={{ height: openImage ? "auto" : 0 }}
          transition={{ duration: 0.5 }}
          className={s.image}
        >
          <img src={item.img} alt="dispatch image" />
        </motion.div>
      )}
      <div className={s.dropArea}>
        {item.userList.map((item, index) => {
          return (
            <div key={index} className={s.userItem}>
              <div className={s.boder}></div>
              <div className={s.userText}>
                <h3>{item.name}</h3>
                <p>
                  {item.userList.length} {language.person}{" "}
                </p>
              </div>
              {data.dispatch.jobAcces.dispatchEdit && (
                <div className={s.circle} onClick={() => deleteItem(item, dropId)}>
                  X
                </div>
              )}
            </div>
          )
        })}
      </div>
    </div>
  )
}

export default DispatchDrop
