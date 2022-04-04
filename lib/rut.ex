defmodule ElixirCLRut do
  @moduledoc """
  A module that helps with validation and formatting
  of chilean [RUT/RUN identifiers](https://es.wikipedia.org/wiki/Rol_%C3%9Anico_Tributario).
  Made by the [Elixir Chile](https://elixircl.github.io) Community.
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.Validator

  @doc since: "1.0.0"
  @spec from(integer() | String.t()) :: struct()
  def from(input) do
    Rut.from(Kernel.to_string(input))
  end

  # MARK: - Loose Validations

  @doc """
  Tells if the _ElixirCLRut_ structure is valid.
  Beware that this will consider valid 1-9 and 0-0.
  Values normally considered fake ones and although valid,
  should be considered as not real values.

  Returns a tuple:
  - `{:ok, %ElixirCLRut.Struct{}}` if valid
  - `{:error, %ElixirCLRut.Struct{}}` if is not valid.

  ## Examples

      iex> valid?("2228250-6")
      {:ok, %ElixirCLRut.Struct{
        from: "2228250-6",
        checkdigit: "6",
        formatted: "2.228.250-6",
        lastchar: "6",
        normalized: [2, 2, 2, 8, 2, 5, 0, 6]
        }
      }

      iex> valid?("14193432")
      {:ok, %ElixirCLRut.Struct{
        from: "14193432",
        checkdigit: "5",
        formatted: "14.193.432-5",
        lastchar: "5",
        normalized: [1, 4, 1, 9, 3, 4, 3, 2]
        }
      }

      iex> valid?(14193432)
      {:ok, %ElixirCLRut.Struct{
        from: "14193432",
        checkdigit: "5",
        formatted: "14.193.432-5",
        lastchar: "5",
        normalized: [1, 4, 1, 9, 3, 4, 3, 2]
        }
      }

      iex> valid?(ElixirCLRut.from("14193432"))
      {:ok, %ElixirCLRut.Struct{
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
    case Validator.loose(input) do
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
    Kernel.to_string(input) |> valid?
  end

  # MARK: - Stricter Validations

  @doc """
  Strict mode will also validate format and avoid known fake ruts likes 1-9
  and less than 6 length ruts.
  Some regex rules can be passed, if any of them match, it will consider
  the rut as invalid.
  strict false is the same as `valid?/1`.
  """
  @doc since: "1.0.0"
  @spec valid?(struct() | String.t(), boolean(), list(String.t())) ::
          {:ok, struct()} | {:error, list()}
  def valid?(input, strict \\ true, rules \\ [])

  def valid?(%Rut{} = input, true, rules) do
    Validator.strict(input, rules)
  end

  def valid?(input, true, rules) when is_binary(input) do
    valid?(Rut.from(input), true, rules)
  end

  def valid?(input, false, _) do
    valid?(input)
  end
end
