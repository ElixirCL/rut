defmodule ElixirCLRut.MixProject do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :elixircl_rut,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
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
      name: "ElixirCLRUT",
      source_url: "https://github.com/ElixirCL/rut",
      homepage_url: "https://hexdocs.pm/elixircl_rut",
      docs: [
        # The main page in the docs
        main: "EXAMPLES",
        # logo: "https://raw.githubusercontent.com/ElixirCL/elixircl.github.io/main/img/logo.png",
        extras: ["README.md", "LICENSE.md", "CHANGELOG.md", "EXAMPLES.livemd", "AUTHORS.md"],
        authors: ["AUTHORS.md"],
        output: "docs"
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

  defp description() do
    "A chilean RUT/RUN validator and formatter"
  end

  defp package() do
    [
      name: "elixircl_rut",
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["ElixirCL"],
      licenses: ["MPL-2.0"],
      links: %{"GitHub" => "https://github.com/ElixirCL/rut"},
      # Remove below comment to make the package private
      # organization: "elixircl_"
    ]
  end
end
