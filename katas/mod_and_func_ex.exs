defmodule MaF do
  def double(num), do: num * 2
  def triple(num), do: num * 3
  def quadruple(num), do: double(double(num))
end
