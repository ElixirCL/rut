defmodule ElixirCLRut.Validator do
  @moduledoc """
  Provides simple validation helpers.
  """
  @moduledoc since: "1.0.0"

  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.Validations
  alias ElixirCLRut.Changeset

  # Default Strict Regexes
  # @spec list(tuple(atom(), lambda(String.t()) :: true | false))
  # Each lambda function return true if the validation was triggered.
  # TODO: Add lambda functions for stricter validations
  # @stricter_validations [
  #   {:all_zeroes_not_allowed, fn input -> false end},
  #   {:invalid_dot_order, fn input -> false end},
  #   {:minimum_length_of_6, fn input -> false end}
  # ]

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
  # @spec strict(struct(), list(tuple(atom(), lambda()))) :: {:ok, struct()} | {:error, list()}
  @doc since: "1.0.0"

  def strict(%Rut{} = input, rules \\ []) do
    case loose(input) do
      true ->
        # IO.inspect(rules ++ @stricter_validations, label: "rules")
        matches =
          Enum.map(
            [
              {:not_zero, ElixirCLRut.Validations.not_zero/1}
            ]  ++ rules,
            #rules,
            #&({&0, &1.(input)})
            fn {message, rule} -> {message, rule.(input)} end
          )
        errors =
          Enum.filter(matches, fn {_, match} -> match === true end)
          |> Enum.map(fn {message, _} -> message end)

        case errors == [] do
          true -> {:ok, input}
          false -> {:error, errors}
        end

      false ->
        {:error, [:invalid]}
    end
  end

  def validate(%Rut{} = input) do
    Changeset.from(input)
    |> Validations.not_empty
    |> Validations.has_valid_checkdigit
  end
end
