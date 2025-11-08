interface DebugEvent<T = unknown> {
  action: string;
  data: T;
}

/**
 * Emulates dispatching an event using SendNuiMessage in the lua scripts.
 * This is used when developing in browser
 *
 * @param events - The event you want to cover
 * @param timer - How long until it should trigger (ms)
 */
export const useUiEvent = <P>(events: DebugEvent<P>[]): void => {
    for (const event of events) {
        window.dispatchEvent(
          new MessageEvent("message", {
            data: {
              action: event.action,
              data: event.data,
            },
          }),
        );
    }
};
