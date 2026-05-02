<?php

/**
 * Dialog/Modal component — uses native <dialog> element
 *
 * Variables:
 *   $id      - Unique ID (required)
 *   $titulo  - Heading text
 *   $content - Inner HTML
 *   $class   - Extra CSS classes for the <dialog>
 */
$id = $id ?? 'dialog-' . uniqid();
$titulo = $titulo ?? '';
$content = $content ?? '';
$class = $class ?? '';
?>

<dialog
	id="<?= $this->e($id) ?>"
	class="dialog <?= $this->e($class) ?>"
	aria-labelledby="<?= $this->e($id) ?>-title"
>
	<div class="dialog-header">
		<h2 id="<?= $this->e($id) ?>-title" class="dialog-title">
			<?= $this->e($titulo) ?>
		</h2>
		
		<button
			class="dialog-close"
			aria-label="Close"
			data-dialog-close="<?= $this->e($id) ?>"
		>&times;</button>
	</div>

	<div class="dialog-content">
		<?= $this->insert($content) ?>
	</div>
</dialog>

<script>
	/**
	 * Open a dialog by its ID using showModal().
	 */
	function openDialog(id) {
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

	document.addEventListener('click', function (e) {
		// 1) Close button clicked
		const closeBtn = e.target.closest('[data-dialog-close]');

		if (closeBtn) {
			const id = closeBtn.getAttribute('data-dialog-close');
			const dialog = document.getElementById(id);
			if (dialog) dialog.close();
			return;
		}

		// 2) Clicked the backdrop area (the <dialog> itself, not its children)
		if (e.target.tagName === 'DIALOG' && e.target.open) {
			e.target.close();
		}
	});
</script>