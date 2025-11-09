(() => {
  const BADGE_CLASS = 'cdg-patreon-tier-badge';
  const BADGE_SELECTOR = `.${BADGE_CLASS}`;
  const THEME_CLASS = 'cdg-patreon-theme';
  const OBSERVE_TARGET_ID = 'app';
  const ITEM_SELECTOR = '.json-item';
  const VEHICLE_LABEL_SELECTORS = [
    '.vehicle-label',
    '.vehicle-name',
    '.vehicle-container .vehicle-name'
  ];
  const VEHICLE_IMAGE_SELECTORS = [
    '.vehicle-image-container object[data]',
    '.vehicle-image-container img[src]',
    'object[data]',
    'img[src]'
  ];
  const FALLBACK_IMAGE_NAMES = new Set(['fallback']);
  const tierLabels = {
    1: 'Tier 1',
    2: 'Tier 2',
    3: 'Tier 3',
    4: 'Tier 4'
  };

  let patreonConfig = null;
  let observer = null;
  let scheduledUpdate = null;
  let stylesAttached = false;

  function normalise(value) {
    if (value === null || value === undefined) {
      return '';
    }
    return String(value).trim().toUpperCase();
  }

  function ensureStyles() {
    if (stylesAttached) {
      return;
    }

    const style = document.createElement('style');
    style.id = 'cdg-patreon-tier-style';
    style.textContent = `
      body.${THEME_CLASS} {
        --json-menu-background: rgba(92, 16, 38, 0.92);
        --json-menu-item: rgba(20, 12, 16, 0.94);
        --json-menu-item-hover: rgba(34, 16, 24, 0.95);
        --json-menu-item-active: rgba(138, 21, 52, 0.95);
        --json-menu-item-border: rgba(255, 255, 255, 0.08);
      }
      ${BADGE_SELECTOR} {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        margin-left: 0.4rem;
        padding: 0.1rem 0.45rem;
        border-radius: 999px;
        font-size: 0.65rem;
        font-weight: 600;
        letter-spacing: 0.02em;
        text-transform: uppercase;
        color: #fff;
        background: rgba(13, 110, 253, 0.85);
        box-shadow: 0 0 6px rgba(0, 0, 0, 0.35);
      }
      ${BADGE_SELECTOR}[data-tier='2'] {
        background: rgba(25, 135, 84, 0.88);
      }
      ${BADGE_SELECTOR}[data-tier='3'] {
        background: rgba(255, 193, 7, 0.9);
        color: #1f1402;
      }
      ${BADGE_SELECTOR}[data-tier='4'] {
        background: rgba(220, 53, 69, 0.9);
      }
    `;

    document.head.appendChild(style);
    stylesAttached = true;
  }

  function findTier(spawnCode) {
    if (!patreonConfig || !patreonConfig.tiers) {
      return null;
    }

    const target = normalise(spawnCode);
    if (!target) {
      return null;
    }

    let minTier = null;
    for (const [tier, tierData] of Object.entries(patreonConfig.tiers)) {
      const tierNumber = Number(tier);
      if (!tierData || Number.isNaN(tierNumber)) {
        continue;
      }

      const collections = [tierData.cars, tierData.boats, tierData.air];
      for (const collection of collections) {
        if (!Array.isArray(collection)) {
          continue;
        }
        for (const entry of collection) {
          if (normalise(entry) === target) {
            if (minTier === null || tierNumber < minTier) {
              minTier = tierNumber;
            }
            break;
          }
        }
      }
    }

    return minTier;
  }

  function parseSpawnFromPath(path) {
    if (!path) {
      return null;
    }

    const match = /\/([^\/]+)\.(webp|png|jpe?g)$/i.exec(path);
    if (!match) {
      return null;
    }

    const name = normalise(match[1]);
    if (!name || FALLBACK_IMAGE_NAMES.has(name.toLowerCase())) {
      return null;
    }

    return name;
  }

  function extractSpawnCode(root) {
    if (!root || !(root instanceof Element)) {
      return null;
    }

    const datasetSpawn = root.getAttribute('data-spawn');
    if (datasetSpawn) {
      return normalise(datasetSpawn);
    }

    for (const selector of VEHICLE_IMAGE_SELECTORS) {
      const node = root.querySelector(selector);
      if (!node) {
        continue;
      }

      // <object data="..."> preferred
      if (node instanceof HTMLObjectElement) {
        const spawn = parseSpawnFromPath(node.data);
        if (spawn) {
          return spawn;
        }
      }

      // <img src="...">
      if (node instanceof HTMLImageElement) {
        const spawn = parseSpawnFromPath(node.currentSrc || node.src);
        if (spawn) {
          return spawn;
        }
      }

      // generic element with data/src attribute
      const attr = node.getAttribute('data') || node.getAttribute('src');
      const spawn = parseSpawnFromPath(attr);
      if (spawn) {
        return spawn;
      }
    }

    return null;
  }

  function getVehicleLabelElement(item) {
    if (!item || !(item instanceof Element)) {
      return null;
    }

    for (const selector of VEHICLE_LABEL_SELECTORS) {
      const node = item.querySelector(selector);
      if (node) {
        return node;
      }
    }
    return null;
  }

  function setBadge(labelElement, tier) {
    // Tier badges disabled - car labels already show tier information
    // Remove any existing badges
    if (labelElement) {
      const badge = labelElement.querySelector(BADGE_SELECTOR);
      if (badge) {
        badge.remove();
      }
    }
    return;
  }

  function updateItem(item) {
    if (!patreonConfig || patreonConfig.ENABLE === false) {
      setBadge(getVehicleLabelElement(item), null);
      return;
    }

    const label = getVehicleLabelElement(item);
    if (!label) {
      return;
    }

    const spawn = extractSpawnCode(item);
    if (spawn) {
      item.setAttribute('data-spawn', spawn);
    }

    const tier = spawn ? findTier(spawn) : null;
    setBadge(label, tier);
  }

  function updateAll() {
    scheduledUpdate = null;
    const items = document.querySelectorAll(ITEM_SELECTOR);
    if (items.length === 0) {
      return;
    }
    items.forEach(updateItem);
  }

  function scheduleUpdate() {
    if (scheduledUpdate !== null) {
      cancelAnimationFrame(scheduledUpdate);
    }
    scheduledUpdate = requestAnimationFrame(updateAll);
  }

  function clearBadges() {
    document.querySelectorAll(BADGE_SELECTOR).forEach((badge) => badge.remove());
  }

  function toggleTheme(isPatreon) {
    ensureStyles();
    document.body.classList.toggle(THEME_CLASS, Boolean(isPatreon));
  }

  function attachObserver() {
    if (observer) {
      return;
    }

    const target = document.getElementById(OBSERVE_TARGET_ID);
    if (!target) {
      window.setTimeout(attachObserver, 250);
      return;
    }

    observer = new MutationObserver(() => {
      if (patreonConfig) {
        scheduleUpdate();
      }
    });

    observer.observe(target, {
      childList: true,
      subtree: true
    });
  }

  function handleMessage(event) {
    const payload = event?.data;
    if (!payload || !payload.action) {
      return;
    }

    switch (payload.action) {
      case 'cd_garage:addTierIndicators': {
        patreonConfig = payload.patreonTiers || null;
        attachObserver();
        scheduleUpdate();
        break;
      }
      case 'cd_garage:clearTierIndicators': {
        clearBadges();
        break;
      }
      case 'cd_garage:setTheme': {
        toggleTheme(Boolean(payload.patreon));
        break;
      }
      default:
        break;
    }
  }

  window.addEventListener('message', handleMessage);
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', attachObserver);
  } else {
    attachObserver();
  }
})();
