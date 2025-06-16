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
    :includes_checkdigit?,
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

    # 2 - If the string includes checkdigit we remove the last char
    normalized_no_checkdigit =
      case dashed? or includes_checkdigit? do
        true ->
          CheckDigit.remove(normalized)

        false ->
          normalized
      end

    # 3 - Get the check digit
    checkdigit = CheckDigit.get(normalized_no_checkdigit)

    lastdigit =
      case dashed? or includes_checkdigit? do
        true ->
          List.last(normalized)

        false ->
          checkdigit
      end
      |> to_string()
      |> String.upcase()

    # 6 - Return the structure ready for validation functions
    %Rut{
      from: String.trim(input),
      checkdigit: checkdigit,
      lastdigit: lastdigit,
      normalized: normalized_no_checkdigit,
      includes_checkdigit?: includes_checkdigit?,
      normalized_with_checkdigit:
        case dashed? or includes_checkdigit? do
          true ->
            normalized

          false ->
            normalized ++
              [
                case lastdigit == "K" do
                  true -> lastdigit
                  false -> String.to_integer(lastdigit)
                end
              ]
        end,
      dashed?: dashed?
    }
  end
end
