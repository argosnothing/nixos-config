{
  flake.modules.nixos.matrix-home-server = let
    domain = "argos-nothing.me";
    matrixDomain = "matrix.${domain}";
    clientConfig = {
      "m.homeserver".base_url = "https://${matrixDomain}";
      "m.identity_server" = {};
    };
    serverConfig = {
      "m.server" = "${matrixDomain}:443";
    };
    mkWellKnown = data: ''
      default_type application/json;
      add_header Access-Control-Allow-Origin *;
      return 200 '${builtins.toJSON data}';
    '';
  in {
    services.matrix-synapse = {
      enable = true;
      settings = {
        server_name = domain;
        public_baseurl = "https://${matrixDomain}";

        listeners = [
          {
            port = 8008;
            bind_addresses = ["127.0.0.1"];
            type = "http";
            tls = false;
            x_forwarded = true;
            resources = [
              {
                names = ["client" "federation"];
                compress = true;
              }
            ];
          }
        ];

        database = {
          name = "psycopg2";
          allow_unsafe_locale = true;
          args = {
            user = "matrix-synapse";
            database = "matrix-synapse";
            host = "/run/postgresql";
          };
        };

        max_upload_size_mib = 400;
        url_preview_enabled = true;
        enable_registration = false;
        enable_metrics = false;
        registration_shared_secret_path = "/var/lib/matrix-synapse/registration_secret";

        trusted_key_servers = [
          {
            server_name = "matrix.org";
          }
        ];
      };
    };

    services.postgresql = {
      enable = true;
      ensureDatabases = ["matrix-synapse"];
      ensureUsers = [
        {
          name = "matrix-synapse";
          ensureDBOwnership = true;
        }
      ];
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "argosnothing@gmail.com";
    };

    services.nginx.enable = true;
    services.openssh.enable = true;
    services.nginx.virtualHosts.${domain} = {
      enableACME = true;
      forceSSL = true;
      locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
      locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
    };

    services.nginx.virtualHosts.${matrixDomain} = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8008";
        extraConfig = ''
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header Host $host;
          client_max_body_size 400M;
        '';
      };
    };

    networking.firewall.allowedTCPPorts = [8448];

    my.persist.root.directories = [
      "/var/lib/postgresql"
    ];
  };
}
