defmodule PhoenixWebComponents.MixProject do
  use Mix.Project

  @package_name "PHOENIX WEB COMPONENTS"

  @version "0.1.0"

  @source_url "https://gitlab.com/exadra37-elixir/packages/phoenix-web-components"

  @homepage_url "https://gitlab.com/exadra37-elixir/packages/phoenix-web-components/blob/master/README.md"

  @description """
  A package with web components for Phoenix projects, with Live View and without it.
  """

  def project() do
    [
      app: :phoenix_web_components,
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env == :prod,
      deps: deps(),

      # Hex
      package: package(),
      description: @description,
      source_url: @source_url,
      homepage_url: @homepage_url,

      # Docs
      name: @package_name,
      docs: [
        source_ref: "v#{@version}",
        source_url: @source_url,
        main: "readme",
        extras: ["README.md"]
      ],
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
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:phoenix_live_view, "~> 0.13.0"},
    ]
  end

  defp package() do
    [
      name: @package_name,

      maintainers: ["Exadra37"],

      # These are the default files included in the package
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["MIT"],
      links: %{"Gitlab" => @source_url}
    ]
  end
end
