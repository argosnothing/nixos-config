;; -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Cascadia Code" :size 19 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Cascadia Code" :size 16))
(setq display-line-numbers-type `relative)
(setq org-directory "~/org/")
(setq dap-auto-configure-mode t)
(require 'comint)

(use-package! elcord
  :hook (after-init . elcord-mode)
  :config
  (setq elcord-use-major-mode-as-main-icon t
        elcord-refresh-rate 5))

(use-package! nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(defmacro define-qat-command (name program)
  `(defun ,name ()
     ,(format "Run `%s` in a floating kitty terminal." program)
     (interactive)
     (start-process
      ,(symbol-name name) nil
      "kitty"
      "--class" "kitty_floating"
      "bash" "-lc" ,program)))

(define-qat-command rebuilds "rebuilds")
(define-qat-command rebuildb "rebuildb")
(define-qat-command record-region "record-region")

(defun qat--run-cmd (cmd &optional dir)
  (let* ((default-directory (or dir default-directory))
         (pname (format "qat-%d" (abs (random)))))
    (start-process pname nil
                   "kitty" "--class" "kitty_floating"
                   "bash" "-lc" cmd)))

(advice-add 'copilot--infer-indentation-offset :around
            (lambda (orig-fn &rest args)
              (ignore-errors (apply orig-fn args))))


(after! company
  (setq company-backends '(company-capf)))

(global-set-key (kbd "M-SPC") 'avy-goto-word-0)
(map! "C-o" nil)
(map! "C-o" #'dirvish)
(after! evil
  (map! :n "C-o" #'dirvish
        :m "C-o" #'dirvish
        :i "C-o" #'dirvish))

(vertico-posframe-mode 1)

(load! "config/default")
