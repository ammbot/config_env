use Mix.Config

config :config_env,
  simple_string: {:system, "T_STRING"},
  simple_atom: {:system, "T_ATOM", :atom},
  simple_integer: {:system, "T_INTEGER", :integer},
  simple_float: {:system, "T_FLOAT", :float},
  simple_list: {:system, "T_LIST", :list}

config :config_nested_env,
  nest_1: [
    nest_1_1: %{
      string: {:system, "T_STRING", :string}
    },
    nest_1_2: [
      nest_1_3: %{
        atom: {:system, "T_ATOM", :atom}
      }
    ]
  ],
  nest_2: %{
    nest_2_1: %{
      integer: {:system, "T_INTEGER", :integer}
    },
    nest_2_2: [
      nest_2_3: %{
        float: {:system, "T_FLOAT", :float}
      }
    ]
  },
  list: {:system, "T_LIST", :list}

config :config_raise,
  missing_env: {:system, "T_MISSING"}
