export const localStorageKey = "statusSettingsMap";

export function getStatusSettingsMapFromLocalStorage() {
  const storedData = localStorage.getItem(localStorageKey);
  return storedData ? JSON.parse(storedData) : {};
}

export function setStatusSettingsMapInLocalStorage(settingsMapsMap) {
  localStorage.setItem(localStorageKey, JSON.stringify(settingsMapsMap));
}

export function getStatusSettingForStyleFromLocalStorage(styleType) {
  const settingsMap = getStatusSettingsMapFromLocalStorage();
  return settingsMap[styleType] || null;
}

export function updateStatusSettingForStyleInLocalStorage(styleType, setting) {
  const settingsMap = getStatusSettingsMapFromLocalStorage();
  settingsMap[styleType] = setting;
  setStatusSettingsMapInLocalStorage(settingsMap);
}

export function clearSettingsInLocalStorage() {
  localStorage.removeItem(localStorageKey);
}
