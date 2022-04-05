defmodule ElixirCLRut.Validations do
  @moduledoc """
  Stores different validation functions
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Token

  @doc """
  Receives a Token struct and counts the normalized array,
  if it's empty it will add :value_is_empty to the errors list.
  """
  @doc since: "1.0.0"
  @spec not_empty(struct()) :: struct()
  def not_empty(%Token{} = token) do
    case token.from.normalized == [] do
      true -> Token.error(token, :value_is_empty)
      false -> token
    end
  end

  @doc """
  Receives a Token struct and validates checkdigit with lastdigit.
  If they are different it will add :wrong_checkdigit to the errors list.
  """
  @doc since: "1.0.0"
  @spec has_valid_checkdigit(struct()) :: struct()
  def has_valid_checkdigit(%Token{} = token) do
    case token.from.checkdigit != token.from.lastdigit do
      true -> Token.error(token, :wrong_checkdigit)
      false -> token
    end
  end
end
