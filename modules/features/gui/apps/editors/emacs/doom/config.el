(setq doom-theme 'doom-tomorrow-night)

(setq doom-font (font-spec :family "Cascadia Code" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Cascadia Code" :size 16))
(setq display-line-numbers-type `relative)
(setq org-directory "~/org/")
(setq dap-auto-configure-mode t)
(after! eglot
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

(defun flake-update ())
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

(defun qat--flake-root (&optional start)
 (let ((dir (file-name-as-directory (expand-file-name (or start default-directory)))))
   (or (locate-dominating-file dir "flake.nix")
       (user-error "Couldn't find flake.nix above %s" dir))))


(defun flake-update (x)
 (interactive (list (read-string "nix flake update arg: " (thing-at-point 'symbol t))))
 (qat--run-cmd (format "nix flake update %s" x) (qat--flake-root)))
(load! "config/default")
