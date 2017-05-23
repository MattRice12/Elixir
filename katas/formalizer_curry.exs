
defmodule Prefix do
  def formalize(pre, first) do
    formalizer = fn (str) -> (fn (str2) -> str <> " " <> str2 end) end
    name = formalizer.(pre).(first)
    IO.puts name
  end
end

defmodule Suffix do
  def formalize(first, last, suff) do
    formalizer = &(&1 <> " " <> &2 <> ", " <> &3)
    name = formalizer.(first, last, suff)
    IO.puts name
  end
end
