defmodule ElixirCLRut do
  @moduledoc """
  A module that helps with validation and formatting
  of chilean [RUT/RUN identifiers](https://es.wikipedia.org/wiki/Rol_%C3%9Anico_Tributario).
  Made by the [Elixir Chile](https://elixircl.github.io) Community.
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.Formatter
  alias ElixirCLRut.CheckDigit
  alias ElixirCLRut.Validator

  @doc """
  Standarizes the `input` and returns a struct
  that contains the formatted values.

  This structure must be passed down to the validator function
  for checking if the _RUT_ is valid.

  ## Examples

      iex> from("2228250-6")
      %ElixirCLRut{
        from: "2228250-6",
        checkdigit: "6",
        formatted: "2.228.250-6",
        lastchar: "6",
        normalized: [2, 2, 2, 8, 2, 5, 0, 6]
      }

      iex> from("14193432")
      %ElixirCLRut{
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
    formatted = Formatter.format(normalized_no_checkdigit, checkdigit)

    # 5 - Return the structure ready for validation function
    %Rut{
      from: input,
      checkdigit: checkdigit,
      formatted: formatted,
      lastchar: lastchar,
      normalized: normalized
    }
  end

  @doc since: "1.0.0"
  @spec from(integer()) :: struct()
  def from(input) do
    from(to_string(input))
  end

  @doc """
  Tells if the _ElixirCLRut_ structure is valid.
  Beware that this will consider valid 1-9 and 0-0.
  Values normally considered fake ones and although valid,
  should be considered as not real values.

  Returns a tuple:
  - `{:ok, %ElixirCLRut{}}` if valid
  - `{:error, %ElixirCLRut{}}` if is not valid.

  ## Examples

      iex> valid?("2228250-6")
      {:ok, %ElixirCLRut{
        from: "2228250-6",
        checkdigit: "6",
        formatted: "2.228.250-6",
        lastchar: "6",
        normalized: [2, 2, 2, 8, 2, 5, 0, 6]
        }
      }

      iex> valid?("14193432")
      {:ok, %ElixirCLRut{
        from: "14193432",
        checkdigit: "5",
        formatted: "14.193.432-5",
        lastchar: "5",
        normalized: [1, 4, 1, 9, 3, 4, 3, 2]
        }
      }

      iex> valid?(14193432)
      {:ok, %ElixirCLRut{
        from: "14193432",
        checkdigit: "5",
        formatted: "14.193.432-5",
        lastchar: "5",
        normalized: [1, 4, 1, 9, 3, 4, 3, 2]
        }
      }

      iex> valid?(ElixirCLRut.from("14193432"))
      {:ok, %ElixirCLRut{
        from: "14193432",
        checkdigit: "5",
        formatted: "14.193.432-5",
        lastchar: "5",
        normalized: [1, 4, 1, 9, 3, 4, 3, 2]
        }
      }

  """
  @doc since: "1.0.0"
  @spec valid?(struct()) :: {:ok, struct()} | {:error, struct()}
  def valid?(%Rut{} = input) do
    # TODO: Move the logic inside validator
    case Enum.count(input.normalized) > 0 and
           Validator.valid?(input.checkdigit, input.lastchar) do
      true -> {:ok, input}
      false -> {:error, input}
    end
  end

  @doc since: "1.0.0"
  @spec valid?(String.t()) :: {:ok, struct()} | {:error, struct()}
  def valid?(input) when is_binary(input) do
    Rut.from(input) |> valid?
  end

  @doc since: "1.0.0"
  @spec valid?(integer()) :: {:ok, struct()} | {:error, struct()}
  def valid?(input) do
    to_string(input) |> valid?
  end

  @doc """
  Strict mode will also validate format and avoid known fake ruts likes 1-9
  and less than 6 length ruts.
  Some regex rules can be passed, if any of them match, it will consider
  the rut as invalid.
  strict false is the same as `valid?/1`.
  """
  @doc since: "1.0.0"
  @spec valid?(struct(), boolean(), list()) :: {:ok, struct()} | {:error, struct()}
  def valid?(%Rut{} = input, true, rules \\ []) do
    case valid?(input) do
      {:ok, input} -> Validator.strict(input, rules)
      error -> error
    end
  end

  @doc since: "1.0.0"
  @spec valid?(struct(), boolean(), list()) :: {:ok, struct()} | {:error, struct()}
  def valid?(%Rut{} = input, false, _) do
    valid?(input)
  end
end
