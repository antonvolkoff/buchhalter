defmodule Buchhalter do
  @moduledoc """
  Documentation for Buchhalter.
  """

  alias Buchhalter.Book

  def book(name) do
    %Book{name: name}
  end
end
