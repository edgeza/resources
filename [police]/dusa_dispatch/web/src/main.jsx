import React from "react"
import ReactDOM from "react-dom/client"
import App from "./components/App.jsx"
import "./main.scss"
import { VisibilityProvider } from "./providers/VisibilityProvider"
import { DataProvider } from "./providers/DataProvider"
import { RouterProvider } from "./providers/RouterProvider"
import { LanguageProvider } from "./providers/LanguageProvider"
import { DrawProvider } from "./providers/DrawProivder.jsx"

ReactDOM.createRoot(document.getElementById("root")).render(
  <VisibilityProvider>
    <DataProvider>
      <RouterProvider>
        <LanguageProvider>
          <DrawProvider>
            <App />
          </DrawProvider>
        </LanguageProvider>
      </RouterProvider>
    </DataProvider>
  </VisibilityProvider>
)
