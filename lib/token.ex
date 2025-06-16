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

  ## Example

      iex> from(ElixirCLRut.from("1-9"))
      %ElixirCLRut.Token{errors: [], from: %ElixirCLRut.Struct{checkdigit: "9", dashed?: true, from: "1-9", includes_checkdigit?: true, lastdigit: "9", normalized: [1], normalized_with_checkdigit: [1, 9]}, valid?: true}
      iex> from(ElixirCLRut.from("20.961.605-K"))
      %ElixirCLRut.Token{errors: [], from: %ElixirCLRut.Struct{checkdigit: "K", dashed?: true, from: "20.961.605-K", includes_checkdigit?: true, lastdigit: "K", normalized: [2,0,9,6,1,6,0,5], normalized_with_checkdigit: [2,0,9,6,1,6,0,5,"K"]}, valid?: true}
      iex> from(ElixirCLRut.from("20.961605", false))
      %ElixirCLRut.Token{errors: [], from: %ElixirCLRut.Struct{checkdigit: "K", dashed?: false, from: "20.961605", includes_checkdigit?: false, lastdigit: "K", normalized: [2,0,9,6,1,6,0,5], normalized_with_checkdigit: [2,0,9,6,1,6,0,5,"K"]}, valid?: true}
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
