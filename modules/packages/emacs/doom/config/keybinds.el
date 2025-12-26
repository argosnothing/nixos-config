;;; keybinds.el --- Description -*- lexical-binding: t; -*-
;;; Commentary:
;; Keybinds
;;; Code:

(require 'dirvish)
(require 'doom)
(require 'magit)
(eval-when-compile
  (declare-function map! "doom-keybinds"))


(global-set-key (kbd "M-SPC") 'avy-goto-word-0)
(map! "C-o" nil)
(map! "C-o" #'dirvish)
(map! :leader
      :desc "Magit"
      "o g" #'magit)
(after! evil
  (map! :n "C-o" #'dirvish
        :m "C-o" #'dirvish
        :i "C-o" #'dirvish))



(provide 'keybinds)
;;; keybinds.el ends here
