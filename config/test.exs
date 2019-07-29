use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :resulteer, ResulteerWeb.Endpoint,
  http: [port: 4002],
  server: false

config :resulteer, :repository, path: "test/TestData.csv"

# Print only warnings and errors during test
config :logger, level: :warn
