(setq doom-theme 'doom-dark+)

(setq doom-font (font-spec :family "Cascadia Code" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Cascadia Code" :size 16))
(setq display-line-numbers-type `relative)
(setq org-directory "~/org/")
(setq dap-auto-configure-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (after! eglot                                         ;;
;;   (add-to-list 'eglot-server-programs                 ;;
;;                '((nix-mode nix-ts-mode) . ("nixd")))) ;;
;; (after! nix-mode                                      ;;
;;   (add-hook 'nix-mode-hook #'eglot-ensure))           ;;
;;  ;;
;; (when (fboundp 'nix-ts-mode)                          ;;
;;   (add-hook 'nix-ts-mode-hook #'eglot-ensure))        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

(load! "config/default")
(global-set-key (kbd "M-SPC") 'avy-goto-word-0)
(vertico-posframe-mode 1)
