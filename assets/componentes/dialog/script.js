/**
 * Open a dialog by its ID using showModal().
 */
function showDialog(id) {
    const dialog = document.getElementById(id);
    if (dialog) dialog.showModal();
}

/**
 * Close a dialog by its ID.
 */
function closeDialog(id) {
    const dialog = document.getElementById(id);
    if (dialog) dialog.close();
}