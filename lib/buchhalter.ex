defmodule Buchhalter do
  @moduledoc """
  Documentation for Buchhalter.
  """

  alias Buchhalter.Book

  def book(name) do
    %Book{name: name, accounts: %{}}
  end

  def account(%Book{} = book, name) do
    case Map.fetch(book.accounts, name)  do
      :error ->
        accounts = Map.put(book.accounts, name, 0.0)
        Map.put(book, :accounts, accounts)

      {:ok, _} ->
        book
    end
  end
end
