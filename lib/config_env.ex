defmodule ConfigEnv do
  @moduledoc """
  """

  @doc """
  Hello world.

  ## Examples

      iex> ConfigEnv.hello
      :world

  """

  defexception message: "invalid config"

  def load_env(apps \\ []) do
    apps
    |> List.wrap
    |> update_all_envs
  end

  defp update_all_envs(apps) do
    apps
    |> Enum.map(&{&1, Application.get_all_env(&1)})
    |> Enum.map(&load_app_env/1)
    |> Enum.map(&put_env/1)
    raise_error()
  end

  defp load_app_env({app, envs}) when is_list(envs) do
    {app, Enum.map(envs, &do_load_env/1)}
  end

  defp do_load_env({name, vals}) when is_list(vals) do
    {name, Enum.map(vals, &do_load_env/1)}
  end
  defp do_load_env({name, val}) when is_map(val) do
    {name, Enum.map(val, &do_load_env/1) |> Enum.into(%{})}
  end
  defp do_load_env({name, {:system, key}}) do
    {name, do_load_env({:system, key, type: :string})}
  end
  defp do_load_env({name, {:system, key, opts}}) do
    {name, do_load_env({:system, key, opts})}
  end
  defp do_load_env({:system, key}) do
    do_load_env({:system, key, type: :string})
  end
  defp do_load_env({:system, key, opts}) do
    key
    |> System.get_env
    |> do_load_env({key, opts})
  end
  defp do_load_env({:system, key, _opts}) do
    System.get_env(key)
  end
  defp do_load_env(val) do
    val
  end

  defp do_load_env(nil, {key, opts}) do
    opts[:default] || put_error("ENV #{key} is missing")
  end
  defp do_load_env(val, {key, opts}) do
    convert_type(val, key, opts[:type])
  end

  defp convert_type(val, _key, nil) do
    val
  end
  defp convert_type(val, _key, :string) do
    val
  end
  defp convert_type(val, _key, :binary) do
    val
  end
  defp convert_type(val, _key, :atom) do
    String.to_atom(val)
  end
  defp convert_type(val, key, :integer) do
    case Integer.parse(val) do
      {integer, _} -> integer
      :error -> "ENV #{key} must be an integer"
    end
  end
  defp convert_type(val, key, :float) do
    case Float.parse(val) do
      {float, _} -> float
      :error -> "ENV #{key} must be a float"
    end
  end
  defp convert_type(val, _key, :list) do
    String.split(val, ",")
  end

  defp put_env({app, envs}) when is_list(envs) do
    Enum.map(envs, &put_env(app, &1))
  end

  defp put_env(app, {key, val}) do
    Application.put_env(app, key, val, persistent: true)
  end

  defp put_error(error) do
    errors = Process.get(:errors, [])
    Process.put(:errors, [error|errors])
  end

  defp raise_error do
    case Process.get(:errors, []) do
      [] -> :ok
      errors -> raise __MODULE__, message: inspect(Enum.dedup(errors))
    end
  end
end
