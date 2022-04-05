defmodule ElixirCLRut.Validator do
  @moduledoc """
  Provides simple validation helpers.
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.Validations
  alias ElixirCLRut.Token

  @doc """
  Validates the ElixirCLRut.Struct with some default
  validations.
  """
  @doc since: "1.0.0"
  def validate(%Rut{} = input) do
    Token.from(input)
    |> Validations.not_empty()
    |> Validations.has_valid_checkdigit()
  end
end
