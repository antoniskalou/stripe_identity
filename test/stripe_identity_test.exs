defmodule StripeIdentityTest do
  use ExUnit.Case
  doctest StripeIdentity

  test "greets the world" do
    assert StripeIdentity.hello() == :world
  end
end
