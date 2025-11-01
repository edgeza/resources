import { createContext, useContext, useState, useEffect } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";

const defaultValue = {
  musicList: [],
  playing: false,
  progress: 0,
  currentTrackIndex: 0,
  addSongToMusicList: () => {},
  removeSongFromMusicList: () => {}, // Ensure this method is in your default value for completeness.
  searchSongInMusicList: () => [],
  setPlaying: function () {
    throw new Error("Function not implemented.");
  },
  playNextTrack: function () {
    throw new Error("Function not implemented.");
  },
  playPreviousTrack: function () {
    throw new Error("Function not implemented.");
  },
  onPlay: function () {
    throw new Error("Function not implemented.");
  },
  setProgress: function () {
    throw new Error("Function not implemented.");
  },
  volume: 1,
  increaseVolume: function () {
    throw new Error("Function not implemented.");
  },
  decreaseVolume: function () {
    throw new Error("Function not implemented.");
  },
};

const MusicPlayerContext = createContext(defaultValue);

export const useMusicPlayer = () => useContext(MusicPlayerContext);

export const MusicPlayerProvider = ({ children }) => {
  const [currentTrackIndex, setCurrentTrackIndex] = useState(0);
  const [musicList, setMusicList] = useState([]);
  const [playing, setPlaying] = useState(false);
  const [progress, setProgress] = useState(0);
  const [volume, setVolume] = useState(0.8); // Default volume is 0.8 (80%)

  // Increase volume by 10% until it reaches 100%
  const increaseVolume = () => {
    setVolume((prevVolume) => (prevVolume < 1 ? prevVolume + 0.1 : 1));
    fetchNui("runMusic", {action: 'volume', volume: volume + 0.1});
  };

  // Decrease volume by 10% until it reaches 0%
  const decreaseVolume = () => {
    setVolume((prevVolume) => (prevVolume > 0 ? prevVolume - 0.1 : 0));
    fetchNui("runMusic", {action: 'volume', volume: volume - 0.1});
  };

  useNuiEvent("setupPlaylist",(data) => {
    if (data.playlist && Array.isArray(data.playlist) && data.playlist.length > 0) {
      setMusicList(data.playlist);
    }
  });

  const addSongToMusicList = (song) => {
    setMusicList((prevMusicList) => [...prevMusicList, song]);
  };

  const removeSongFromMusicList = (url) => {
    setMusicList((prevMusicList) =>
      prevMusicList.filter((song) => song.url !== url)
    );
    fetchNui("removeSong", url);
  };

  const searchSongInMusicList = (searchTerm) => {
    return musicList.filter((song) =>
      song.title.toLowerCase().includes(searchTerm.toLowerCase())
    );
  };

  const playNextTrack = () => {
    console.log('Next yürütülür')
    setCurrentTrackIndex((prevIndex) => (prevIndex + 1) % musicList.length);
    // fetchNui("skipSong", (currentTrackIndex + 1) % musicList.length);
    console.log('NExt', (currentTrackIndex + 1) % musicList.length)
    // fetchNui("runMusic", {action: 'volume', volume: volume - 0.1});
  };

  const playPreviousTrack = () => {
    console.log('Previous yürütülür')
    setCurrentTrackIndex((prevIndex) => (prevIndex - 1) % musicList.length);
  };

  const onPlay = (index) => {
    console.log('PLAYLEEE')
    setCurrentTrackIndex(index);
    console.log('Playing', index)
    setPlaying(true);
    if (playing) {
      fetchNui("runMusic", {action: 'pause'});
    }
  };

  useNuiEvent("pauseSong", () => {
    console.log('PAUSE')
    setPlaying(false);
    fetchNui("runMusic", {action: 'pause'});
  });

  return (
    <MusicPlayerContext.Provider
      value={{
        currentTrackIndex,
        musicList,
        playing,
        progress,
        addSongToMusicList,
        removeSongFromMusicList,
        searchSongInMusicList,
        setPlaying,
        onPlay,
        setProgress,
        playNextTrack,
        playPreviousTrack,
        increaseVolume,
        decreaseVolume,
        volume,
      }}
    >
      {children}
    </MusicPlayerContext.Provider>
  );
};
