import React, {
  Context,
  createContext,
  useContext,
  useState,
} from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";
import { motion } from "framer-motion";


setTimeout(() => {
  debugData([
    {
      action: "setVisible",
      data: true,
    },
  ]);
}, 2000);


const VisibilityCtx = createContext<VisibilityProviderValue | null>(null);

interface VisibilityProviderValue {
  setVisible: (visible: boolean) => void;
  visible: boolean;
}

// This should be mounted at the top level of your application, it is currently set to
// apply a CSS visibility value. If this is non-performant, this should be customized.
export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {

  // Ui gözükmesi için true olmalı
  const [visible, setVisible] = useState(true);

  useNuiEvent<boolean>("setVisible", setVisible);

  return (
    <VisibilityCtx.Provider
      value={{
        visible,
        setVisible,
      }}
    >
      <motion.div
        animate={{ opacity: visible ? 1 : 0 }}
        transition={{ duration: 0.5}}
        style={{ height: "100vh", width: "100%", position: "absolute" }}
      >
        {children}
      </motion.div>
    </VisibilityCtx.Provider>
  );
};

export const useVisibility = () =>
  useContext<VisibilityProviderValue>(
    VisibilityCtx as Context<VisibilityProviderValue>,
  );
