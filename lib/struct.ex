defmodule ElixirCLRut.Struct do
  @moduledoc """
  A struct that holds information of the rut.
  """
  @moduledoc since: "1.0.0"

  defstruct [:from, :checkdigit, :formatted, :normalized, :lastchar]
end
