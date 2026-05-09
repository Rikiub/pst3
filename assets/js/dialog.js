// Cerrar cualquier <dialog> de PicoCSS
document.addEventListener('click', (e) => {
    const dialog = e.target.closest('dialog');
    if (!dialog || !dialog.open) return;
    const article = dialog.querySelector(':scope > article');    // PicoCSS espera <article>

    // Cerrar si se clicea fuera de <article> (o en cualquier momento)
    if (!article || !article.contains(e.target)) {
        dialog.close();
        document.documentElement.classList.remove('modal-is-open');
    }
});

// Cerrar en Escape
document.addEventListener('cancel', (e) => {
    const dialog = e.target;
    if (dialog?.localName === 'dialog' && dialog.open) {
        e.preventDefault();
        dialog.close();
        document.documentElement.classList.remove('modal-is-open');
    }
}, { capture: true });