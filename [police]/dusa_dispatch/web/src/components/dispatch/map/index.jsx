import { MapContainer, Marker, Popup, TileLayer } from "react-leaflet"
import { useRef } from "react"
import MapDraw from "../mapDraw"
import s from "./style.module.scss"
import { SimpleMapScreenshoter } from "leaflet-simple-map-screenshoter"
import { useDraw } from "../../../hooks/useDraw"
import L, { icon } from "leaflet"
import { Icon } from "leaflet"
import "leaflet/dist/leaflet.css"
import { useData } from "../../../hooks/useData"
import { postNui } from "../../../utils/postNui"
import { useNuiEvent } from "../../../hooks/useNuiEvent"

function DispatchMap() {
  const { saveData, map, screenShoter } = useDraw()
  const center_x = 117.3
  const center_y = 172.8
  const scale_x = 0.02072
  const scale_y = 0.0205
  const { data, setData } = useData()
  const dispatchRouter = data.dispatch.menu
  var mapbounds
  const CUSTOM_CRS = L.extend({}, L.CRS.Simple, {
    projection: L.Projection.LonLat,
    scale: function (zoom) {
      return Math.pow(2, zoom)
    },
    zoom: function (sc) {
      return Math.log(sc) / 0.6931471805599453
    },
    distance: function (pos1, pos2) {
      var x_difference = pos2.lng - pos1.lng
      var y_difference = pos2.lat - pos1.lat
      return Math.sqrt(x_difference * x_difference + y_difference * y_difference)
    },
    transformation: new L.Transformation(scale_x, center_x, -scale_y, center_y),
    infinite: true,
  })
  const installScreenShot = (e) => {
    map.current = e.target
    var sw = map.current.unproject([0, 1024], 3 - 1)
    var ne = map.current.unproject([1024, 0], 3 - 1)
    mapbounds = new L.LatLngBounds(sw, ne)
    map.current.setView([0, 0], 4)
    map.current.setMaxBounds(mapbounds)
    
    screenShoter.current = new SimpleMapScreenshoter({
      hidden: true,
    })
    screenShoter.current.addTo(map.current)
  }
  const icons = data.dispatch.icons
  const getIcon = (icon) => {
    return new Icon({
      iconUrl: "./icon/" + icon + ".png",
      iconSize: [45, 50],
      popupAnchor: [0, 0],
      pane: "markerPane",
    })
  }

  useNuiEvent("UPDATE_GPS", (data) => {
    changeIconPosition(data.citizen, data.coords)
  })

  const changeIconPosition = (citizen, position) => {
    const newIcons = icons.map((icon) => {
      if (icon.citizenId === citizen) {
        return { ...icon, position: [position.x, position.y] }
      }
      return icon
    })
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        icons: newIcons,
      },
    })
  }
  const deleteIcon = (citizen) => {
    const newIcons = icons.filter((icon) => icon.citizenId !== citizen)
    setData({
      ...data,
      dispatch: {
        ...data.dispatch,
        icons: newIcons,
      },
    })
  }
  const openGps = (position) => {
    console.log(position)
  }
  const openBodycam = (id, citizenId) => {
    postNui("BODYCAM_WATCH", { gameId: id })
  }
  const checkVisible = (job) => {
    if (data.dispatch.mapFilter[job]) {
      return true
    }
    return false
  }
  return (
    <div className={`${s.body}  ${data.dispatch.job === "police" ? s.police : s.ambulance}`}>
      <MapContainer
        className={s.map}
        crs={CUSTOM_CRS}
        center={[0, 0]}
        zoom={4}
        zoomControl={false}
        scrollWheelZoom={true}
        preferCanvas={true}
        attributionControl={false}
        minZoom={3}
        maxZoom={5}
        ref={map}
        whenReady={installScreenShot}
      >
        <TileLayer
          url="./mapStyles/styleSatelite/{z}/{x}/{y}.jpg"
          noWrap={true}
          ></TileLayer>
        {dispatchRouter === "draw" && <MapDraw />}
        {icons.filter(icon => checkVisible(icon.job)).map(
          (icon, index) => (
            <Marker key={index} position={icon.position} icon={getIcon(icon.icon)}>
              <Popup>
                <div className={`${icon.job === "ambulance" ? s.aIcon : s.pIcon} ${s.icon}`}>
                  <div className={s.iconTop}>
                    <h3> {icon.name} </h3>
                  </div>
                  <div className={s.iconBottom}>
                    <div className={s.iconCam}>
                      <svg
                        onClick={() => openBodycam(icon.id, icon.citizenId)}
                        xmlns="http://www.w3.org/2000/svg"
                        width="24"
                        height="15"
                        viewBox="0 0 24 15"
                        fill="none"
                      >
                        <path
                          d="M17.599 2.4081V13.0731C17.599 13.4772 17.4384 13.8647 17.1527 14.1505C16.867 14.4362 16.4795 14.5967 16.0754 14.5967H2.36318C1.9591 14.5967 1.57157 14.4362 1.28585 14.1505C1.00012 13.8647 0.8396 13.4772 0.8396 13.0731V2.4081C0.8396 2.00402 1.00012 1.61649 1.28585 1.33077C1.57157 1.04504 1.9591 0.884521 2.36318 0.884521H16.0754C16.4795 0.884521 16.867 1.04504 17.1527 1.33077C17.4384 1.61649 17.599 2.00402 17.599 2.4081ZM23.1219 2.4319C23.0144 2.40561 22.9026 2.40236 22.7938 2.42238C22.685 2.44241 22.5817 2.48524 22.4906 2.54808L19.292 4.68013C19.2398 4.71495 19.1971 4.7621 19.1675 4.81742C19.1379 4.87274 19.1225 4.9345 19.1225 4.99723V10.484C19.1225 10.5467 19.1379 10.6085 19.1675 10.6638C19.1971 10.7191 19.2398 10.7663 19.292 10.8011L22.5087 12.9455C22.6291 13.0259 22.7699 13.0702 22.9146 13.0734C23.0592 13.0766 23.2019 13.0385 23.3257 12.9636C23.4403 12.8908 23.5342 12.7898 23.5986 12.6702C23.6629 12.5507 23.6955 12.4166 23.6933 12.2809V3.16989C23.6933 3.00094 23.6373 2.83675 23.5338 2.70316C23.4304 2.56956 23.2855 2.47414 23.1219 2.4319Z"
                          fill="#FF3939"
                        />
                      </svg>
                    </div>
                    <div className={s.iconGps}>
                      <svg
                        onClick={() => openGps(icon.position)}
                        xmlns="http://www.w3.org/2000/svg"
                        width="24"
                        height="17"
                        viewBox="0 0 24 17"
                        fill="none"
                      >
                        <path
                          d="M16.1904 8.40699C16.1904 9.1601 15.9671 9.89631 15.5487 10.5225C15.1303 11.1487 14.5356 11.6368 13.8398 11.925C13.144 12.2132 12.3783 12.2886 11.6397 12.1417C10.901 11.9947 10.2226 11.6321 9.69002 11.0995C9.15749 10.567 8.79483 9.88851 8.6479 9.14986C8.50097 8.41121 8.57638 7.64558 8.86459 6.94979C9.15279 6.254 9.64085 5.6593 10.267 5.24089C10.8932 4.82248 11.6294 4.59915 12.3826 4.59915C13.3925 4.59915 14.361 5.00033 15.0751 5.71444C15.7892 6.42855 16.1904 7.39709 16.1904 8.40699ZM19.9982 8.40699C20.0005 6.5334 19.3099 4.72516 18.0591 3.33019C17.9929 3.25385 17.9122 3.19145 17.8217 3.1466C17.7311 3.10176 17.6326 3.07538 17.5318 3.069C17.4309 3.06261 17.3299 3.07636 17.2344 3.10942C17.1389 3.14249 17.051 3.19422 16.9757 3.2616C16.9004 3.32899 16.8393 3.41067 16.7959 3.50191C16.7525 3.59314 16.7277 3.6921 16.7229 3.79301C16.7182 3.89393 16.7335 3.99479 16.7681 4.08971C16.8027 4.18464 16.8558 4.27174 16.9244 4.34593C17.9234 5.46292 18.4756 6.90891 18.4756 8.40746C18.4756 9.90602 17.9234 11.352 16.9244 12.469C16.7934 12.62 16.7271 12.8165 16.7398 13.016C16.7524 13.2154 16.8429 13.402 16.9919 13.5353C17.1408 13.6686 17.3362 13.738 17.5358 13.7286C17.7355 13.7191 17.9234 13.6315 18.0591 13.4847C19.3097 12.0893 20.0003 10.2808 19.9982 8.40699ZM7.84077 4.34593C7.90934 4.27174 7.96247 4.18464 7.99705 4.08971C8.03163 3.99479 8.04698 3.89393 8.0422 3.79301C8.03742 3.6921 8.0126 3.59314 7.96921 3.50191C7.92581 3.41067 7.86469 3.32899 7.78942 3.2616C7.71414 3.19422 7.62621 3.14249 7.53074 3.10942C7.43528 3.07636 7.33419 3.06261 7.23336 3.069C7.13253 3.07538 7.03399 3.10176 6.94345 3.1466C6.85292 3.19145 6.77222 3.25385 6.70604 3.33019C5.45592 4.7259 4.76466 6.53375 4.76466 8.40746C4.76466 10.2812 5.45592 12.089 6.70604 13.4847C6.8417 13.6315 7.02964 13.7191 7.2293 13.7286C7.42896 13.738 7.62433 13.6686 7.77327 13.5353C7.9222 13.402 8.01275 13.2154 8.02538 13.016C8.03801 12.8165 7.9717 12.62 7.84077 12.469C6.8408 11.3525 6.28786 9.90631 6.28786 8.40746C6.28786 6.90861 6.8408 5.46244 7.84077 4.34593ZM22.9084 3.96515C22.351 2.64149 21.548 1.43537 20.5418 0.410537C20.4724 0.336387 20.389 0.276854 20.2963 0.235437C20.2036 0.19402 20.1035 0.171556 20.002 0.169367C19.9005 0.167177 19.7996 0.185305 19.7052 0.222686C19.6108 0.260067 19.5248 0.315946 19.4524 0.387035C19.3799 0.458125 19.3223 0.542991 19.2831 0.636643C19.2439 0.730294 19.2238 0.830841 19.224 0.932369C19.2243 1.0339 19.2448 1.13436 19.2844 1.22784C19.324 1.32133 19.3819 1.40595 19.4547 1.47673C21.2698 3.32604 22.2867 5.81382 22.2867 8.40508C22.2867 10.9963 21.2698 13.4841 19.4547 15.3334C19.3844 15.4048 19.3289 15.4893 19.2913 15.5822C19.2537 15.675 19.2348 15.7743 19.2356 15.8745C19.2364 15.9746 19.2569 16.0737 19.2959 16.1659C19.335 16.2581 19.3919 16.3417 19.4632 16.412C19.5346 16.4823 19.6191 16.5378 19.712 16.5754C19.8048 16.613 19.9041 16.6319 20.0043 16.6311C20.1044 16.6303 20.2035 16.6098 20.2957 16.5707C20.3879 16.5317 20.4715 16.4748 20.5418 16.4034C22.1185 14.7934 23.1842 12.7533 23.6053 10.5395C24.0263 8.32571 23.7839 6.03685 22.9084 3.96039V3.96515ZM3.25995 12.2605C2.499 10.4617 2.28765 8.47784 2.65257 6.55907C3.01748 4.64031 3.94232 2.87254 5.31047 1.47863C5.45211 1.33447 5.53068 1.13995 5.52889 0.937854C5.52711 0.735762 5.44511 0.542656 5.30095 0.401018C5.15679 0.259379 4.96226 0.18081 4.76017 0.182596C4.55808 0.184381 4.36497 0.266374 4.22333 0.410537C2.1273 2.54438 0.952881 5.41589 0.952881 8.40699C0.952881 11.3981 2.1273 14.2696 4.22333 16.4034C4.29269 16.4776 4.37617 16.5371 4.46886 16.5785C4.56156 16.62 4.6616 16.6424 4.76311 16.6446C4.86461 16.6468 4.96553 16.6287 5.05993 16.5913C5.15432 16.5539 5.24029 16.498 5.31278 16.4269C5.38526 16.3558 5.4428 16.271 5.48201 16.1773C5.52122 16.0837 5.54131 15.9831 5.5411 15.8816C5.54088 15.7801 5.52037 15.6796 5.48076 15.5861C5.44115 15.4926 5.38326 15.408 5.31047 15.3372C4.43913 14.4501 3.7434 13.4062 3.25995 12.2605Z"
                          fill="#A82626"
                        />
                      </svg>
                    </div>
                  </div>
                </div>
              </Popup>
            </Marker>
          )
        )}

        {dispatchRouter === "dispatchList" &&
          data.dispatch.dispatchList.map((item, index) => (
            <Marker
              key={index}
              position={item.coords}
              icon={item.active ? getIcon(item.activeIcon) : getIcon(item.icon)}
            ></Marker>
          ))}
        {dispatchRouter === "camera" &&
          data.dispatch.cameraList.map((item, index) => (
            <Marker
              key={index}
              position={item.position}
              icon={item.active ? getIcon(item.activeIcon) : getIcon(item.icon)}
            ></Marker>
          ))}
      </MapContainer>
    </div>
  )
}

export default DispatchMap
