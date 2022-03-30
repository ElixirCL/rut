defmodule ElixirCLRut.MixProject do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :elixircl_rut,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ] ++ docs()
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp docs do
    [
      # Docs
      name: "ElixirCL RUT",
      source_url: "https://github.com/ElixirCL/rut",
      homepage_url: "https://hexdocs.pm/elixircl_rut",
      docs: [
        # The main page in the docs
        main: "ElixirCLRut",
        # logo: "https://raw.githubusercontent.com/ElixirCL/elixircl.github.io/main/img/logo.png",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
