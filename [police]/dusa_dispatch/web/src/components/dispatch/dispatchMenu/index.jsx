import s from "./style.module.scss"
import { DndContext, DragOverlay } from "@dnd-kit/core"
import UserItem from "./dragItem"
import DispatchDrop from "./dropItem/index"
import { motion } from "framer-motion"
import { useData } from "../../../hooks/useData"
import { useLanguage } from "../../../hooks/useLanguage"
import { useState } from "react"
import { Menu, Item, useContextMenu } from "react-contexify"

import "react-contexify/dist/ReactContexify.css"
import { postNui } from "../../../utils/postNui"
import { useNotify } from "../../../hooks/notify"

const MENU_ID = "dispatch-menu"
function DispatchMenu() {
  const [search, setSearch] = useState("")
  const [activeDrag, setActiveDrag] = useState(null)
  const { data, setData, uiData, setUiData } = useData()
  const { language } = useLanguage()
  const [activeDrop, setActiveDrop] = useState(null)
  const userList = data.dispatch.userList
  const dispatchList = data.dispatch.dispatchList
  const { show } = useContextMenu({
    id: MENU_ID,
  })
  const handleSearch = (e) => {
    setSearch(e.target.value)
  }
  const handleDragStart = (event) => {
    setActiveDrag(event.active.data.current.item)
  }
  const handleDragEnd = (event) => {
    if (event.over) {
      let find = dispatchList.find((item) => item.dropId === event.over.id)
      if (find) {
        let index = dispatchList.indexOf(find)
        let newList = [...dispatchList]
        newList[index].userList.push(activeDrag)
        activeDrag.active = true
        postNui("joinDispatch", {
          dispatch: newList[index],
          unit: activeDrag,
        })
        setData({
          ...data,
          dispatch: {
            ...data.dispatch,
            dispatchList: newList,
          },
        })
      }
    }
    setActiveDrag(null)
  }
  const deleteDragList = (item, dropId) => {
    let find = dispatchList.find((item) => item.dropId === dropId)
    if (find) {
      let index = dispatchList.indexOf(find)
      let newList = [...dispatchList]
      let userIndex = newList[index].userList.indexOf(item)
      newList[index].userList.splice(userIndex, 1)
      setData({
        ...data,
        dispatch: {
          ...data.dispatch,
          dispatchList: newList,
        },
      })
      // unit userlist
      postNui("leaveDispatch", {
        dispatch: newList[index],
        unit: item,
      })
      item.active = false
    }
  }
  function openMenu(e, item) {
    setActiveDrop(item.dropId)
    show({ event: e })
  }
  function handlePinMap() {
    let find = data.dispatch.dispatchList.find((item) => item.dropId === activeDrop)
    if (find) {
      useNotify(language.markedMap)
      postNui("setMapMarker", find.coords)
    }
  }
  function handleRemove() {
    let find = data.dispatch.dispatchList.find((item) => item.dropId === activeDrop)
    if (find) {
      let index = data.dispatch.dispatchList.indexOf(find)
      let newList = [...data.dispatch.dispatchList]
      find.userList.forEach((item) => {
        item.active = false
      })
      newList.splice(index, 1)
      setData({
        ...data,
        dispatch: {
          ...data.dispatch,
          dispatchList: newList,
        },
      })
    }
  }
  function handleJoin() {
    let find = data.dispatch.dispatchList.find((item) => item.dropId === activeDrop)
    if (find) {
      let newUserList = [...data.dispatch.userList]
      let findPlayer = data.dispatch.userList.find((item) => item.citizenId === data.dispatch.citizenId)
      if (findPlayer) {
        let index = data.dispatch.userList.indexOf(findPlayer)
        newUserList.splice(index, 1)
      }
      let index = data.dispatch.dispatchList.indexOf(find)
      let newList = [...data.dispatch.dispatchList]
      newList.forEach((item) => {
        let findPlayer = item.userList.find((item) => item.citizenId === data.dispatch.citizenId)
        if (findPlayer) {
          let index = item.userList.indexOf(findPlayer)
          item.userList.splice(index, 1)
        }
      })
      let playerData = {
        name: data.dispatch.name,
        citizenId: data.dispatch.citizenId,
        job: data.dispatch.job,
        jobRank: data.dispatch.jobRank,
        gameId: data.dispatch.gameId,
      }
      newList[index].userList.push(playerData)
      setData({
        ...data,
        dispatch: {
          ...data.dispatch,
          dispatchList: newList,
          userList: newUserList,
        },
      })
    }
  }
  function handleCheckJoin() {
    let find = data.dispatch.dispatchList.find((item) => item.dropId === activeDrop)
    if (find) {
      let findPlayer = find.userList.find((item) => item.citizenId === data.dispatch.citizenId)
      if (findPlayer) {
        return true
      }
    }
    return false
  }
  function handleLeave() {
    let find = data.dispatch.dispatchList.find((item) => item.dropId === activeDrop)
    if (find) {
      let index = data.dispatch.dispatchList.indexOf(find)
      let newList = [...data.dispatch.dispatchList]
      let newUserList = [...data.dispatch.userList]
      newList.forEach((item) => {
        let findPlayer = item.userList.find((item) => item.citizenId === data.dispatch.citizenId)
        if (findPlayer) {
          let index = item.userList.indexOf(findPlayer)
          newUserList.push(findPlayer)
          item.userList.splice(index, 1)
        }
      })
      setData({
        ...data,
        dispatch: {
          ...data.dispatch,
          dispatchList: newList,
          userList: newUserList,
        },
      })
    }
  }
  function getUnitsLength() {
    let count = 0
    data.dispatch.unitList.forEach((item) => {
      if (item.userList.length > 0 && !item.active) {
        count++
      }
    })
    return count
  }
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className={`${s.body} ${data.dispatch.job === "police" ? s.police : s.ambulance}`}
    >
      <Menu id={MENU_ID} style={{ pointerEvents: "all" }}>
        <Item onClick={handlePinMap}>📍 Mark Map</Item>
        {data.dispatch.jobAcces.dispatchEdit && <Item onClick={handleRemove}>🗑️ Remove</Item>}
      </Menu>
      <DndContext onDragStart={handleDragStart} onDragEnd={handleDragEnd}>
        <motion.div
          animate={{
            height: uiData.dispatch.menuVisible.dispatchPlayers ? "70%" : "10%",
          }}
          style={{
            display: !data.dispatch.jobAcces.dispatchEdit && "none",
          }}
          className={`${s.menu} ${s.userList} `}
        >
          <div className={s.menuHead}>
            <h3> {language.availableUnits} </h3>
            <p>
              {getUnitsLength()} {language.unitsFound}
            </p>
            <div className={s.headBorder}></div>
            <div className={s.smallIcon}>
              <motion.img
                animate={{
                  rotate: uiData.dispatch.menuVisible.dispatchPlayers ? 180 : 0,
                }}
                onClick={() => {
                  setUiData({
                    ...uiData,
                    dispatch: {
                      ...uiData.dispatch,
                      menuVisible: {
                        ...uiData.dispatch.menuVisible,
                        dispatchPlayers: !uiData.dispatch.menuVisible.dispatchPlayers,
                      },
                    },
                  })
                }}
                src="./collapse.svg"
                alt="collapse"
              />
            </div>
          </div>
          <div className={s.userListSearch}>
            <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 11 11" fill="none">
              <path
                d="M7.61516 4.65554C7.61516 5.24109 7.44147 5.81349 7.11607 6.30036C6.79066 6.78722 6.32814 7.16669 5.78701 7.39077C5.24588 7.61485 4.65043 7.67348 4.07597 7.55925C3.5015 7.44501 2.97382 7.16304 2.55966 6.74899C2.14549 6.33495 1.86344 5.80742 1.74917 5.23312C1.63491 4.65882 1.69355 4.06355 1.9177 3.52257C2.14184 2.98159 2.52142 2.51921 3.00842 2.19389C3.49543 1.86858 4.068 1.69494 4.65372 1.69494C5.43914 1.69494 6.19239 2.00686 6.74777 2.56208C7.30315 3.1173 7.61516 3.87034 7.61516 4.65554ZM10.8759 10.876C10.8366 10.9153 10.79 10.9465 10.7386 10.9678C10.6873 10.989 10.6322 11 10.5766 11C10.521 11 10.466 10.989 10.4146 10.9678C10.3632 10.9465 10.3166 10.9153 10.2773 10.876L7.62997 8.22887C6.70933 8.99456 5.52887 9.37596 4.33412 9.29374C3.13938 9.21153 2.02232 8.67202 1.21531 7.78745C0.408305 6.90287 -0.026531 5.74133 0.00125404 4.54442C0.0290391 3.34752 0.517306 2.20739 1.36449 1.36119C2.21168 0.514998 3.35257 0.0278792 4.54984 0.00116001C5.74712 -0.0255592 6.90861 0.410178 7.79272 1.21774C8.67684 2.02529 9.21551 3.1425 9.29669 4.33698C9.37788 5.53146 8.99532 6.71124 8.2286 7.63093L10.8759 10.2775C10.9153 10.3168 10.9465 10.3634 10.9678 10.4148C10.989 10.4661 11 10.5211 11 10.5767C11 10.6323 10.989 10.6873 10.9678 10.7387C10.9465 10.79 10.9153 10.8367 10.8759 10.876ZM4.65372 8.46202C5.40678 8.46202 6.14294 8.23877 6.76909 7.82051C7.39524 7.40225 7.88327 6.80776 8.17145 6.11221C8.45964 5.41667 8.53504 4.65132 8.38813 3.91293C8.24121 3.17455 7.87857 2.4963 7.34607 1.96395C6.81358 1.43161 6.13513 1.06907 5.39654 0.922201C4.65794 0.775327 3.89236 0.850708 3.19662 1.13881C2.50088 1.42691 1.90622 1.9148 1.48784 2.54077C1.06945 3.16674 0.846143 3.90269 0.846143 4.65554C0.847263 5.66473 1.24878 6.63228 1.96259 7.34589C2.67641 8.0595 3.64423 8.4609 4.65372 8.46202Z"
                fill="#959595"
              />
            </svg>
            <input type="text" value={search} onChange={handleSearch} placeholder={language.searchUser} />
          </div>
          <div className={s.dragList}>
            {data.dispatch.unitList.map((item, index) => {
              if (item.name.toLowerCase().includes(search.toLowerCase())) {
                return item.userList.length > 0 && !item.active ? <UserItem key={index} item={item} active={activeDrag} /> : null
              }
            })}
          </div>
          <DragOverlay>{activeDrag && <UserItem item={activeDrag} />}</DragOverlay>
        </motion.div>
        <motion.div
          animate={{
            height: uiData.dispatch.menuVisible.dispatchMenu ? "90%" : "10%",
          }}
          className={s.menu}
        >
          <div className={s.menuHead}>
            <div className={s.headBorder}></div>
            <div className={s.smallIcon}>
              <motion.img
                animate={{
                  rotate: uiData.dispatch.menuVisible.dispatchMenu ? 180 : 0,
                }}
                onClick={() => {
                  setUiData({
                    ...uiData,
                    dispatch: {
                      ...uiData.dispatch,
                      menuVisible: {
                        ...uiData.dispatch.menuVisible,
                        dispatchMenu: !uiData.dispatch.menuVisible.dispatchMenu,
                      },
                    },
                  })
                }}
                src="./collapse.svg"
                alt="collapse"
              />
            </div>
          </div>
          <div className={s.dropList}>
            {dispatchList.map((item, index) => {
              return <DispatchDrop key={index} item={item} deleteItem={deleteDragList} openMenu={openMenu} />
            })}
          </div>
        </motion.div>
      </DndContext>
    </motion.div>
  )
}

export default DispatchMenu
