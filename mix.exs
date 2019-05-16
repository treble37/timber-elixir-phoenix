defmodule Timber.Phoenix.MixProject do
  use Mix.Project

  @version "1.1.0"
  @source_url "https://github.com/timberio/timber-elixir-phoenix"
  @homepage_url "https://github.com/timberio/timber-elixir-phoenix"
  @project_description """
  Timber's Phoenix integration provides structured logging for applications
  built with the Phoenix Framework
  """

  # Package options for the Hex package listing
  #
  # See `mix help hex.publish` for more information about
  # the options used in this section
  defp package() do
    [
      name: :timber_phoenix,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Ben Johnson", "David Antaramian"],
      licenses: ["ISC"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end

  def project do
    [
      app: :timber_phoenix,
      name: "Timber for Phoenix",
      version: @version,
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: @project_description,
      source_url: @source_url,
      homepage_url: @homepage_url,
      package: package(),
      deps: deps(),
      docs: docs(),
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: preferred_cli_env(),
      test_coverage: test_coverage(),
      dialyzer: dialyzer()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Timber.Phoenix.Application, []}
    ]
  end

  # Compiler paths switched on the Mix environment
  #
  # The `lib` directory is always compiled
  #
  # In the :test environment, `test/support` will also be compiled
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Preferred CLI Environment details
  #
  # Defines the preferred environment for Mix tasks
  defp preferred_cli_env() do
    [
      coveralls: :test,
      "coveralls.details": :test,
      "coveralls.html": :test,
      "coveralls.travis": :test
    ]
  end

  # Test Coverage configuration
  #
  # Sets the test converage tool to be Coveralls
  defp test_coverage() do
    [
      tool: ExCoveralls
    ]
  end

  # Dialyzer configuration
  defp dialyzer() do
    [
      plt_add_deps: true
    ]
  end

  # Documentation options for ExDoc
  defp docs() do
    [
      source_ref: "v#{@version}",
      main: "readme",
      logo: "doc_assets/logo.png",
      extras: [
        "README.md": [title: "README"],
        "LICENSE.md": [title: "LICENSE"]
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.2"},
      {:plug, "~> 1.1"},
      {:timber,
       git: "https://github.com/treble37/timber-elixir.git",
       branch: "handle-hackney-exit"},

      #
      # Tooling
      #

      {:credo, "~> 1.0", only: [:dev, :test]},
      {:dialyxir, "~> 0.5", only: [:dev, :test]},
      {:earmark, "~> 1.2", only: [:dev]},
      {:ex_doc, "~> 0.19.0", only: [:dev]},
      {:excoveralls, "~> 0.10", only: [:dev, :test]}
    ]
  end
end
