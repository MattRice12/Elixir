defmodule ArgCases do
  def arg_cases(a, b, c) when ((a == 0) and (b == 0)), do: IO.puts "FizzBuzz"
  def arg_cases(a, b, c) when (a == 0), do: IO.puts "Fizz"
  def arg_cases(a, b, c) when (b == 0), do: IO.puts "Buzz"
  def arg_cases(a, b, c), do: IO.puts c
end
