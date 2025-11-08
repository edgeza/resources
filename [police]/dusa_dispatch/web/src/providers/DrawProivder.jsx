import React, { createContext, useRef } from "react"
import L from "leaflet"
import { useData } from "../hooks/useData"
import { randomId } from "../utils/misc"
import { postNui } from "../utils/postNui"

export const DrawContext = createContext()

export const DrawProvider = ({ children }) => {
  const { data, setData, uiData, setUiData } = useData()
  const map = useRef(null)
  const screenShoter = useRef(null)
  const saveData = (layerType, layer) => {
    let groupId = randomId()
    let group = {
      name: uiData.dispatch.groupTitle,
      description: uiData.dispatch.groupDescription,
      citizenId: data.dispatch.citizenId,
      groupId: groupId,
      img: "",
      items: [],
    }
    screenShot().then((img) => {
      group.img = img
    })
    uiData.dispatch.layerItems.forEach((item) => {
      if (item.layerType === "circle") {
        const circleData = {
          type: "Feature",
          _leaflet_id: item.layer._leaflet_id,
          properties: {
            radius: item.layer.getRadius(),
          },
          geometry: {
            type: "Point",
            coordinates: [
              item.layer.getLatLng().lng,
              item.layer.getLatLng().lat,
            ],
          },
        }
        group.items.push(circleData)
        item.layer.remove()
        deleteUiData(item.layer._leaflet_id)
        return
      } else {
        const geojson = item.layer.toGeoJSON()
        const normalData = {
          type: "Feature",
          _leaflet_id: item.layer._leaflet_id,
          properties: {},
          geometry: {
            type: geojson.geometry.type,
            coordinates: geojson.geometry.coordinates,
          },
        }
        group.items.push(normalData)
        item.layer.remove()
        deleteUiData(item.layer._leaflet_id)
      }
    })
    postNui("createDraw", {created: group})
    setData((prevData) => ({
      ...prevData,
      dispatch: {
        ...prevData.dispatch,
        draw: {
          drawnItems: [...prevData.dispatch.draw.drawnItems, group],
        },
      },
    }))

  }
  const screenShot = async () => {
    let image
    await screenShoter.current
      .takeScreen()
      .then((blob) => {
        image = URL.createObjectURL(blob)
      })
      .catch((e) => {
        console.error(e)
      })
    return image
  }
  const deleteUiData = (layerId) => {
    setUiData((prevData) => ({
      ...prevData,
      dispatch: {
        layerItems: prevData.dispatch.layerItems.filter(
          (item) => item.layer._leaflet_id !== layerId
        ),
      },
    }))
  }
  const deleteData = (groupId) => {
    setData((prevData) => ({
      ...prevData,
      dispatch: {
        ...prevData.dispatch,
        draw: {
          drawnItems: prevData.dispatch.draw.drawnItems.filter(
            (item) => item.groupId !== groupId
          ),
        },
      },
    }))
  }

  return (
    <DrawContext.Provider
      value={{ saveData, map, screenShoter, screenShot, deleteData }}
    >
      {children}
    </DrawContext.Provider>
  )
}
