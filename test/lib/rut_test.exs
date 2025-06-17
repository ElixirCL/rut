defmodule ElixirCLRutTest do
  use ExUnit.Case, async: true
  doctest ElixirCLRut, import: true

  alias ElixirCLRut, as: Rut

  describe "validate/1" do
    test "that empty is not valid" do
      assert Rut.validate(" ") == false
    end

    test "that one length is valid" do
      assert Rut.validate("1-9") == true
    end

    test "that one number is not valid" do
      assert Rut.validate("1") == false
    end

    test "that 1k-9 is not valid" do
      assert Rut.validate("1k-9") == false
    end

    test "that a wrong rut is not valid" do
      assert Rut.validate("4.898.089-1") == false
    end

    test "validates correct RUTs" do
      assert Rut.validate("14.123.155-3") == true
      assert Rut.validate("14.123.155-3") == true
      assert Rut.validate("141231553") == true
      assert Rut.validate("7.617.343-5") == true
      assert Rut.validate("76173435") == true
      assert Rut.validate("1-9") == true
      assert Rut.validate("19") == true
      assert Rut.validate("11.111.111-1") == true
      assert Rut.validate("111111111") == true
      assert Rut.validate("22.060.449-7") == true
      assert Rut.validate("22060449-7") == true
    end

    test "invalidates incorrect RUTs" do
      refute Rut.validate("12.345.678-9")
      refute Rut.validate("123456789")
      refute Rut.validate("7.617.343-4")
      refute Rut.validate("76173434")
      refute Rut.validate("1-8")
      refute Rut.validate("18")
      refute Rut.validate("11.111.111-2")
      refute Rut.validate("111111112")
      refute Rut.validate("20.533.456-3")
      refute Rut.validate("205334563")
    end

    test "invalidates malformed or too short RUTs" do
      refute Rut.validate("")
      refute Rut.validate("K")
      refute Rut.validate("1")
      refute Rut.validate("A")
      refute Rut.validate("12.345.678-")
      refute Rut.validate("12.345.678-@")
      refute Rut.validate("12.345.678-0K")
      refute Rut.validate("12.345.678-")
      refute Rut.validate("12.345.678")
    end
  end

  # MARK: - valid tests
  describe "valid/1" do
    # MARK: validate = false

    test "that empty is not valid" do
      %_{valid?: valid?} = Rut.valid("")
      assert valid? == false
    end

    test "that one letter is invalid" do
      %_{valid?: valid?} = Rut.valid("I")
      assert valid? == false
    end

    test "that two letters are invalid" do
      %_{valid?: valid?} = Rut.valid("IN")
      assert valid? == false
    end

    test "that three letters are invalid" do
      %_{valid?: valid?} = Rut.valid("INV")
      assert valid? == false
    end

    test "that four letters are invalid" do
      %_{valid?: valid?} = Rut.valid("INVA")
      assert valid? == false
    end

    test "that five letters are invalid" do
      %_{valid?: valid?} = Rut.valid("INVAL")
      assert valid? == false
    end

    test "that six letters are invalid" do
      %_{valid?: valid?} = Rut.valid("INVALI")
      assert valid? == false
    end

    test "that seven letters are invalid" do
      %_{valid?: valid?} = Rut.valid("INVALID")
      assert valid? == false
    end

    test "that K is invalid" do
      %_{valid?: valid?} = Rut.valid("K")
      assert valid? == false
    end

    test "that a wrong rut is not valid" do
      %_{valid?: valid?} = Rut.valid("4.898.089-1")
      assert valid? == false
    end

    # MARK: valid = true
    test "that length one is not valid" do
      %_{valid?: valid?} = Rut.valid("1")
      assert valid? == false
    end

    test "that length two is valid" do
      %_{valid?: valid?} = Rut.valid("1-9")
      assert valid? == true
    end

    test "that length three is valid" do
      %_{valid?: valid?} = Rut.valid("12-4")
      assert valid? == true
    end

    test "that length four is valid" do
      %_{valid?: valid?} = Rut.valid("345-K")
      assert valid? == true
    end

    test "that length five is valid" do
      %_{valid?: valid?} = Rut.valid("6457-2")
      assert valid? == true
    end

    test "that length six is valid" do
      %_{valid?: valid?} = Rut.valid("64.572-9")
      assert valid? == true
    end

    test "that length seven is valid" do
      %_{valid?: valid?} = Rut.valid("123456-0")
      assert valid? == true
    end
  end

  describe "clean/1" do
    test "removes dots, hyphens, spaces, and uppercases k" do
      assert Rut.clean("14.123.155-3") == "141231553"
      assert Rut.clean("14.123.155-3") == "141231553"
      assert Rut.clean(" 14.123.155-3 ") == "141231553"
      assert Rut.clean("14-123-155-3") == "141231553"
      assert Rut.clean("14.123.1553") == "141231553"
      assert Rut.clean("14.123.1553") == "141231553"
    end

    test "returns only digits and K" do
      assert Rut.clean("abc123Kxyz") == "123K"
      assert Rut.clean("K") == "K"
      assert Rut.clean("12345678") == "12345678"
    end

    test "handles empty string" do
      assert Rut.clean("") == ""
    end
  end

  describe "format/1 and format/2" do
    test "formats a clean RUT with default separator" do
      assert Rut.format("12345678K") == "12.345.678-K"
      assert Rut.format("123456789") == "12.345.678-9"
      assert Rut.format("1234K") == "1.234-K"
      assert Rut.format("12K") == "12-K"
    end

    test "formats a dirty RUT" do
      assert Rut.format("12.345.678-k") == "12.345.678-K"
      assert Rut.format(" 12.345.678-k ") == "12.345.678-K"
      assert Rut.format("12-345-678-k") == "12.345.678-K"
    end

    test "formats with custom separator" do
      assert Rut.format("12345678K", ",") == "12,345,678-K"
      assert Rut.format("12345678K", "") == "12345678-K"
    end

    test "returns input if too short" do
      assert Rut.format("K") == "K"
      assert Rut.format("1") == "1"
      assert Rut.format("", ",") == ""
    end
  end
end
