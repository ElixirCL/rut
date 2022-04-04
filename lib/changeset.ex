defmodule ElixirCLRut.Changeset do
  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.Changeset

  defstruct [:from, errors = [], valid? = true]

  def from(%Rut{} = input) do
    %Changeset{
      from: input,
      errors: [],
      valid?: true
    }
  end

  def error(%Changeset{} = changeset, error) do
    # If we set an error is automatically invalid
    %Changeset{
      from: changeset.input,
      errors: [error | changeset.errors],
      valid?: false
    }
  end
end
