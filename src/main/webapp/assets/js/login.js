// petit effet “ripple” sur le bouton
document.querySelectorAll('.btn-login').forEach(btn => {
    btn.addEventListener('click', e => {
        const ripple = document.createElement('span');
        const rect   = btn.getBoundingClientRect();
        const size   = Math.max(rect.width, rect.height);
        const x      = e.clientX - rect.left - size/2;
        const y      = e.clientY - rect.top  - size/2;

        ripple.style.cssText = `
      position: absolute;
      width: ${size}px; height: ${size}px;
      top: ${y}px; left: ${x}px;
      background: rgba(255,255,255,0.4);
      border-radius: 50%;
      transform: scale(0);
      animation: ripple 0.6s linear;
      pointer-events: none;
    `;
        btn.style.position = 'relative';
        btn.appendChild(ripple);
        setTimeout(() => ripple.remove(), 600);
    });
});
