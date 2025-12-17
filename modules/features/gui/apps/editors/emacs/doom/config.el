(setq doom-theme 'doom-tomorrow-night)

(setq doom-font (font-spec :family "Cascadia Code" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Cascadia Code" :size 16))
(setq display-line-numbers-type `relative)
(setq org-directory "~/org/")
(setq dap-auto-configure-mode t)
(after! eglot
  ;; Always use nixd for Nix buffers
  (add-to-list 'eglot-server-programs
               '((nix-mode nix-ts-mode) . ("nixd"))))
(after! nix-mode
  (add-hook 'nix-mode-hook #'eglot-ensure))

(when (fboundp 'nix-ts-mode)
  (add-hook 'nix-ts-mode-hook #'eglot-ensure))
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

(after! desktop
  (setq desktop-dirname doom-cache-dir
        desktop-path (list desktop-dirname)
        desktop-base-file-name "desktop"
        desktop-base-lock-name "desktop.lock"
        desktop-load-locked-desktop t
        desktop-save 'if-exists
        desktop-files-not-to-save
        "\\(\\.gz\\|\\.zip\\|\\.tar\\|\\.elc\\|\\.git/\\|/ssh:\\|/sudo:\\)"))

(desktop-save-mode 1)
(add-hook 'kill-emacs-hook #'desktop-save-in-desktop-dir)
