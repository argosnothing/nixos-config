;;; theme.el --- Themes -*- lexical-binding: t; -*-
;;; Commentary:
;; Theme stuff.
;;; Code:

;;(setq doom-theme 'doom-dark+)
(eval-when-compile
  (defvar doom-theme)
  (defvar global-hl-line-modes))

(setq doom-theme 'doom-ir-black)
;;(setq doom-theme 'doom-badger)
(setq global-hl-line-modes nil)
(add-to-list 'custom-theme-load-path (expand-file-name "~/.config/doom/themes"))
;;(load-theme 'noctalia t)
;;
;;; theme.el ends here

(provide 'theme)
