import React from "react"
import { useRoute } from "./../hooks/useRoute"
import { useData } from "../hooks/useData";
import Radar from "../pages/radar"
import PoliceDispatch from './../pages/dispatch';
import RadarSettings from './../pages/radarSettings';
import BodyCam from "../pages/bodyCam";
import DispatchAlert from "./dispatch/dispatchAlert";
import Notify from "../pages/notify";
function App() {
  const { route } = useRoute()
  const { data } = useData()
  return (
    <>
      <Notify />
      { data.dispatch.alertNot && <DispatchAlert />}
      {route === "radar" && <Radar />}
      {route === "dispatch" && <PoliceDispatch />}
      {route === "radarSettings" && <RadarSettings />}
      {data.bodyCam.enable && <BodyCam />}
    </>
  )
}

export default App
