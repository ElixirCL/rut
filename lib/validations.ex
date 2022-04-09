defmodule ElixirCLRut.Validations do
  @moduledoc """
  Stores different validation functions
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Token

  @doc """
  Receives a Token struct and counts the normalized array,
  if it's empty it will add :value_is_empty to the errors list.
  """
  @doc since: "1.0.0"
  @spec not_empty(struct()) :: struct()
  def not_empty(%Token{} = token) do
    case token.from.normalized == [] do
      true -> Token.error(token, :value_is_empty)
      false -> token
    end
  end

  @doc """
  Receives a Token struct and validates checkdigit with lastdigit.
  If they are different it will add :wrong_checkdigit to the errors list.
  """
  @doc since: "1.0.0"
  @spec has_valid_checkdigit(struct()) :: struct()
  def has_valid_checkdigit(%Token{} = token) do
    case token.from.checkdigit != token.from.lastdigit do
      true -> Token.error(token, :wrong_checkdigit)
      false -> token
    end
  end

  # MARK: - Optional Validations

  @doc """
  Optional validation.
  Receives a Token struct and validates the normalized length
  is above or equal to the given length. Defaults to length 2.
  ## Example

      iex> (ElixirCLRut.validate("00-0") |> ElixirCLRut.Validations.length()).valid?
      true

      iex> (ElixirCLRut.validate("00-0") |> ElixirCLRut.Validations.length(3)).valid?
      false
  """
  @doc since: "1.0.0"
  @spec length(struct(), integer()) :: struct()
  def length(%Token{} = token, length \\ 2) do
    # fun fact: the person with the lowest possible rut is 10-8
    case Enum.count(token.from.normalized) < length do
      true -> Token.error(token, :invalid_length)
      false -> token
    end
  end


  @doc """
  Optional validation.
  Receives a Token struct and validates that all chars
  are not jut zeroes.

  ## Example

      iex> (ElixirCLRut.validate("00000000-0") |> not_all_zeroes()).valid?
      false

      iex> (ElixirCLRut.validate("00000001-9") |> not_all_zeroes()).valid?
      true
  """
  @doc since: "1.0.0"
  @spec not_all_zeroes(struct()) :: struct()
  def not_all_zeroes(%Token{} = token) do
    # get all the zeroes
    zeroes = Enum.filter(token.from.normalized, &(&1 == 0))

    # if we have all zeroes then is not valid
    case zeroes == token.from.normalized do
      true -> Token.error(token, :all_zeroes)
      false -> token
    end
  end
end
