import { useEffect, useState } from "react";
import { useMusicPlayer } from "../../../../contexts/MediaContext";
import PauseRoundedIcon from "@mui/icons-material/PauseRounded";
import PlayArrowRoundedIcon from "@mui/icons-material/PlayArrowRounded";
import SkipNextRoundedIcon from "@mui/icons-material/SkipNextRounded";
import SkipPreviousRoundedIcon from "@mui/icons-material/SkipPreviousRounded";
import {
  extractVideoID,
  getDurationText,
  isoDurationToSeconds,
} from "../../../../helper/music-player";
import { PlayerIcon } from "../../../icons/player-icon";
import clsx from "clsx";

const MusicPlayer = () => {
  const {
    currentTrackIndex,
    playing,
    setPlaying,
    musicList,
    playNextTrack,
    playPreviousTrack,
    progress,
    volume,
    increaseVolume,
    decreaseVolume,
  } = useMusicPlayer();

  const [durationText, setDurationText] = useState("");

  const [currentSongDetails, setCurrentSongDetails] = useState({
    title: "",
    duration: 0,
    artist: "",
  });

  useEffect(() => {
    if (!musicList || musicList.length === 0 || currentTrackIndex == null)
      return;

    const currentTrack = musicList[currentTrackIndex];
    const videoID = extractVideoID(currentTrack.url);

    if (videoID) {
      fetchSongDetails(videoID).then((details) => {
        setCurrentSongDetails(details);
      });
    }
  }, [musicList, currentTrackIndex]);

  async function fetchSongDetails(videoID) {
    const API_KEY = "AIzaSyBVwkciEOdTzJyAQuwRSbm0k_IO_RjfpYA"; // Replace with your YouTube Data API Key
    const apiUrl = `https://www.googleapis.com/youtube/v3/videos?id=${videoID}&key=${API_KEY}&part=snippet,contentDetails`;

    try {
      const response = await fetch(apiUrl);
      const data = await response.json();
      const videoData = data.items[0];

      setDurationText(getDurationText(videoData.contentDetails.duration));

      const formattedDuration = isoDurationToSeconds(
        videoData.contentDetails.duration
      );

      return {
        title: videoData.snippet.title,
        duration: formattedDuration, // Consider formatting this value
        artist: videoData.snippet.channelTitle, // YouTube doesn't directly provide artist names for music videos
      };
    } catch (error) {
      console.error("Error fetching YouTube video data:", error);
      return { title: "", duration: 0, artist: "" };
    }
  }

  if (!currentSongDetails)
    return (
      <div className="flex items-center justify-center bg-zinc-900 w-full h-full text-white">
        No music on play.
      </div>
    );

  return (
    <div className="w-full h-full px-3  bg-gradient-to-r from-neutral-950 via-neutral-900 to-neutral-950 rounded justify-between flex flex-col">
      <div className="flex  h-20 w-full items-center justify-between">
        <div className="w-96 flex items-center justify-center">
          <PlayerIcon />
        </div>
        <div className="flex items-start gap-x-2 mt-20">
          <div className="flex flex-col gap-y-2">
            <button
              disabled={volume === 1}
              onClick={increaseVolume}
              className={clsx(
                "w-4 cursor-pointer h-4 flex items-center justify-center bg-stone-500 bg-opacity-40 rounded-sm",
                volume === 1 && "!cursor-not-allowed"
              )}
            >
              <svg
                width="6"
                height="6"
                viewBox="0 0 6 6"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2.31936 6V0H3.68064V6H2.31936ZM0 3.68064V2.31936H6V3.68064H0Z"
                  fill="#E7DCF1"
                />
              </svg>
            </button>
            <button
              disabled={volume === 0}
              onClick={decreaseVolume}
              className={clsx(
                "w-4 h-4 cursor-pointer flex items-center justify-center bg-stone-500 bg-opacity-40 rounded-sm",
                volume === 0 && "!cursor-not-allowed"
              )}
            >
              <svg
                width="6"
                height="2"
                viewBox="0 0 6 2"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M6 1.68064H3.68064H2.31936H0V0.319364H2.31936H3.68064H6V1.68064Z"
                  fill="#E7DCF1"
                />
              </svg>
            </button>
          </div>
          <div className="w-2 h-[123px] relative">
            <div className="w-[5px] h-full left-[2px] top-0 absolute bg-zinc-300 bg-opacity-20 rounded-[1px]" />
            <div
              style={{
                height: volume * 100 + "%",
              }}
              className="w-[5px] bottom-0 right-0 absolute bg-gray-200 rounded-[1px]"
            />
          </div>
        </div>
      </div>
      <div className="w-full h-2/3 flex items-center justify-end flex-col gap-y-1">
        <div className="flex flex-col gap-y-2">
          <div className="text-center text-neutral-400 text-xs font-semibold ">
            {currentSongDetails.title}
          </div>
          <div className="text-center text-zinc-400 text-[8.05px] font-semibold ">
            {currentSongDetails.artist}
          </div>
        </div>
        <div className="w-full flex items-center justify-between">
          <div className="text-center text-neutral-400 text-[7.12px] font-semibold ">
            00.00
          </div>
          <div className="text-center text-neutral-400 text-[7.12px] font-semibold ">
            {durationText}
          </div>
        </div>

        <div className="w-[335px] h-0.5 bg-zinc-300 bg-opacity-10 rounded-sm relative">
          {playing && (
            <div
              style={{
                width: (progress * 335) / currentSongDetails.duration + "px",
              }}
              className=" absolute h-0.5 bg-white bg-opacity-10 rounded-sm "
            />
          )}
        </div>
        <div className="flex items-center justify-center w-full">
          {currentTrackIndex - 1 >= 0 && (
            <button
              onClick={() => playPreviousTrack()}
              className="cursor-pointer"
            >
              <SkipPreviousRoundedIcon className="text-neutral-500" />
            </button>
          )}
          <button
            onClick={() => setPlaying(!playing)}
            className="cursor-pointer"
          >
            {!playing ? (
              <PlayArrowRoundedIcon className="text-neutral-500" />
            ) : (
              <PauseRoundedIcon className="text-neutral-500" />
            )}
          </button>
          {currentTrackIndex + 1 <= musicList.length && (
            <button onClick={() => playNextTrack()} className="cursor-pointer">
              <SkipNextRoundedIcon className="text-neutral-500" />
            </button>
          )}
        </div>
      </div>
    </div>
  );
};

export default MusicPlayer;
