defmodule ElixirCLRut.Validations do
  @moduledoc """
  Stores different validation functions
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Token

  @doc """
  Receives a Token struct and counts the normalized array,
  if it's empty it will add :value_is_empty to the errors list.
  iex> not_empty(ElixirCLRut.Token.from(ElixirCLRut.from("abc")))
  %ElixirCLRut.Token{errors: [:value_is_empty], from: %ElixirCLRut.Struct{from: "abc", checkdigit: "0", lastdigit: "", lastchar: nil, normalized: [], normalized_with_checkdigit: [], includes_checkdigit?: true, dashed?: false}, valid?: false}
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
  iex> has_valid_checkdigit(ElixirCLRut.Token.from(ElixirCLRut.from("20.961605-C")))
  %ElixirCLRut.Token{errors: [:wrong_checkdigit], valid?: false, from: %ElixirCLRut.Struct{from: "20.961605-C", checkdigit: "0", lastdigit: "5", lastchar: nil, normalized: [2, 0, 9, 6, 1, 6, 0], normalized_with_checkdigit: [2, 0, 9, 6, 1, 6, 0, 5], includes_checkdigit?: true, dashed?: true}}
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

  @doc """
  Optional validation.
  Validates Rut is above or equal to 1 million. To avoid probably dead people.
  - since: "1.0.2"

  ## Example

    iex> (ElixirCLRut.validate("1.000.000-9") |> equal_or_above_1M()).valid?
    true

  """
  @spec equal_or_above_1M(struct()) :: struct()
  def equal_or_above_1M(%Token{} = token) do
    check = String.to_integer(Enum.join(token.from.normalized)) >= 1_000_000

    # if we have all zeroes then is not valid
    case check do
      true -> token
      false -> Token.error(token, :under_1M)
    end
  end

  @doc """
  Optional validation.
  Validates Rut is below or equal to 100 million. To avoid probably non existing people.
  - since: "1.0.2"

  ## Example

    iex> (ElixirCLRut.validate("100.000.000-7") |> equal_or_below_100M()).valid?
    true

  """
  @spec equal_or_below_100M(struct()) :: struct()
  def equal_or_below_100M(%Token{} = token) do
    check = String.to_integer(Enum.join(token.from.normalized)) <= 100_000_000

    # if we have all zeroes then is not valid
    case check do
      true -> token
      false -> Token.error(token, :over_100M)
    end
  end
end
