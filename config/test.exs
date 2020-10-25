use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :app_test, AppTest.Repo,
  username: "postgres",
  password: "chatriki13",
<<<<<<< HEAD
#  database: "app_test_test#{System.get_env("MIX_TEST_PARTITION")}",
  database: "time_manager",
=======
  database: "time_manager#{System.get_env("MIX_TEST_PARTITION")}",
>>>>>>> master
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :app_test, AppTestWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
