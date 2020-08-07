defmodule ExAwsAcm.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aws_acm,
      version: "0.0.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyzer(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      { :ex_aws, "~> 2.0" },

      #
      # dev
      #

      { :ex_doc, ">= 0.0.0", only: :dev, runtime: false },

      { :dialyxir, "~> 1.0", only: :dev, runtime: false },

      #
      # dev,test
      #

      { :hackney, "~> 1.16", only: [:dev, :test] },

      { :jason, "~> 1.2", only: [:dev, :test] }
    ]
  end

  defp dialyzer do
    [
      plt_core_path: "_build/#{Mix.env()}"
    ]
  end

  defp package do
    [
      description: "ACM service package",
      files: ["lib", "config", "mix.exs", "README*"],
      licenses: ["MIT"],
      links: %{ GitHub: "https://github.com/malomohq/ex_aws_acm" },
      maintainers: ["Anthony Smith"]
    ]
  end
end
