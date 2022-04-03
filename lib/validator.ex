defmodule ElixirCLRut.Validator do
  @moduledoc """
  Provides simple validation helpers.
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Struct, as: Rut

  # Default Strict Regexes
  # @spec list(tuple(atom(), lambda(String.t()) :: true | false))
  # Each lambda function return true if the validation was triggered.
  # TODO: Add lambda functions for stricter validations
  @stricter_validations [
    {:all_zeroes_not_allowed, fn input -> false end},
    {:invalid_dot_order, fn input -> false end},
    {:minimum_length_of_6, fn input -> false end}
  ]

  @doc """
  Returns true if the checkdigit and lastchar are equal.

  ## Examples

      iex> loose(ElixirCLRut.Struct.from(""))
      false

      iex> loose(ElixirCLRut.Struct.from("1"))
      true

  """
  @spec loose(struct()) :: boolean()
  @doc since: "1.0.0"
  def loose(%Rut{} = input) do
    Enum.count(input.normalized) > 0 and input.checkdigit === input.lastchar
  end

  @doc """
  Validates the input against a series of provided lambda functions.
  """
  @spec strict(struct(), list(tuple(atom(), lambda()))) :: {:ok, struct()} | {:error, list()}
  @doc since: "1.0.0"
  def strict(%Rut{} = input, rules \\ []) do
    case loose(input) do
      true ->
        with matches <-
               Enum.map(
                 rules ++ @stricter_validations,
                 fn {message, rule} -> {message, rule(input)} end
               ) do
          found =
            Enum.filter(matches, fn {_, match} -> match === true end)
            |> Enum.map(fn {message, _} -> message end)

          case Enum.count(found) > 0 do
            true -> {:error, found}
            false -> {:ok, input}
          end
        end

      false ->
        {:error, [:invalid]}
    end
  end
end
