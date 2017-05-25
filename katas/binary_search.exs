defmodule BinarySearch do
  def binary(actual, range) do
    guess = (range.last) - split(range)
    IO.puts "Is it #{guess}?"
    search(actual, range, guess)
  end

  def split(range), do: div(Enum.count(range), 2)

  def search(actual, _range, guess) when (actual == guess), do: IO.puts guess
  def search(actual, range, guess) when (actual > guess),  do: search(actual, (guess..range.last))
  def search(actual, range, guess) when (actual < guess),  do: search(actual, (range.first..guess))
  def search(actual, range), do: binary(actual, range)
end
