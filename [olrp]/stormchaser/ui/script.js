const tablet = document.getElementById('tablet');
const canvas = document.getElementById('stormMap');
const ctx = canvas.getContext('2d');
const stormDetails = document.getElementById('stormDetails');
const probeList = document.getElementById('probeList');
const stormStatus = document.getElementById('stormStatus');
const closeBtn = document.getElementById('closeBtn');

let isVisible = false;
let stormData = null;
let probeData = [];
let mapBounds = null;
let stormTrail = [];

const MAX_TRAIL_POINTS = 30;

function toggleTablet(show) {
    isVisible = show;
    tablet.classList.toggle('hidden', !show);
    if (show) {
        tablet.focus();
        post('requestStorm');
        post('requestProbes');
    } else {
        stormStatus.textContent = '';
    }
}

function post(action, data = {}) {
    fetch(`https://${GetParentResourceName()}/${action}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify(data)
    }).catch(() => {});
}

function formatTimeRemaining(expires) {
    if (!expires) return 'Unknown';
    const now = Math.floor(Date.now() / 1000);
    const diff = Math.max(0, expires - now);
    const minutes = Math.floor(diff / 60);
    const seconds = diff % 60;
    return `${minutes}m ${seconds < 10 ? '0' : ''}${seconds}s`;
}

function updateStormDetails() {
    if (!stormData) {
        stormDetails.classList.add('state-idle');
        stormDetails.innerHTML = '<p>No active storms detected.</p>';
        stormStatus.textContent = '';
        return;
    }

    stormDetails.classList.remove('state-idle');
    const { id, heading, expires } = stormData;
    const timeRemaining = formatTimeRemaining(expires);
    stormDetails.innerHTML = `
        <p><strong>ID:</strong> ${id}</p>
        <p><strong>Heading:</strong> ${heading.toFixed(0)}°</p>
        <p><strong>Time Remaining:</strong> ${timeRemaining}</p>
        <p><strong>Inner Core Radius:</strong> ${stormData.radius?.inner ?? 0} m</p>
        <p><strong>Outer Band Radius:</strong> ${stormData.radius?.outer ?? 0} m</p>
    `;
    stormStatus.textContent = 'Active storm cell tracking...';
}

function updateProbeDetails() {
    if (!probeData || probeData.length === 0) {
        probeList.innerHTML = '<p>No probes deployed. Use the probe item to deploy ahead of the storm.</p>';
        return;
    }

    probeList.innerHTML = '';
    probeData.forEach((probe) => {
        const element = document.createElement('div');
        element.className = `probe ${probe.ready ? 'ready' : ''}`;
        const status = probe.ready ? `Captured (${probe.quality})` : 'Awaiting data';
        element.innerHTML = `
            <p><strong>${probe.id}</strong></p>
            <p>Status: ${status}</p>
        `;
        probeList.appendChild(element);
    });
}

function projectCoord(coord) {
    if (!mapBounds) return null;
    const { min, max } = mapBounds;
    const width = canvas.width;
    const height = canvas.height;
    const xRatio = (coord.x - min.x) / (max.x - min.x);
    const yRatio = (coord.y - min.y) / (max.y - min.y);
    return {
        x: xRatio * width,
        y: height - (yRatio * height)
    };
}

function metresToPixels(metres) {
    if (!mapBounds) return 0;
    const width = canvas.width;
    const mapWidth = mapBounds.max.x - mapBounds.min.x;
    return (metres / mapWidth) * width;
}

function drawStorm() {
    if (!stormData || !mapBounds) return;

    const center = projectCoord(stormData.coords);
    if (!center) return;

    const outerRadius = metresToPixels(stormData.radius?.outer ?? 200);
    const innerRadius = metresToPixels(stormData.radius?.inner ?? 120);

    const gradient = ctx.createRadialGradient(center.x, center.y, 10, center.x, center.y, outerRadius);
    gradient.addColorStop(0, 'rgba(0, 215, 255, 0.65)');
    gradient.addColorStop(0.5, 'rgba(0, 120, 255, 0.35)');
    gradient.addColorStop(1, 'rgba(0, 40, 90, 0)');
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(center.x, center.y, outerRadius, 0, Math.PI * 2);
    ctx.fill();

    ctx.strokeStyle = 'rgba(0, 230, 150, 0.85)';
    ctx.lineWidth = 3;
    ctx.beginPath();
    ctx.arc(center.x, center.y, innerRadius, 0, Math.PI * 2);
    ctx.stroke();

    ctx.fillStyle = 'rgba(0, 255, 200, 0.9)';
    ctx.beginPath();
    ctx.arc(center.x, center.y, 6, 0, Math.PI * 2);
    ctx.fill();
}

function drawTrail() {
    if (!stormTrail.length || !mapBounds) return;
    ctx.strokeStyle = 'rgba(0, 160, 255, 0.6)';
    ctx.lineWidth = 2;
    ctx.beginPath();
    stormTrail.forEach((coord, index) => {
        const point = projectCoord(coord);
        if (!point) return;
        if (index === 0) {
            ctx.moveTo(point.x, point.y);
        } else {
            ctx.lineTo(point.x, point.y);
        }
    });
    ctx.stroke();
}

function drawProbes() {
    if (!probeData || !probeData.length) return;
    probeData.forEach((probe) => {
        const point = projectCoord(probe.coords);
        if (!point) return;
        ctx.fillStyle = probe.ready ? 'rgba(0, 255, 120, 0.9)' : 'rgba(255, 210, 70, 0.9)';
        ctx.beginPath();
        ctx.arc(point.x, point.y, 6, 0, Math.PI * 2);
        ctx.fill();
        ctx.font = '12px Segoe UI';
        ctx.fillStyle = '#ffffff';
        ctx.fillText(probe.id, point.x + 8, point.y + 4);
    });
}

function render() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = 'rgba(6, 10, 18, 0.9)';
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    drawTrail();
    drawStorm();
    drawProbes();

    requestAnimationFrame(render);
}

window.addEventListener('message', (event) => {
    const data = event.data;
    if (!data || !data.action) return;

    switch (data.action) {
        case 'tablet':
            toggleTablet(data.show);
            break;
        case 'stormUpdate':
            if (data.mapBounds) {
                mapBounds = data.mapBounds;
            }
            if (data.storm) {
                stormData = data.storm;
                stormTrail.push(stormData.coords);
                if (stormTrail.length > MAX_TRAIL_POINTS) {
                    stormTrail.shift();
                }
            } else {
                stormData = null;
                stormTrail = [];
            }
            updateStormDetails();
            break;
        case 'probeUpdate':
            if (data.mapBounds) {
                mapBounds = data.mapBounds;
            }
            probeData = data.probes || [];
            updateProbeDetails();
            break;
    }
});

closeBtn.addEventListener('click', () => {
    toggleTablet(false);
    post('close');
});

document.addEventListener('keyup', (event) => {
    if (event.key === 'Escape' && isVisible) {
        toggleTablet(false);
        post('close');
    }
});

render();

