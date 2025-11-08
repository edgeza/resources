import { React } from "react"
import { useData } from "./../../hooks/useData"
import { useNuiEvent } from "../../hooks/useNuiEvent"
import { randomId } from "../../utils/misc"
import { ToastContainer, toast, Bounce } from "react-toastify"
import "react-toastify/dist/ReactToastify.css"
import gsap from "gsap"
import s from "./style.module.scss"

function Notify() {
  const { data } = useData()
  useNuiEvent("NOTIFY", (text) => {
    toast.info(text.description , {
      position: "top-right",
      autoClose: data.notifyDeleteTime,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
      theme: "dark",
      transition: Bounce,
    })
  })

  return (
    <div>
      <ToastContainer pauseOnFocusLoss={false} />
    </div>
  )
}

export default Notify
