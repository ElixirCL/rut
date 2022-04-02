defmodule ElixirCLRut.Validator do
  @moduledoc """
  Provides simple validation helpers.
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Struct, as: Rut

  @doc """
  Returns true if the checkdigit and lastchar are equal.

  ## Examples

      iex> valid?("6", "K")
      false

      iex> valid?("6", "6")
      true

  """
  @spec valid?(String.t(), String.t()) :: boolean()
  @doc since: "1.0.0"
  # TODO: Maybe validator params must adopt a protocol so a rut struct will be pass down
  def valid?(checkdigit, lastchar) do
    checkdigit === lastchar
  end

  #  TODO: Implement strict mode
  def strict(input, rules) do
    false
  end
end
