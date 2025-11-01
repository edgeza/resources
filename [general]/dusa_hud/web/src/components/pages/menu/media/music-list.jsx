import { useState } from "react";
import { useMusicPlayer } from "../../../../contexts/MediaContext";
import PlayArrowRounded from "@mui/icons-material/PlayArrowRounded";
import { SongIcon } from "../../../icons/song-icon";
import { AddSongIcon } from "../../../icons/add-song-icon";
import { useSettings } from "../../../../contexts/SettingsContext";

const MusicList = () => {
  const { settings } = useSettings();
  const [searchTerm, setSearchTerm] = useState("");
  const {
    musicList,
    searchSongInMusicList,
    currentTrackIndex,
    onPlay,
    removeSongFromMusicList,
  } = useMusicPlayer();

  // const filteredSongs =
  //   searchTerm.length > 0 ? searchSongInMusicList(searchTerm) : musicList;

  // if (filteredSongs.length === 0 && searchTerm === "")
  //   return (
  //     <div className="flex items-center justify-center bg-zinc-900 w-full h-full text-white">
  //       No song in the list
  //     </div>
  //   );

  return (
    <div className="w-full h-full flex gap-y-2 px-2 flex-col bg-gradient-to-r from-neutral-950/80 via-neutral-900/80 to-neutral-950/80">
      <div className="flex items-center gap-x-2">
        <input
          onChange={(e) => setSearchTerm(e.target.value)}
          style={{
            borderRadius: "3px",
            border: "0.5px solid rgba(255, 255, 255, 0.25)",
            background:
              "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
          }}
          value={searchTerm}
          className="w-[296px] p-2 h-[38px] text-[8.891px] text-[#959595] bg-gradient-to-r from-zinc-300 via-zinc-300 to-zinc-300 rounded-[3px] border border-white"
        />
        <div
          style={{
            borderRadius: "3px",
            border: "0.5px solid rgba(255, 255, 255, 0.25)",
            background:
              "linear-gradient(79deg, #090909 5.22%, #161616 50.4%, #0B0B0B 96.49%)",
          }}
          className="flex group items-center w-[38px] h-[38px] justify-center bg-gradient-to-r from-zinc-300 via-zinc-300 to-zinc-300 rounded-[3px] border border-white"
        >
          <AddSongIcon />
        </div>
      </div>

      {musicList.map((track, index) => (
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
              <div className="flex items-center gap-x-1">
                {index === currentTrackIndex ? (
                  <div className="text-zinc-500 text-[8.89px] font-semibold ">
                    {settings.language.playingNow}
                  </div>
                ) : (
                  <button onClick={() => onPlay(index)}>
                    <PlayArrowRounded />
                  </button>
                )}
                <button
                  className="cursor-pointer flex items-center justify-center w-5 h-5 rounded-lg hover:bg-slate-800"
                  onClick={() => removeSongFromMusicList(track.url)}
                >
                  <svg
                    width="9"
                    height="9"
                    viewBox="0 0 9 9"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <rect
                      x="0.390625"
                      y="1.25955"
                      width="1.78128"
                      height="9.79702"
                      rx="0.498758"
                      transform="rotate(-45 0.390625 1.25955)"
                      fill="#717171"
                    />
                    <rect
                      x="1.65039"
                      y="8.1871"
                      width="1.78128"
                      height="9.79702"
                      rx="0.498758"
                      transform="rotate(-135 1.65039 8.1871)"
                      fill="#717171"
                    />
                  </svg>
                </button>
              </div>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default MusicList;
