## This finds the greatest common divisor between two numbers x, y

defmodule GCD do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end
