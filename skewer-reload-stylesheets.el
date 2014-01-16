;; skewer-reload-stylesheets.el -- live-edit CSS stylesheets.

;; This is free and unencumbered software released into the public domain.

;; Author: Nate Eagleson <nate@nateeag.com>
;; Created: November 23, 2013
;; Package-Requires: ((skewer-mode "1.5.3"))
;; Version: 0.0.1

;; This minor mode provides functionality for reloading whole CSS stylesheets
;; in-place. When dealing with stylesheets where the cascade is significant,
;; this can be much more convenient behavior than skewer-css.el.

;; * C-x C-r -- `skewer-reload-stylesheets-reload-buffer`

(defun skewer-reload-stylesheets-reload-buffer ()
  "Reload the current buffer IF it is already included as a link tag."

  (interactive)
  (save-buffer)

  ;; TODO I tried to use skewer-apply, but it said skewer.reloadStylesheet was
  ;; not a valid function.
  (skewer-eval (concat "skewer.reloadStylesheet(\"" (buffer-file-name) "\");")))

(defun skewer-reload-stylesheets-skewer-js-hook ()
  "Skewer hook function to insert JS for reloading CSS files."
  (insert-file-contents
   (expand-file-name "skewer-reload-stylesheets.js" skewer-reload-stylesheets-data-root)))

;; GRIPE Seems like bad style to have loading this file ram a hook into skewer,
;; especially since skewer may not even be loaded yet.
(add-hook 'skewer-js-hook 'skewer-reload-stylesheets-skewer-js-hook)

;; Minor mode definition

(defvar skewer-reload-stylesheets-mode-map
  (let ((map (make-sparse-keymap)))
    (prog1 map
      (define-key map (kbd "C-x C-r") 'skewer-reload-stylesheets-reload-buffer)))
  "Keymap for skewer-reload-stylesheets-mode.")

(defvar skewer-reload-stylesheets-data-root (file-name-directory load-file-name)
  "Location of data files needed by skewer-reload-stylesheets-mode.")

;;;###autoload
(define-minor-mode skewer-reload-stylesheets-mode
  "Minor mode for interactively reloading CSS stylesheets."
  :lighter " reload-ss"
  :keymap skewer-reload-stylesheets-mode-map
  :group 'skewer)

;;; skewer-reload-stylesheets.el ends here
