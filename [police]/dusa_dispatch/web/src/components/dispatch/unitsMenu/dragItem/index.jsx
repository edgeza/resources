import s from "./style.module.scss"
import { useData } from "../../../../hooks/useData"
import { useDraggable } from "@dnd-kit/core"

function UnitUserItem({ item, active }) {
  const { data } = useData()
  const { attributes, listeners, setNodeRef } = useDraggable({
    id: item.citizenId,
    data: { item: item },
  })
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
  return (
    <>
      <div
        ref={setNodeRef}
        {...listeners}
        {...attributes}
        style={{
          backgroundColor: hexToRgb(getColor(item.job)),
        }}
        className={`${s.body} ${active == item && s.activeDrag}`}
      >
        <div
          style={{ backgroundColor: getColor(item.job) }}
          className={s.boder}
        ></div>
        <div className={s.text}>
          <h3 style={{ color: getColor(item.job) }}>{item.name}</h3>
          <p style={{ color: getColor(item.job) }}>{item.jobRank}</p>
        </div>
        <div
          className={s.circle}
          style={{ backgroundColor: getColor(item.job) }}
        ></div>
      </div>
    </>
  )
}

export default UnitUserItem
