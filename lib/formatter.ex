defmodule ElixirCLRut.Formatter do
  @moduledoc """
    Cleans and give format to RUT strings.
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Struct, as: Rut

  @doc """
  Gives format to a normalized RUT.

  ## Examples
      iex> format(ElixirCLRut.from("20961605-K"))
      "20.961.605-K"
  """
  @doc since: "1.0.0"
  @spec format(struct(), String.t()) :: String.t()
  def format(%Rut{} = input, sep \\ ".") do
    formatted =
      input.normalized
      |> Enum.reverse()
      |> Enum.chunk_every(3)
      |> Enum.map(&(&1 |> Enum.reverse() |> Enum.join()))
      |> Enum.reverse()
      |> Enum.join(sep)

    "#{formatted}-#{input.checkdigit}"
  end

  @doc """
  Removes all chars (except for numbers and letter K) from the RUT.

  ## Examples

      iex> clean("2228250-6")
      "22282506"

      iex> clean("14.193.432-5")
      "141934325"

  """
  @doc since: "1.0.0"
  @spec clean(String.t()) :: String.t()
  def clean(input) do
    String.replace(
      input,
      ~r/[^0-9^k^K]/,
      ""
    )
  end

  @doc """
  Transforms a RUT string to a list of numbers.
  Converts lowercase to uppercase.

  ## Examples

      iex> normalize("2228250-6")
      [2, 2, 2, 8, 2, 5, 0, 6]

      iex> normalize("14.193.432-5")
      [1, 4, 1, 9, 3, 4, 3, 2, 5]

  """
  @doc since: "1.0.0"
  @spec normalize(String.t()) :: String.t()
  def normalize(input) do
    clean(input)
    |> String.upcase()
    |> String.split("", trim: true)
    |> Enum.map(fn item ->
      case Integer.parse(item) do
        {number, _} -> number
        _ -> "K"
      end
    end)
  end
end
