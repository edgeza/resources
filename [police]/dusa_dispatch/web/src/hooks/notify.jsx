import { useUiEvent } from "../utils/useUiEvent"

export const useNotify = (description) => {
  useUiEvent([
    {
      action: "NOTIFY",
      data: {
        description: description,
      },
    },
  ])
}
