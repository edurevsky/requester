defmodule Requester.MixProject do
  use Mix.Project

  def project do
    [
      app: :requester,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      # applications: [],
      extra_applications: [:logger, :httpoison, :quantum],
      mod: {Requester.Application, []},
    ]
  end

  defp deps do
    [
      {:quantum, "~> 3.4"},
      {:httpoison, "~> 1.8"}
    ]
  end
end
