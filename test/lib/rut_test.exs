defmodule ElixirCLRutTest do
  use ExUnit.Case, async: true
  doctest ElixirCLRut, import: true

  alias ElixirCLRut, as: Rut

  # MARK: - valid? tests
  describe "valid?" do
    test "that empty is not valid" do
      assert {:error, _} = Rut.valid?("")
    end

    test "that one letter is invalid" do
      assert {:error, _} = Rut.valid?("I")
    end

    test "that two letters are invalid" do
      assert {:error, _} = Rut.valid?("IN")
    end

    test "that three letters are invalid" do
      assert {:error, _} = Rut.valid?("INV")
    end

    test "that four letters are invalid" do
      assert {:error, _} = Rut.valid?("INVA")
    end

    test "that five letters are invalid" do
      assert {:error, _} = Rut.valid?("INVAL")
    end

    test "that six letters are invalid" do
      assert {:error, _} = Rut.valid?("INVALI")
    end

    test "that seven letters are invalid" do
      assert {:error, _} = Rut.valid?("INVALID")
    end

    test "valid format, invalid rut" do
      assert {:error, _} = Rut.valid?("4.898.089-1")
    end
  end
end
