defmodule ConfigEnvTest do
  use ExUnit.Case

  setup_all do
    %{
      "T_STRING" => "string",
      "T_ATOM" => "atom",
      "T_INTEGER" => "100",
      "T_FLOAT" => "1.234",
      "T_LIST" => "a,b,c"
    }
    |> System.put_env
  end

  test "load_env" do
    ConfigEnv.load_env(:config_env)
    env = Application.get_all_env(:config_env)
    assert env[:simple_string] == "string"
    assert env[:simple_atom] == :atom
    assert env[:simple_integer] == 100
    assert env[:simple_float] == 1.234
    assert env[:simple_list] == ["a", "b", "c"]
  end

  test "load_env can be nested" do
    ConfigEnv.load_env(:config_nested_env)
    env = Application.get_all_env(:config_nested_env)
    assert env[:nest_1] == [
      nest_1_1: %{
        string: "string"
      },
      nest_1_2: [
        nest_1_3: %{
          atom: :atom
          }
        ]
    ]
    assert env[:nest_2] == %{
      nest_2_1: %{
        integer: 100
      },
      nest_2_2: [
        nest_2_3: %{
          float: 1.234
        }
      ]
    }
    assert env[:list] == ["a", "b", "c"]
  end

  test "missing env will be raised" do
    assert_raise ConfigEnv, fn -> ConfigEnv.load_env(:config_raise) end
  end

  test "can be loaded multiple apps" do
    assert ConfigEnv.load_env([:config_env, :config_nested_env]) == :ok
  end
end
