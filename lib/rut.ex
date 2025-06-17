defmodule ElixirCLRut do
  @moduledoc """
  A module that helps with validation and formatting
  of chilean [RUT/RUN identifiers](https://es.wikipedia.org/wiki/Rol_%C3%9Anico_Tributario).
  Made by the [Elixir Chile](https://elixircl.github.io) Community.
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.Validator
  alias ElixirCLRut.Formatter

  @doc """
  Cleans a RUT
  - since: "1.0.2"
  """
  @spec clean(String.t()) :: String.t()
  def clean(input) when is_binary(input) do
    Formatter.clean(input)
  end

  @doc """
  Gets the check digit of a rut
  - since: "1.0.3"
  """
  @spec checkdigit(String.t()) :: String.t()
  def checkdigit(input, includes_checkdigit \\ true) when is_binary(input) do
    ElixirCLRut.from(input, includes_checkdigit).checkdigit
  end

  @doc """
  Alternate name for checkdigit/2
  - since: "1.0.3"
  """
  def dv(input, includes_checkdigit \\ true) do
    checkdigit(input, includes_checkdigit)
  end

  @doc """
  When given a string it will return an ElixirCLRut.Struct

  ## Example

      iex> from("1-9")
      %ElixirCLRut.Struct{checkdigit: "9", dashed?: true, from: "1-9", includes_checkdigit?: true, lastdigit: "9", normalized: [1], normalized_with_checkdigit: [1, 9]}

      iex> from("141231553")
      %ElixirCLRut.Struct{checkdigit: "3", dashed?: false, from: "141231553", includes_checkdigit?: true, lastdigit: "3", normalized: [1, 4, 1, 2, 3, 1, 5, 5], normalized_with_checkdigit: [1, 4, 1, 2, 3, 1, 5, 5, 3]}

      iex> from("14123155", false)
      %ElixirCLRut.Struct{checkdigit: "3", dashed?: false, from: "14123155", includes_checkdigit?: false, lastdigit: "3", normalized: [1, 4, 1, 2, 3, 1, 5, 5], normalized_with_checkdigit: [1, 4, 1, 2, 3, 1, 5, 5, 3]}

      iex> from("20.961.605-K")
      %ElixirCLRut.Struct{checkdigit: "K", dashed?: true, from: "20.961.605-K", includes_checkdigit?: true, lastdigit: "K", normalized: [2, 0, 9, 6, 1, 6, 0, 5], normalized_with_checkdigit: [2, 0, 9, 6, 1, 6, 0, 5, "K"]}

  """
  @doc since: "1.0.0"
  @spec from(String.t()) :: struct()
  def from(input) when is_binary(input) do
    Rut.from(input, true)
  end

  @doc since: "1.0.2"
  @spec from(String.t(), boolean()) :: struct()
  def from(input, includes_check_digit) when is_binary(input) do
    Rut.from(input, includes_check_digit)
  end

  @doc """
  Formats a string or Rut struct with the Rut format.

  ## Examples

      iex> format("1", false)
      "1-9"

      iex> format("K", false)
      "K"

      iex> format("63009482", true)
      "6.300.948-2"

      iex> format("6300948-2", dashed?: true, separator: ",")
      "6,300,948-2"

      iex> format("141231553")
      "14.123.155-3"
  """
  @doc since: "1.0.1"
  @spec format(struct() | String.t(), String.t() | boolean() | keyword()) :: String.t()
  def format(input, options \\ [dashed?: true, separator: "."])

  def format(input, dashed?) when is_binary(input) and is_boolean(dashed?) do
    Rut.from(input, dashed?)
    |> Formatter.format()
  end

  def format(input, sep) when is_binary(input) and is_binary(sep) do
    Rut.from(input, true)
    |> Formatter.format(sep)
  end

  def format(input, options) when is_binary(input) and is_list(options) do
    Rut.from(input, opts(options)[:dashed?])
    |> Formatter.format(opts(options))
  end

  def format(%Rut{} = input, options) when is_list(options) do
    Formatter.format(input, opts(options))
  end

  defp opts(options) when is_list(options) do
    [
      dashed?: Keyword.get(options, :dashed?, true),
      separator: Keyword.get(options, :separator, ".")
    ]
  end

  defp opts(dashed?) do
    [
      dashed?: dashed?,
      separator: "."
    ]
  end

  @doc """
  Executes the rut validations.

  ## Examples

      iex> valid("1-9").valid?
      true

      iex> valid("1").valid?
      false

      iex> valid("6300948-1").valid?
      false
  """
  @doc since: "1.0.2"
  @spec valid(struct() | String.t(), boolean()) :: struct()
  def valid(input, includes_checkdigit \\ true)

  def valid(input, includes_checkdigit) when is_binary(input) do
    Rut.from(input, includes_checkdigit) |> Validator.validate()
  end

  def valid(input, _) do
    Validator.validate(input)
  end

  @doc """
  Performs a simple validation and returns the boolean result.
  true if is valid.

  ## Examples

      iex> validate("1-9")
      true

      iex> validate("1k-9")
      false

      iex> validate("6300948-1")
      false

      iex> validate(from("6300948-1"))
      false
  """
  @doc since: "1.0.2"
  @spec validate(struct() | String.t(), boolean()) :: boolean()
  def validate(input, includes_checkdigit \\ true) do
    %_{valid?: valid?} = valid(input, includes_checkdigit)
    valid?
  end

  @doc since: "1.0.0"
  def valid?(input, includes_checkdigit \\ true) do
    validate(input, includes_checkdigit)
  end
end
