# ConfigEnv

**Configuration loader from system environment**

## Why?
ensure that all system environment is set and convert to properly type.

## Installation

First, add ConfigEnv to your mix.exs dependencies:
```elixir
def deps do
  [
    {:config_env, "~> 0.1.0"}
  ]
end
```
## Usage

in `config.exs`
```elixir
config :your_app,
    string: {:system, "KEY"},
    atom: {:system, "ATOM"},
    integer: {:system, "INTEGER", :integer},
    float: {:system, "FLOAT", :float},
    list: {:system, "LIST", :list}
```
it can be nested
```elixir
config :your_app,
    nested: %{
        key: {:system, "KEY"},
        another_nested: [
            key: {:system, "ANOTHER_KEY"}
        ]
    }
```
put this code before start your app
```elixir
defmodule YourApp do
  use Application

  def start(_type, _args) do
    ConfigEnv.load_env([:yourapp, :otherapp, ...])
    # your code
  end

```
