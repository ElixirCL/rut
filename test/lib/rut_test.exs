defmodule ElixirCLRutTest do
  use ExUnit.Case, async: true
  doctest ElixirCLRut, import: true

  alias ElixirCLRut, as: Rut

  # MARK: - valid? tests
  describe "valid?" do
    test "that empty is not valid" do
      %_{valid?: valid?} = Rut.validate("")
      assert valid? == false
    end

    test "that one letter is invalid" do
      %_{valid?: valid?} = Rut.validate("I")
      assert valid? == false
    end

    test "that two letters are invalid" do
      %_{valid?: valid?} = Rut.validate("IN")
      assert valid? == false
    end

    test "that three letters are invalid" do
      %_{valid?: valid?} = Rut.validate("INV")
      assert valid? == false
    end

    test "that four letters are invalid" do
      %_{valid?: valid?} = Rut.validate("INVA")
      assert valid? == false
    end

    test "that five letters are invalid" do
      %_{valid?: valid?} = Rut.validate("INVAL")
      assert valid? == false
    end

    test "that six letters are invalid" do
      %_{valid?: valid?} = Rut.validate("INVALI")
      assert valid? == false
    end

    test "that seven letters are invalid" do
      %_{valid?: valid?} = Rut.validate("INVALID")
      assert valid? == false
    end

    test "valid format, invalid rut" do
      %_{valid?: valid?} = Rut.validate("4.898.089-1")
      assert valid? == false
    end
  end
end
