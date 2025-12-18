;;; ~/.doom.d/lsp.el -*- lexical-binding: t; -*-

(use-package! lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-auto-configure t
        lsp-completion-provider :capf
        lsp-enable-snippet t
        lsp-enable-symbol-highlighting t
        lsp-enable-links t
        lsp-semantic-tokens-enable t
        lsp-lens-enable t
        lsp-inlay-hint-enable t
        lsp-eldoc-enable-hover t
        lsp-eldoc-render-all t
        lsp-signature-auto-activate t
        lsp-signature-render-documentation t
        lsp-headerline-breadcrumb-enable t
        lsp-modeline-code-actions-enable t
        lsp-modeline-diagnostics-enable t)
  :config
  (add-hook 'lsp-mode-hook #'lsp-inlay-hints-mode))

(use-package! lsp-ui
  :after lsp-mode
  :init
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-delay 0.15
        lsp-ui-doc-show-with-cursor t
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-peek-enable t)
  :config
  (add-hook 'lsp-mode-hook #'lsp-ui-mode))

(use-package! dap-mode
  :after lsp-mode
  :commands (dap-debug dap-debug-edit-template)
  :init
  (setq dap-auto-configure-mode t
        dap-auto-configure-features '(sessions locals controls tooltip))
  :config
  (dap-auto-configure-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (require 'dap-lldb)
  (require 'dap-codelldb))

(use-package! lsp-rust
  :after (lsp-mode rust-mode)
  :init
  (setq lsp-rust-server 'rust-analyzer
        lsp-rust-analyzer-server-display-inlay-hints t
        lsp-rust-analyzer-display-parameter-hints t
        lsp-rust-analyzer-display-chaining-hints t
        lsp-rust-analyzer-display-closure-return-type-hints t
        lsp-rust-analyzer-display-lifetime-elision-hints-enable "always"
        lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names t
        lsp-rust-analyzer-display-reborrow-hints "always"
        lsp-rust-analyzer-display-expression-adjustment-hints "always"
        lsp-rust-analyzer-display-binding-mode-hints t
        lsp-rust-analyzer-display-closure-capture-hints t
        lsp-rust-analyzer-proc-macro-enable t
        lsp-rust-analyzer-lens-enable t)
  :config
  (add-hook 'rust-mode-hook #'lsp-deferred))

(use-package! nix-mode
  :defer t)

(after! lsp-mode
  (require 'lsp-client)

  (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection (lambda () (list "nixd")))
    :activation-fn (lsp-activate-on "nix")
    :server-id 'nixd
    :major-modes '(nix-mode)))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection (lambda () (list "nil")))
    :activation-fn (lsp-activate-on "nix")
    :server-id 'nil
    :major-modes '(nix-mode)))

  (add-hook! 'nix-mode-hook
    (defun +nix-lsp-start-both ()
      (setq-local lsp-enabled-clients '(nixd nil))
      (lsp-deferred))))

(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
(message "loaded lsp.el")
