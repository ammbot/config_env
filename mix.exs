defmodule ConfigEnv.Mixfile do
  use Mix.Project

  def project do
    [
      app: :config_env,
      version: "0.2.0",
      elixir: "~> 1.5",
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    """
    Configuration loader from system environment
    """
  end

  defp package do
    [maintainers: ["ammbot"],
     licenses: ["Apache 2.0"],
     links: %{"Github" => "https://github.com/ammbot/config_env"},
     files: ~w(mix.exs README.md lib)]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
