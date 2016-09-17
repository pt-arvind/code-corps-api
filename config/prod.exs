use Mix.Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
#
# Finally, we also include the path to a manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.
config :code_corps, CodeCorps.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "api.codecorps.org", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configure your database
config :code_corps, CodeCorps.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

# CORS allowed origins
config :code_corps, allowed_origins: [
  "http://codecorps.org",
  "http://www.codecorps.org",
  "https://codecorps.org",
  "https://www.codecorps.org"
]

config :guardian, Guardian,
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

config :sentry,
  dsn: System.get_env("SENTRY_DSN"),
  tags: %{
    env: "production"
  },
  use_error_logger: true

# Do not print debug messages in production
config :logger, level: :info

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :code_corps, CodeCorps.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [port: 443,
#               keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#               certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables return an absolute path to
# the key and cert in disk or a relative path inside priv,
# for example "priv/ssl/server.key".
#
# We also recommend setting `force_ssl`, ensuring no data is
# ever sent via http, always redirecting to https:
#
#     config :code_corps, CodeCorps.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :code_corps, CodeCorps.Endpoint, server: true
#
# You will also need to set the application root to `.` in order
# for the new static assets to be served after a hot upgrade:
#
#     config :code_corps, CodeCorps.Endpoint, root: "."
