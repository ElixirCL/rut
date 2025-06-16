defmodule ElixirCLRutFormatterTest do
  use ExUnit.Case, async: true
  doctest ElixirCLRut.Formatter, import: true

  alias ElixirCLRut.Formatter
  alias ElixirCLRut

  describe "format/2" do
    test "formats a normalized RUT struct with default separator" do
      rut = ElixirCLRut.from("20961605-K")
      assert Formatter.format(rut) == "20.961.605-K"

      assert ElixirCLRut.format("141231553", separator: "") == "14123155-3"
    end

    test "formats a normalized RUT struct with custom separator" do
      rut = ElixirCLRut.from("20961605-K")
      assert Formatter.format(rut, separator: ",") == "20,961,605-K"
    end
  end

  describe "dots/3" do
    test "adds dots to a list of rut characters" do
      assert Formatter.dots([2, 0, 9, 6, 1, 6, 0, 5]) == "20.961.605"
      assert Formatter.dots([2, 0, 9, 6, 1, 6, 0, 5], ",") == "20,961,605"
      assert Formatter.dots([2, 0, 9, 6, 1, 6, 0, 5], ",", 3) == "20,961,605"
    end
  end

  describe "clean/1" do
    test "removes all chars except numbers and K" do
      assert Formatter.clean("2228250-6") == "22282506"
      assert Formatter.clean("14.193.432-5") == "141934325"
      assert Formatter.clean("12.345.678-k") == "12345678k"
    end
  end

  describe "normalize/1" do
    test "transforms a RUT string to a list of numbers" do
      assert Formatter.normalize("2228250-6") == [2, 2, 2, 8, 2, 5, 0, 6]
      assert Formatter.normalize("14.193.432-5") == [1, 4, 1, 9, 3, 4, 3, 2, 5]
      assert Formatter.normalize("12.345.678-k") == [1, 2, 3, 4, 5, 6, 7, 8, "K"]
    end
  end
end
