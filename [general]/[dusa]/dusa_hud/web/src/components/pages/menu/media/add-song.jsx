import AddIcon from "@mui/icons-material/Add";
import { useMusicPlayer } from "../../../../contexts/MediaContext";
import { useCallback, useState } from "react";

import PlayArrowRounded from "@mui/icons-material/PlayArrowRounded";
import { SongIcon } from "../../../icons/song-icon";
import { fetchNui } from "../../../../utils/fetchNui";
import { extractVideoID } from "../../../../helper/music-player";
import { useSettings } from "../../../../contexts/SettingsContext";

const AddSong = () => {
  const { settings } = useSettings();
  const { addSongToMusicList, musicList, onPlay, currentTrackIndex } =
    useMusicPlayer();

  const [music, setMusic] = useState("");

  async function fetchSongDetails(videoID) {
    const API_KEY = "AIzaSyBVwkciEOdTzJyAQuwRSbm0k_IO_RjfpYA"; // Replace with your YouTube Data API Key
    const apiUrl = `https://www.googleapis.com/youtube/v3/videos?id=${videoID}&key=${API_KEY}&part=snippet,contentDetails`;

    try {
      const response = await fetch(apiUrl);
      const data = await response.json();
      const videoData = data.items[0];

      return {
        title: videoData.snippet.title,
        duration: videoData.contentDetails.duration, // Consider formatting this value
        artist: videoData.snippet.channelTitle, // YouTube doesn't directly provide artist names for music videos
      };
    } catch (error) {
      console.error("Error fetching YouTube video data:", error);
      return { title: "", duration: "", artist: "" };
    }
  }

  const handleAddSong = useCallback(() => {
    const videoID = extractVideoID(music);
    if (videoID)
      fetchSongDetails(videoID).then((details) => {
        addSongToMusicList({
          title: details.title,
          url: music,
          artist: details.artist,
          duration: details.duration,
        });

        fetchNui("updatePlaylist", [
          ...musicList,
          {
            title: details.title,
            url: music,
            artist: details.artist,
            duration: details.duration,
          },
        ]);
      });
  }, [addSongToMusicList, music]);

  const renderAddSong = useCallback(() => {
    return (
      <div className="flex items-center gap-x-2">
        <input
          onChange={(e) => setMusic(e.target.value)}
          style={{
            borderRadius: "3px",
            border: "0.5px solid rgba(255, 255, 255, 0.25)",
            background:
              "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
          }}
          value={music}
          className="w-[296px] p-2 h-[38px] text-[8.891px] text-[#959595] bg-gradient-to-r from-zinc-300 via-zinc-300 to-zinc-300 rounded-[3px] border border-white"
        />
        <button
          onClick={() => handleAddSong()}
          style={{
            borderRadius: "3px",
            border: "0.5px solid rgba(255, 255, 255, 0.25)",
            background:
              "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
          }}
          className="flex group cursor-pointer items-center w-[38px] h-[38px] justify-center bg-gradient-to-r from-zinc-300 via-zinc-300 to-zinc-300 rounded-[3px] border border-white"
        >
          <AddIcon className="group-hover:text-white" />
        </button>
      </div>
    );
  }, [handleAddSong, music]);

  const renderMusicList = useCallback(() => {
    return musicList.map((track, index) => (
      <div
        key={index}
        className="w-[342px] h-[48.14px] px-2 flex items-center justify-between bg-zinc-300 bg-opacity-5 rounded-[1px]"
      >
        <div className="flex items-center gap-x-2 w-full">
          <div className="w-[32.09px] flex items-center justify-center h-[32.09px]  bg-stone-500 rounded-[1px]">
            <SongIcon />
          </div>
          <div className="flex items-center justify-between w-full">
            <div className="flex flex-col">
              <div className="px-2 w-44 line-clamp-2 text-neutral-200 text-[9.26px] font-semibold font-['Qanelas Soft']">
                {track.title}
              </div>
              <div className="px-2 w-44 line-clamp-2 text-neutral-100 text-[8px] font-semibold font-['Qanelas Soft']">
                {track.artist}
              </div>
            </div>
            {index === currentTrackIndex ? (
              <div className="text-zinc-500 text-[8.89px] font-semibold ">
                {settings.language.playingNow}
              </div>
            ) : (
              <button onClick={() => onPlay(index)}>
                <PlayArrowRounded />
              </button>
            )}
          </div>
        </div>
      </div>
    ));
  }, [currentTrackIndex, musicList, onPlay]);

  return (
    <div className="w-full h-full flex gap-y-2 px-2 flex-col bg-gradient-to-r from-neutral-950/80 via-neutral-900/80 to-neutral-950/80">
      {renderAddSong()}

      {renderMusicList()}
    </div>
  );
};

export default AddSong;
