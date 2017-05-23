defmodule FizzBuzz do
  def run(min, max) do
    Enum.each(min..max, fn(num) -> run(num) end)
  end

  def run(num) when (rem(num, 15) == 0), do: IO.puts "fizzbuzz"
  def run(num) when (rem(num, 5) == 0), do: IO.puts "buzz"
  def run(num) when (rem(num, 3) == 0), do: IO.puts "fizz"
  def run(num), do: IO.puts num
end
