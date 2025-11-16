async function fetchNui(eventName, data) {
  try {
  const resp = await fetch(`https://dusa_hunting/${eventName}`, {
    method: 'post',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify(data),
  });

    if (!resp.ok) {
      throw new Error(`HTTP error! status: ${resp.status}`);
    }

  return await resp.json();
  } catch (error) {
    console.error('fetchNui error:', error);
    throw error;
  }
}

// Make fetchNui available globally
window.fetchNui = fetchNui;