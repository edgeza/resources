import React from "react" // Add the missing import statement for React
import s from "./style.module.scss"
import { useData } from "../../hooks/useData"
import { useLanguage } from "./../../hooks/useLanguage"
import { useNuiEvent } from "./../../hooks/useNuiEvent"

function BodyCam() {
  const { data, setData } = useData()
  const { language } = useLanguage()

  useNuiEvent("UPDATE_BODYCAM", (newData)=>{
    setData((prev) => ({
      ...prev,
      bodyCam: newData
    }))
  })

  useNuiEvent("UPDATE_BODYCAM_CLOCK", (newData)=>{
    setData((prev) => ({
      ...prev,
      bodyCam: {
        ...prev.bodyCam,
        clock: newData
      }
    }))
  })

  useNuiEvent("UPDATE_BODYCAM_JOB", (newData)=>{
    setData((prev) => ({
      ...prev,
      bodyCam: {
        ...prev.bodyCam,
        job: newData
      }
    }))
  })

  return (
    <div className={`${s.body} ${s[data.bodyCam.theme]}`}>
      <div className={s.bodyItem}>
        <div className={s.itemBorder}></div>
        <div className={s.logo}>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="154"
            height="129"
            viewBox="0 0 154 129"
            fill="none"
          >
            <path
              d="M157.061 120.979C157.599 121.518 158.461 120.872 158.139 120.225L89.0831 0.861528C88.6531 5.69513e-07 87.8983 0 87.4683 0C87.0368 0 86.3918 0.214988 86.0669 1.07652L70.3381 53.8638C67.8618 62.159 74.0024 70.4542 82.6208 70.4542H98.4564C107.613 70.4542 116.34 74.4401 122.372 81.3339L157.061 120.979Z"
              fill="#FF4646"
            />
            <path
              d="M59.4588 57.3111L71.74 16.2667C71.9565 15.5119 70.9867 15.0803 70.5552 15.7269L0.207691 137.569C-0.223869 138.432 0.100998 139.077 0.424269 139.508C0.745949 139.938 1.39408 140.37 2.36231 139.938L2.57889 139.831L64.9528 116.885C72.3865 114.084 75.6176 105.358 71.6333 98.3555L62.3683 82.1951C57.9507 74.6563 56.8726 65.6063 59.4588 57.3111Z"
              fill="#FF4646"
            />
            <path
              d="M165.357 149.098C166.218 149.098 166.65 148.451 166.865 148.128C166.973 147.805 167.188 147.05 166.65 146.405L119.68 92.5397C113.863 85.8608 103.305 86.9374 98.8888 94.5876L89.947 110.1C86.176 116.562 80.3587 121.411 73.3566 123.996L7.96493 147.913C7.31839 148.128 7.42668 149.098 8.17992 149.098H165.357Z"
              fill="#FF4646"
            />
          </svg>
        </div>
        <div className={s.itemText}>
          <div className={s.top}>
            <p> {language.rec} </p>
            <div className={s.circle}></div>
          </div>
          <div className={s.center}>
            <div className={s.centerBorder}>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="9"
                height="9"
                viewBox="0 0 9 9"
                fill="none"
              >
                <path
                  d="M1 9V3C1 1.89543 1.89543 1 3 1H8.5"
                  stroke="#FF4646"
                />
              </svg>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="9"
                height="9"
                viewBox="0 0 9 9"
                fill="none"
              >
                <path
                  d="M0 1.25L6 1.25C7.10457 1.25 8 2.14543 8 3.25L8 8.75"
                  stroke="#FF4646"
                />
              </svg>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="9"
                height="9"
                viewBox="0 0 9 9"
                fill="none"
              >
                <path
                  d="M9 7.75L3 7.75C1.89543 7.75 1 6.85457 1 5.75L1 0.25"
                  stroke="#FF4646"
                />
              </svg>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="8"
                height="9"
                viewBox="0 0 8 9"
                fill="none"
              >
                <path
                  d="M7.5 0L7.5 6C7.5 7.10457 6.60457 8 5.5 8L0 8"
                  stroke="#FF4646"
                />
              </svg>
            </div>
            <div>
              {" "}
              {data.bodyCam.name} | {data.bodyCam.code}{" "}
            </div>
            <div> {data.bodyCam.adress} </div>
            <div>
              {" "}
              {data.bodyCam.clock} {data.bodyCam.job} |{" "}
              {data.bodyCam.rank}
            </div>
          </div>
          <div className={s.bottom}>
            <p> {language.bodyCamShowDesc} </p>
            <p className={s.callSign}> #{data.bodyCam.callSign} </p>
          </div>
        </div>
      </div>
    </div>
  )
}

export default BodyCam
