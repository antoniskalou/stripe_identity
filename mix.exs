defmodule StripeIdentity.MixProject do
  use Mix.Project

  def project do
    [
      app: :stripe_identity,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.10"},
      {:plug_cowboy, "~> 2.0", only: :dev},
      {:jason, "~> 1.2"},
      {:hackney, "~> 1.16"},
    ]
  end
end
