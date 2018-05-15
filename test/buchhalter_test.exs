defmodule BuchhalterTest do
  use ExUnit.Case
  alias Buchhalter.Book

  doctest Buchhalter

  describe "book/1" do
    test "returns new book" do
      assert %Book{name: "name1"} = Buchhalter.book("name1")
      assert %Book{name: "name2"} = Buchhalter.book("name2")
    end
  end
end
