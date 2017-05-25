defmodule MyList do
  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head + total)
end

defmodule MyListNoAcc do
  def sum(list),  do: _sum(list)
  def mult(list), do: _mult(list)

  defp _sum([]), do: 0
  defp _sum([ head | tail ]), do: head + _sum(tail)

  defp _mult([]), do: 1
  defp _mult([ head | tail]), do: head * _mult(tail)
end

defmodule Reduce do
  def reduce([], value, _), do: value

  def reduce([ head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  ## Reduce.reduce([1,2,3,4], 0, &(&1 + &2))
  ## Reduce.reduce([1,2,3,4], 1, &(&1 * &2))
end
