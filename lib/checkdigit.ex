defmodule ElixirCLRut.CheckDigit do
  @moduledoc """
    The Check Digit allows to verify if a RUT is correctly formed.
  """
  @moduledoc since: "1.0.0"

  @doc """
  Removes the last item from the list.
  Used for cleaning up the check digit before the algorithm.

  ## Examples

      iex> remove([2,2,2,8,2,5,0,6])
      [2,2,2,8,2,5,0]

  """
  @doc since: "1.0.0"
  @spec remove(list()) :: list()
  def remove(normalized) when is_list(normalized) do
    List.delete_at(normalized, length(normalized) - 1)
  end

  @doc """
    Calculates the check digit following the modulo 11 algorithm.
    Receives a list of numbers.

  ## Examples

      iex> get([2,2,2,8,2,5,0])
      "6"
  """
  @doc since: "1.0.0"
  @spec get(list()) :: String.t()
  def get(normalized) when is_list(normalized) do
    # from https://discord.com/channels/713354039903125594/713354039903125597/958121736379961384
    mod =
      normalized
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn {digit, index} -> digit * (rem(index, 6) + 2) end)
      |> Enum.sum()
      |> rem(11)

    case 11 - mod do
      10 -> "K"
      11 -> "0"
      num -> Integer.to_string(num)
    end
  end
end
