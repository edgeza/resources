export function getDurationText(isoDuration) {
  const regex =
    /P(?:(\d+)Y)?(?:(\d+)M)?(?:(\d+)W)?(?:(\d+)D)?T?(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?/;
  const matches = isoDuration.match(regex);

  if (!matches) return "";

  const minutes = parseFloat(matches[6]) || 0;
  const seconds = parseFloat(matches[7]) || 0;

  return minutes + " min " + seconds + " seconds";
}

export function isoDurationToSeconds(isoDuration) {
  const regex =
    /P(?:(\d+)Y)?(?:(\d+)M)?(?:(\d+)W)?(?:(\d+)D)?T?(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?/;
  const matches = isoDuration.match(regex);

  if (!matches) return 0;

  const years = parseFloat(matches[1]) || 0;
  const months = parseFloat(matches[2]) || 0;
  const weeks = parseFloat(matches[3]) || 0;
  const days = parseFloat(matches[4]) || 0;
  const hours = parseFloat(matches[5]) || 0;
  const minutes = parseFloat(matches[6]) || 0;
  const seconds = parseFloat(matches[7]) || 0;

  return (
    years * 365.25 * 24 * 60 * 60 +
    months * 30.44 * 24 * 60 * 60 +
    weeks * 7 * 24 * 60 * 60 +
    days * 24 * 60 * 60 +
    hours * 60 * 60 +
    minutes * 60 +
    seconds
  );
}

export function extractVideoID(url) {
  const regExp =
    /^.*(?:youtu.be\/|(?:v\/)|(?:\/u\/\w\/)|(?:embed\/)|(?:watch\?v=))([^#&?]*).*/;
  const match = url.match(regExp);
  return match && match[1].length === 11 ? match[1] : null;
}
