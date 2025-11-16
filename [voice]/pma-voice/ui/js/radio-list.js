(function () {
  const state = {
    players: [],
    uiEnabled: true,
    radioEnabled: true,
    radioChannel: 0,
  };

  const container = document.createElement('div');
  container.className = 'voiceRadioList';
  container.style.display = 'none';
  document.body.appendChild(container);

  const style = document.createElement('style');
  style.textContent = `
    .voiceRadioList {
      position: fixed;
      right: 5px;
      bottom: 55px;
      text-align: right;
      font-size: 12px;
      font-weight: bold;
      color: rgba(255, 255, 255, 0.8);
      font-family: Avenir, Helvetica, Arial, sans-serif;
      text-shadow: 1.25px 0 0 #000, 0 -1.25px 0 #000, 0 1.25px 0 #000, -1.25px 0 0 #000;
      pointer-events: none;
      z-index: 1000;
    }
    .voiceRadioList-entry {
      margin: 0;
      color: rgba(255, 255, 255, 0.6);
    }
    .voiceRadioList-entry.talking {
      color: #ffffff;
    }
    .voiceRadioList-entry.self {
      text-decoration: underline;
    }
  `;
  document.head.appendChild(style);

  function escapeHtml(value) {
    return String(value ?? '')
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }

  function render() {
    const shouldShow =
      state.uiEnabled &&
      state.radioEnabled &&
      state.radioChannel !== 0 &&
      state.players.length > 0;

    if (!shouldShow) {
      container.style.display = 'none';
      container.innerHTML = '';
      return;
    }

    container.style.display = 'block';

    container.innerHTML = state.players
      .map((player) => {
        const classes = [
          'voiceRadioList-entry',
          player.talking ? 'talking' : '',
          player.self ? 'self' : '',
        ]
          .filter(Boolean)
          .join(' ');
        return `<p class="${classes}">${escapeHtml(player.name)}</p>`;
      })
      .join('');
  }

  window.addEventListener('message', (event) => {
    const data = event.data || {};

    if (typeof data.uiEnabled === 'boolean') {
      state.uiEnabled = data.uiEnabled;
      render();
    }

    if (typeof data.radioEnabled === 'boolean') {
      state.radioEnabled = data.radioEnabled;
      render();
    }

    if (typeof data.radioChannel === 'number') {
      state.radioChannel = data.radioChannel;
      render();
    }

    if (data.radioPlayers !== undefined) {
      state.players = Array.isArray(data.radioPlayers) ? data.radioPlayers : [];
      render();
    }
  });
})();

