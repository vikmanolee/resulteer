defmodule Resulteer.MixProject do
  use Mix.Project

  def project do
    [
      app: :resulteer,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext, :phoenix_swagger] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Resulteer",
      source_url: "https://github.com/vikmanolee/resulteer",
      homepage_url: "http://localhost:4000",
      docs: [
        main: "Resulteer",
        logo: "logo.png",
        extras: ["README.md"]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Resulteer.Application, []},
      extra_applications: [:logger, :exprotobuf, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:nimble_csv, "~> 0.6"},
      {:exprotobuf, "~> 1.2.16"},
      {:phoenix, "~> 1.4.3"},
      {:phoenix_pubsub, "~> 1.1"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:phoenix_swagger, "~> 0.8"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
