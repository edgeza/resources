import { useSettings } from "../../../contexts/SettingsContext";

import ServerInfoStyles1 from "../../ui/server-info-styles/server-info-styles-1";
import ServerInfoStyles2 from "../../ui/server-info-styles/server-info-styles-2";
import ServerInfoStyles3 from "../../ui/server-info-styles/server-info-styles-3";
import ServerInfoStyles4 from "../../ui/server-info-styles/server-info-styles-4";
import ServerInfoStyles5 from "../../ui/server-info-styles/server-info-styles-5";
import ServerInfoStyles6 from "../../ui/server-info-styles/server-info-styles-6";
import ServerInfoStyles7 from "../../ui/server-info-styles/server-info-styles-7";
import ServerInfoStyles8 from "../../ui/server-info-styles/server-info-styles-8";

const QuickInfo = () => {
  const { settings } = useSettings();

  return (
    <>
      {[
        ServerInfoStyles1,
        ServerInfoStyles2,
        ServerInfoStyles3,
        ServerInfoStyles4,
        ServerInfoStyles5,
        ServerInfoStyles6,
        ServerInfoStyles7,
        ServerInfoStyles8,
      ].map((StatusStyle, index) =>
        settings.serverInfoSettings.serverInfoStyle ===
        (index + 1).toString() ? (
          <StatusStyle />
        ) : null
      )}
    </>
  );
};

export default QuickInfo;
