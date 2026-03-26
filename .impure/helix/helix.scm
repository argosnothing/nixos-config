; ; # helix.scm
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(provide shell git-add open-helix-scm open-init-scm nnd-write-bp)

(define (current-path)
  (let* ([focus (editor-focus)]
         [focus-doc-id (editor->doc-id focus)])
    (editor-document->path focus-doc-id)))

;;@doc
;; Specialized shell implementation, where % is a wildcard for the current file
(define (shell . args)
  (helix.run-shell-command
    (string-join
      ;; Replace the % with the current file
      (map (lambda (x) (if (equal? x "%") (current-path) x)) args)
      " ")))

;;@doc
;; Adds the current file to git	
(define (git-add)
  (shell "git" "add" "%"))

;;@doc
;; Open the helix.scm file
(define (open-helix-scm)
  (helix.open (helix.static.get-helix-scm-path)))

;;@doc
;; Opens the init.scm file
(define (open-init-scm)
  (helix.open (helix.static.get-init-scm-path)))

;;@doc
;; Write current file:line to /tmp/nnd-bp for nnd-launch to pick up
(define (nnd-write-bp)
  (let* ([path (current-path)]
         [line (+ 1 (helix.static.get-current-line-number))]
         [bp (string-append path ":" (number->string line))])
    (helix.run-shell-command (string-append "echo " bp " > /tmp/nnd-bp"))))

