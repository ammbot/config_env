use Mix.Config

config :config_env,
  simple_string: {:system, "T_STRING"},
  simple_atom: {:system, "T_ATOM", type: :atom},
  simple_integer: {:system, "T_INTEGER", type: :integer},
  simple_float: {:system, "T_FLOAT", type: :float},
  simple_list: {:system, "T_LIST", type: :list}

config :config_nested_env,
  nest_1: [
    nest_1_1: %{
      string: {:system, "T_STRING", type: :string}
    },
    nest_1_2: [
      nest_1_3: %{
        atom: {:system, "T_ATOM", type: :atom}
      }
    ]
  ],
  nest_2: %{
    nest_2_1: %{
      integer: {:system, "T_INTEGER", type: :integer}
    },
    nest_2_2: [
      nest_2_3: %{
        float: {:system, "T_FLOAT", type: :float}
      }
    ]
  },
  list: {:system, "T_LIST", type: :list}

config :config_default_env,
  missing: {:system, "T_MISSING", default: "default value"}

config :config_raise,
  missing_env: {:system, "T_MISSING"}
