defmodule ElixirCLRut.Token do
  @moduledoc """
  Token is a struct that is passed between validations.
  It enables an standarized way of passing down the information.
  """
  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.Token

  defstruct [:from, :errors, :valid?]

  @doc """
  Initializes a Token struct with valid? true as the default value.
  This token is passed down between validation functions.
  """
  @doc since: "1.0.0"
  @spec from(struct()) :: struct()
  def from(%Rut{} = input) do
    %Token{
      from: input,
      errors: [],
      valid?: true
    }
  end

  @doc """
  Modifies the given Token struct and set the error identifier
  and valid? to be false.
  """
  @doc since: "1.0.0"
  @spec error(struct(), atom()) :: struct()
  def error(%Token{} = token, error) when is_atom(error) do
    # If we set an error is automatically invalid
    %Token{
      from: token.from,
      errors: [error | token.errors],
      valid?: false
    }
  end
end
