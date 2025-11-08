
# Dusa React Template




## Kullanım

Projeyi klonlayın

```bash
  npx degit https://github.com/Dusa-Team/dusa_template my-project
```

Proje dizinine gidin

```bash
  cd my-project
```

Gerekli paketleri yükleyin

```bash
  npm install
```

Sunucuyu çalıştırın

```bash
  npm run dev
```

  
## useRoute
```javascript
import React from "react"
import { useRoute } from './../hooks/useRoute';
function App() {
  const { route, navigateTo } = useRoute()
  return (
    <>
      {route}
    </>
  )
}

export default App
```

## useLanguage
```javascript
import { useLanguage } from './../hooks/useLanguage';
function Home() {
    const { language } = useLanguage();
    return ( 
        <>
            <h1> {language.home} </h1>
        </>
     );
}

export default Home;
```

## useNuiEvent

```javascript
import React from "react"
import { useNuiEvent } from "../hooks/useNuiEvent"
import { useRoute } from './../hooks/useRoute';
import Home from "./../pages/home"
import Settings from "./../pages/settings"
function App() {
  const { route, navigateTo } = useRoute()

  useNuiEvent("route", (route)=> {
    if(route === "home") {
      // Başka bir sayfaya navigate olabilirsin.
      navigateTo(<Home />)
    }
    if(route === "settings") {
      navigateTo(<Settings />)
    } 
  })

  return (
    <>
      {route}
    </>
  )
}

export default App
```

## debugData

```javascript
import React from "react"
import { useNuiEvent } from "../hooks/useNuiEvent"
import { useRoute } from './../hooks/useRoute';
import { debugData } from "../utils/debugData";
import Home from "./../pages/home"
import Settings from "./../pages/settings"

debugData([
    {
      action: 'route',
      data: "home",
    }
])

function App() {
  const { route, navigateTo } = useRoute()

  useNuiEvent("route", (route)=> {
    if(route === "home") {
      // Başka bir sayfaya navigate olabilirsin.
      navigateTo(<Home />)
    }
    if(route === "settings") {
      navigateTo(<Settings />)
    } 
  })

  return (
    <>
      {route}
    </>
  )
}

export default App
```

## useData

```javascript
import { useLanguage } from './../hooks/useLanguage';
import { useData } from './../hooks/useData';
function Home() {
    const { language } = useLanguage();
    const { data } = useData();
    return ( 
        <>
            <h1> {language.home} </h1>
            <p> {data.home.description} </p>
        </>
     );
}

export default Home;
```

## setData

```javascript
import React, {
  Context,
  createContext,
  useContext,
  useEffect,
  useState,
} from "react"
import { useNuiEvent } from "../hooks/useNuiEvent"
import { debugData } from "./../utils/debugData"

export const DataContext = createContext()

debugData([
  {
    action: "CHANGE_HOME_DESC",
    data: "Gelene data"
  },
])

export const DataProvider = ({ children }) => {
  const [data, setData] = useState({
    home: {
      title: "Anasayfa",
      description: "Bu bir test",
    },
    settings: {
      title: "Ayarlar",
      description: "Bu bir test",
    },
  })

  useNuiEvent("CHANGE_HOME_DESC", (data) => {
    setData((prev) => ({
      ...prev,
      home: {
        ...prev.home,
        description: data,
      },
    }))
  })

  return (
    <DataContext.Provider value={{ data, setData }}>
      {children}
    </DataContext.Provider>
  )
}
```

## postNui

```javascript
import { useLanguage } from './../hooks/useLanguage';
import { useData } from './../hooks/useData';
import { postNui } from './../utils/postNui';
function Home() {
    const { language } = useLanguage();
    const { data } = useData();
    postNui("myPostEvent", "Gidecek Data"); 
    return ( 
        <>
            <h1> {language.home} </h1>
            <p> {data.home.description} </p>
        </>
     );
}

export default Home;
```
