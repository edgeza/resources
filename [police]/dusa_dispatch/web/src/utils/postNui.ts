import { isEnvBrowser } from "./misc";

export async function postNui(
  eventName: string,
  data?: unknown,
): Promise<void> { 
  const options = {
    method: "post",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify(data),
  };

  if (isEnvBrowser()) { 
       console.log('POST in browser:', options); 
       return;
  }

  const resourceName = (window as any).GetParentResourceName
    ? (window as any).GetParentResourceName()
    : "nui-frame-app";

  await fetch(`https://${resourceName}/${eventName}`, options);  
}