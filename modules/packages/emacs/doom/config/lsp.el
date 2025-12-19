;;; lsp.el -*- lexical-binding: t; -*-
(use-package! lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-inlay-hint-enable t
        lsp-lens-enable t
        lsp-semantic-tokens-enable t
        lsp-eldoc-enable-hover nil
        lsp-eldoc-render-all t
        lsp-signature-auto-activate t
        lsp-signature-render-documentation t)
  :config
  (add-hook 'lsp-managed-mode-hook
            (lambda ()
              (when (and (derived-mode-p 'rustic-mode 'rust-mode)
                         (lsp-feature? "textDocument/inlayHint"))
                (lsp-inlay-hints-mode 1)
                ))))

(use-package! lsp-ui
  :after lsp-mode
  :init
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-delay 0.15
        lsp-ui-doc-show-with-cursor t
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-peek-enable t)
  :config
  (add-hook 'lsp-managed-mode-hook
            (lambda ()
              (when (derived-mode-p 'rustic-mode 'rust-mode)
                (lsp-ui-mode 1)))))

(use-package! lsp-rust
  :after lsp-mode
  :init
  (setq lsp-rust-server 'rust-analyzer
        lsp-rust-analyzer-server-display-inlay-hints t
        lsp-rust-analyzer-display-parameter-hints nil
        lsp-rust-analyzer-display-chaining-hints nil
        lsp-rust-analyzer-display-closure-return-type-hints nil
        lsp-rust-analyzer-display-lifetime-elision-hints-enable "never"
        lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil
        lsp-rust-analyzer-display-reborrow-hints "never"
        lsp-rust-analyzer-display-expression-adjustment-hints "never"
        lsp-rust-analyzer-display-binding-mode-hints nil
        lsp-rust-analyzer-display-closure-capture-hints nil))

(use-package! rustic
  :hook (rustic-mode-local-vars . lsp-deferred))
(use-package! lsp-ui
  :hook(lsp-mode . lsp-ui-mode))

;; remap xref-find-definitions(M-.) and xref-find-references(M-?) to lsp-ui-peek
(define-key lsp-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
