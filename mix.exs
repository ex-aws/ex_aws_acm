defmodule ExAwsAcm.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aws_acm,
      version: "0.0.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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

      { :ex_doc, ">= 0.0.0", only: :dev }
    ]
  end
end
