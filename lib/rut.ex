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
  When given a string it will return an ElixirCLRut.Struct
  """
  @doc since: "1.0.0"
  @spec from(String.t()) :: struct()
  def from(input) when is_binary(input) do
    Rut.from(input)
  end

  @doc """
  Formats a string or Rut struct with the Rut format.

  ## Example
      iex> format("1")
      "1-9"
  """
  @doc since: "1.0.0"
  @spec format(struct() | String.t(), String.t()) :: String.t()
  def format(input, sep \\ ".")

  def format(input, sep) when is_binary(input) do
    Rut.from(input) |> Formatter.format(sep)
  end

  def format(%Rut{} = input, sep) do
    Formatter.format(input, sep)
  end

  @doc """
  Executes the rut validations.
  """
  @doc since: "1.0.0"
  @spec validate(struct() | String.t()) :: struct()
  def validate(input) when is_binary(input) do
    Rut.from(input) |> Validator.validate()
  end

  def validate(%Rut{} = input) do
    Validator.validate(input)
  end

  @doc """
  Performs a simple validation and returns the boolean result.
  true if is valid.
  """
  @doc since: "1.0.0"
  @spec valid?(struct() | String.t()) :: boolean()
  def valid?(input) do
    %_{valid?: valid?} = validate(input)
    valid?
  end
end
