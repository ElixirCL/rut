defmodule ElixirCLRut.Struct do
  @moduledoc """
  A struct that holds information of the rut.
  """
  @moduledoc since: "1.0.0"

  defstruct [
    :from,
    :checkdigit,
    #:formatted,
    :normalized,
    :lastchar
  ]

  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.Formatter
  alias ElixirCLRut.CheckDigit

  @doc """
  Standarizes the `input` and returns a struct
  that contains the formatted values.

  This structure must be passed down to the validator function
  for checking if the _RUT_ is valid.

  ## Examples

      iex> from("2228250-6")
      %ElixirCLRut.Struct{
        from: "2228250-6",
        checkdigit: "6",
        formatted: "2.228.250-6",
        lastchar: "6",
        normalized: [2, 2, 2, 8, 2, 5, 0, 6]
      }

      iex> from("14193432")
      %ElixirCLRut.Struct{
        from: "14193432",
        checkdigit: "5",
        formatted: "14.193.432-5",
        lastchar: "5",
        normalized: [1, 4, 1, 9, 3, 4, 3, 2]
      }

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

    # 4 - Format
    #formatted = Formatter.format(normalized_no_checkdigit, checkdigit)

    # 5 - Return the structure ready for validation function
    %Rut{
      from: String.trim(input),
      checkdigit: checkdigit,
      #formatted: formatted,
      lastchar: lastchar,
      normalized: normalized
    }
  end
end
