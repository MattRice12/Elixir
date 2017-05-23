defmodule EnumMap do
  def add_two do
    Enum.map [1, 2, 3, 4], &(&1 + 2)
  end

  def inspect_elem do
    # Enum.each [1,2, 3, 4], &(IO.inspect(&1))
    Enum.each [1, 2, 3, 4], &IO.inspect/1
  end
end
