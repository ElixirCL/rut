defmodule ElixirCLRut.Changeset do
  alias ElixirCLRut.Struct, as: Rut
  alias ElixirCLRut.Changeset

  defstruct [:from, errors = [], valid? = false]

  def from(%Rut{} = input) do
    %Changeset{
      from: input,
      errors: [],
      valid?: false
    }
  end

  def error(%Changeset{} = changeset, error) do
    %Changeset{
      from: changeset.input,
      errors: [error | changeset.errors],
      valid?: changeset.valid?
    }
  end

  def validate(%Changeset{} = changeset) do
    %Changeset{
      from: changeset.input,
      errors: changeset.errors,
      valid?: changeset.errors == []
    }
  end
end
