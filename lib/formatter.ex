defmodule ElixirCLRut.Formatter do
  @moduledoc """
    Cleans and give format to RUT strings.
  """
  @moduledoc since: "1.0.0"

  @doc """
  Gives format to a normalized RUT.

  ## Examples

      iex> format([2,2,2,8,2,5,0],"6")
      "2.228.250-6"

      iex> format([1, 4, 1, 9, 3, 4, 3, 2], "5")
      "14.193.432-5"

      iex> format([1, 4, 1, 9, 3, 4, 3, 2], "5", ",")
      "14,193,432-5"

  """
  @doc since: "1.0.0"
  @spec format(list(), String.t(), String.t()) :: String.t()
  def format(normalized, checkdigit, sep \\ ".") when is_list(normalized) do
    formatted = normalized
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.map(& &1 |> Enum.reverse() |> Enum.join())
    |> Enum.reverse()
    |> Enum.join(sep)

    "#{formatted}-#{checkdigit}"
  end

  @doc """
  Removes all chars (except for numbers and letter K) from the RUT.
  Converts lowercase to uppercase.

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
    |> String.upcase()
  end

  @doc """
  Transforms a RUT string to a list of numbers.

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
    |> String.split("", trim: true)
    |> Enum.map(fn item ->
      case Integer.parse(item) do
        {number, _} -> number
        _ -> "K"
      end
    end)
  end
end
