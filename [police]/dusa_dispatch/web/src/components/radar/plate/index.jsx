import React from "react";
import s from "./plate.module.scss";

function RadarPlate({plate}) {
    return ( 
        <>
          <div className={s.plate}>
            <p> {plate} </p>
          </div>
        </>
     );
}

export default RadarPlate;