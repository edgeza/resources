import { SettingsProvider } from "./contexts/SettingsContext";
import Hud from "./components/pages/hud";
import { MusicPlayerProvider } from "./contexts/MediaContext";
import Layout from "./components/ui/core/layout";

function App() {
  return (
    <SettingsProvider>
      <MusicPlayerProvider>
        <Layout>
          <Hud />
        </Layout>
      </MusicPlayerProvider>
    </SettingsProvider>
  );
}

export default App;
