import { FeatureGroup, GeoJSON } from "react-leaflet"
import { EditControl } from "react-leaflet-draw"
import { useState, useEffect, useRef } from "react"
import { useData } from "../../../hooks/useData"
import { useDraw } from "../../../hooks/useDraw"
import L from "leaflet"
import "leaflet-draw/dist/leaflet.draw.css"
import "./custom.scss"
import { useLanguage } from "../../../hooks/useLanguage"
import { postNui } from "../../../utils/postNui"

function MapDraw() {
  const geoJsonLayer = useRef(null)
  const { data, setData, uiData, setUiData } = useData()
  const { language } = useLanguage()
  const [geoData, setGeoData] = useState([])
  const handleCreated = (e) => {
    const { layerType, layer } = e
    layer.options.opacity = 1
    const data = {
      layerType,
      layer,
    }
    setUiData((prevData) => ({
      ...prevData,
      dispatch: {
        ...prevData.dispatch,
        layerItems: [...prevData.dispatch.layerItems, data],
      },
    }))
  }

  const pointToLayer = (feature, latlng) => {
    if (feature.properties.radius) {
      return L.circle(latlng, {
        radius: feature.properties.radius,
      })
    }
    return L.marker(latlng)
  }

  const handleLayer = () => {
    let newData = []
    if(data.dispatch.draw.drawnItems.length === 0) return setGeoData([])
    data.dispatch.draw.drawnItems.forEach((item) => {
      item.items.forEach((layer) => {
        // find geoData from layer
        newData.push(layer)
        setGeoData(newData)
      })
    })
    // postNui("createDraw", { created: data.dispatch.draw.drawnItems })
  }

  const updateGeoData = () => {
    if (geoJsonLayer.current) {
      geoJsonLayer.current.clearLayers()
      geoJsonLayer.current.addData(geoData)
    }
  }

  const handleRemove = (e)=>{
    const { layer } = e
    setUiData({
      ...uiData,
      dispatch: {
        ...uiData.dispatch,
        layerItems: uiData.dispatch.layerItems.filter((item) => item.layer !== layer),
      },
    })
  }

  useEffect(() => {
    if (geoJsonLayer.current) {
      handleLayer()
    }
  }, [data.dispatch.draw.drawnItems])
  useEffect(() => {
    updateGeoData()
  }, [geoData])
  return (
    <>
      <FeatureGroup>
        <EditControl
          position="topleft"
          onCreated={handleCreated}
          onDeleted={handleRemove}
          edit={{
            edit: false,
            remove: true,
          }}
          draw={{
            rectangle: false,
            circlemarker: false,
          }}
        />
        <GeoJSON
          data={geoData}
          ref={geoJsonLayer}
          pointToLayer={pointToLayer}
        />
      </FeatureGroup>
    </>
  )
}

export default MapDraw
