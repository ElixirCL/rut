defmodule ElixirCLRut.Struct do
  @moduledoc """
  A struct that holds information of the rut.
  """
  @moduledoc since: "1.0.0"

  defstruct [
    :from,
    :checkdigit,
    :lastdigit,
    :lastchar,
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
  @doc since: "1.0.1"
  @spec from(String.t(), boolean()) :: struct()
  def from(input, includes_checkdigit? \\ false) when is_binary(input) do
    dashed? = String.contains?(input, "-")

    # 1 - First we strip all non valid characters
    normalized = Formatter.normalize(input)

    # 2 - Determine if the last char is a check digit (handle 8+1 case)
    treat_last_as_checkdigit =
      dashed? or
        includes_checkdigit? or
        (length(normalized) == 9 and Enum.all?(Enum.slice(normalized, 0, 8), &is_integer/1))

    normalized_no_checkdigit =
      case treat_last_as_checkdigit do
        true ->
          CheckDigit.remove(normalized)

        false ->
          normalized
      end

    # 3 - Get the check digit
    checkdigit = CheckDigit.get(normalized_no_checkdigit)

    lastdigit =
      case treat_last_as_checkdigit do
        true ->
          to_string(List.last(normalized))

        false ->
          checkdigit
      end

    # 6 - Return the structure ready for validation functions
    %Rut{
      from: String.trim(input),
      checkdigit: checkdigit,
      lastdigit: lastdigit,
      normalized: normalized_no_checkdigit,
      normalized_with_checkdigit: normalized,
      dashed?: treat_last_as_checkdigit
    }
  end
end
