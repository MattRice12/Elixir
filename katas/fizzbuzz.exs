
defmodule FizzBuzz do
  def go(min, max) do
    # Enum.each(min..max, fn(x) -> go(x) end)
    Enum.each(min..max, &go/1)
  end

  def go(num) when (rem(num, 15) == 0), do: IO.puts "fizzbuzz"
  def go(num) when (rem(num, 3) == 0), do: IO.puts "fizz"
  def go(num) when (rem(num, 5) == 0), do: IO.puts "buzz"
  def go(num), do: IO.puts num
end
