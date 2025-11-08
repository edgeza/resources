// Will return whether the current environment is in a regular browser
// and not CEF
export const isEnvBrowser = (): boolean => !(window as any).invokeNative;

// Basic no operation function
export const noop = () => {};

// Random Id generator for unique keys
export const randomId = () => Math.random().toString(36).substr(2, 9);