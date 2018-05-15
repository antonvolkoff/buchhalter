defmodule BuchhalterTest do
  use ExUnit.Case
  doctest Buchhalter

  test "greets the world" do
    assert Buchhalter.hello() == :world
  end
end
