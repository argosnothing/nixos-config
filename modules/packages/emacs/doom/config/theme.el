;;; theme.el --- Themes -*- lexical-binding: t; -*-
;;; Commentary:
;; Theme stuff.
;;; Code:

;;(setq doom-theme 'doom-dark+)
(eval-when-compile
  (defvar doom-theme)
  (defvar global-hl-line-modes))

;;(setq doom-theme 'doom-ir-black)
(setq global-hl-line-modes nil)
(add-to-list 'custom-theme-load-path (expand-file-name "~/.config/doom/themes"))
;;(load-theme 'noctalia t);; < This one comes from noctalia itself
(load-theme 'leuven) ;; < I quite like this light theme.
;;; theme.el ends here

(provide 'theme)
