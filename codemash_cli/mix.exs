defmodule CodemashCli.Mixfile do
  use Mix.Project

  def project do
    [
      app: :codemash_cli,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: CodemashCli.CLI],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:poison, "~> 2.0"}
    ]
  end
end
