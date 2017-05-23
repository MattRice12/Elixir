defmodule ByTwo do
  def multiply(num) do
    times_2 = fn n -> n * 2 end
    apply = fn (fun, value) -> fun.(value) end
    apply.(times_2, num)
  end

  def add(num) do
    add_2 = fn n -> n + 2 end
    apply = fn (fun, value) -> fun.(value) end
    apply.(add_2, num)
  end

  def subtract(num) do
    sub_2 = fn n -> n - 2 end
    apply = fn (fun, value) -> fun.(value) end
    apply.(sub_2, num)
  end

  def divide(num) do
    div_2 = fn n -> div(n, 2) end
    apply = fn (fun, value) -> fun.(value) end
    apply.(div_2, num)
  end
end
