defmodule ElixirCLRut.Validations do

  alias ElixirCLRut.Changeset

  def not_empty(%Changeset{} = changeset) do
    case changeset.from.normalized == [] do
      true -> Changeset.error(changeset, :value_is_empty)
      false -> changeset
    end
  end

  def has_valid_checkdigit(%Changeset{} = changeset) do
    case changeset.from.checkdigit == changeset.from.lastdigit do
      true -> Changeset.error(changeset, :wrong_checkdigit)
      false -> changeset
    end
  end
end
