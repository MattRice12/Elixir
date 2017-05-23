
defmodule Prefix do
  def formalize(pre, first) do
    formalizer = fn (str) -> (fn (str2) -> str <> " " <> str2 end) end
    name = formalizer.(pre).(first)
    IO.puts name
  end
end
