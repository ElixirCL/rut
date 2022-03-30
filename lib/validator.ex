defmodule ElixirCLRut.Validator do
  @moduledoc """
  Provides simple validation helpers.
  """
  @moduledoc since: "1.0.0"

  @doc """
  Returns true if the checkdigit and lastchar are equal.

  ## Examples

      iex> is_valid?("6", "K")
      false

      iex> is_valid?("6", "6")
      true

  """
  @spec is_valid?(String.t(), String.t()) :: boolean()
  @doc since: "1.0.0"
  def is_valid?(checkdigit, lastchar) do
    checkdigit === lastchar
  end
end
