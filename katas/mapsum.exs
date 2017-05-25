defmodule MyList do
  def mapsum([], value, _), do: value

  def mapsum([ head | tail ], value, func) do
    mapsum(tail, func.(head, value), func)
  end
end
