;;; mcp.el -*- lexical-binding: t; -*-

(setopt mcp-hub-servers
        '(("github" .
           (:command
            "docker"
            :args
            ("run"
             "-i"
             "--rm"
             "-e"
             "GITHUB_PERSONAL_ACCESS_TOKEN"
             "ghcr.io/github/github-mcp-server")
            :env
            (:GITHUB_PERSONAL_ACCESS_TOKEN
             (string-trim
              (with-temp-buffer
                (insert-file-contents "/run/secrets/github_token")
                (buffer-string))))))))
