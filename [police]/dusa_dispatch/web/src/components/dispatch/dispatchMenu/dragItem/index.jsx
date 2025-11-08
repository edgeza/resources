import s from "./style.module.scss"
import { useData } from "../../../../hooks/useData"
import { useLanguage } from "../../../../hooks/useLanguage"
import { useDraggable } from "@dnd-kit/core"

function UserItem({ item, active }) {
  const { data } = useData()
  const { language } = useLanguage()
  const { attributes, listeners, setNodeRef } = useDraggable({
    id: item.id,
    data: { item: item },
  })
  return (
    <>
      <div
        ref={setNodeRef}
        {...listeners}
        {...attributes}
        className={`${s.body} ${active == item && s.activeDrag} ${
          data.dispatch.job === "police" ? s.police : s.ambulance
        }`}
      >
        <div
          className={s.boder}
        ></div>
        <div className={s.text}>
          <h3>{item.name}</h3>
          <p>{item.userList.length} {language.person} </p>
        </div>
        <div
          className={s.circle}
        ></div>
      </div>
    </>
  )
}

export default UserItem
