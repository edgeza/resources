import React, {
  createContext,
  useState,
} from "react"
import { useNuiEvent } from "../hooks/useNuiEvent"
import { debugData } from './../utils/debugData';

// Kendine useNui event gönderebilirsin.
debugData([
    {
      action: 'route',
      data: "dispatch",
    }
])

export const RouterContext = createContext()

export const RouterProvider = ({ children }) => {
  const [route, navigateTo] = useState("")

  useNuiEvent("route", (route)=> {
    navigateTo(route)
  })

  return (
    <RouterContext.Provider value={{ route, navigateTo }}>
      {children}
    </RouterContext.Provider>
  )
}
