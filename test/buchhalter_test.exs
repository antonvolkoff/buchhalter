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

  describe "account/2" do
    test "adds account" do
      book = Buchhalter.book("test")
      book = Buchhalter.account(book, "assets.cash")
      book = Buchhalter.account(book, "equity.opening_balance")

      assert book.accounts == %{"assets.cash" => 0.0, "equity.opening_balance" => 0.0}
    end

    test "does not add account twice" do
      book = %Book{accounts: %{"assets.cash" => 1.0}}
      book = Buchhalter.account(book, "assets.cash")

      assert book.accounts == %{"assets.cash" => 1.0}
    end
  end
end
