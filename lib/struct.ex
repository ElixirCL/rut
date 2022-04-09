defmodule ElixirCLRut.Struct do
  @moduledoc """
  A struct that holds information of the rut.
  """
  @moduledoc since: "1.0.0"

  defstruct [
    :from,
    :checkdigit,
    :lastdigit,
    :normalized,
    :normalized_with_checkdigit,
    :dashed?
  ]

  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.CheckDigit
  alias ElixirCLRut.Formatter

  @doc """
  Standarizes the `input` and returns a struct
  that contains the formatted values.

  This structure must be passed down to the validator function
  for checking if the _RUT_ is valid.
  """
  @doc since: "1.0.0"
  @spec from(String.t()) :: struct()
  def from(input) when is_binary(input) do
    contains_dash = String.contains?(input, "-")

    # 1 - First we strip all non valid characters
    normalized = Formatter.normalize(input)

    # 2 - If the string contains a dash - we remove the last char
    normalized_no_checkdigit =
      case contains_dash do
        true ->
          CheckDigit.remove(normalized)

        false ->
          normalized
      end

    # 3 - Get the check digit
    checkdigit = CheckDigit.get(normalized_no_checkdigit)

    lastchar =
      case contains_dash do
        true ->
          to_string(List.last(normalized))

        false ->
          checkdigit
      end

    # 6 - Return the structure ready for validation functions
    %Rut{
      from: String.trim(input),
      checkdigit: checkdigit,
      lastdigit: lastchar,
      normalized: normalized_no_checkdigit,
      normalized_with_checkdigit: normalized,
      dashed?: contains_dash
    }
  end
end
