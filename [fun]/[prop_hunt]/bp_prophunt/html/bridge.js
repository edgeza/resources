// Bridge NUI -> client: notify UI active state and role
(function(){
  try {
    window.addEventListener('message', function (ev) {
      try {
        if (!ev || !ev.data) return;

        if (ev.data.action === 'setupglobalui') {
          // Inform client that UI became active
          fetch('https://bp_prophunt/ui_state', {method:'POST', body: JSON.stringify({ state: 'active' })});
          // Also forward role if provided
          if (ev.data.yourdata && ev.data.yourdata.role) {
            fetch('https://bp_prophunt/roleupdate', {method:'POST', body: JSON.stringify({ role: ev.data.yourdata.role })});
          }
        }

        if (ev.data.action === 'stopjavascript' || ev.data.action === 'stopprophuntui') {
          // Inform client that UI became inactive
          fetch('https://bp_prophunt/ui_state', {method:'POST', body: JSON.stringify({ state: 'inactive' })});
        }
      } catch (_) {}
    });
  } catch (_) {}
})();


