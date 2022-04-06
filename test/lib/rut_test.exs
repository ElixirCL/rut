defmodule ElixirCLRutTest do
  use ExUnit.Case, async: true
  doctest ElixirCLRut, import: true

  alias ElixirCLRut, as: Rut

  # MARK: - valid? tests
  describe "valid?" do
    test "that empty is not valid" do
      assert Rut.valid?("") == false
    end

    test "that one length is valid" do
      assert Rut.valid?("1") == true
    end

    test "that a wrong rut is not valid" do
      assert Rut.valid?("4.898.089-1") == false
    end
  end

  # MARK: - validate tests
  describe "validate" do
    # MARK: validate = false

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

    test "that a wrong rut is not valid" do
      %_{valid?: valid?} = Rut.validate("4.898.089-1")
      assert valid? == false
    end

    # MARK: validate = true
    test "that length one is valid" do
      %_{valid?: valid?} = Rut.validate("1")
      assert valid? == true
    end

    test "that length two is valid" do
      %_{valid?: valid?} = Rut.validate("1-9")
      assert valid? == true
    end

    test "that length three is valid" do
      %_{valid?: valid?} = Rut.validate("12-4")
      assert valid? == true
    end

    test "that length four is valid" do
      %_{valid?: valid?} = Rut.validate("345-K")
      assert valid? == true
    end

    test "that length five is valid" do
      %_{valid?: valid?} = Rut.validate("6457-2")
      assert valid? == true
    end

    test "that length six is valid" do
      %_{valid?: valid?} = Rut.validate("64.572-9")
      assert valid? == true
    end

    test "that length seven is valid" do
      %_{valid?: valid?} = Rut.validate("123456-0")
      assert valid? == true
    end
  end
end
