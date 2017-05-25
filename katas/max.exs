defmodule MyList do
  def max(list), do: _max(list, 0)

  defp _max([], max), do: max

  defp _max([ head | tail ], max) when head <= max, do: _max(tail, max)
  defp _max([ head | tail ], max) when head > max,  do: _max(tail, head)
end
