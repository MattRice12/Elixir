defmodule Libraries do
  IO.puts :erlang.float_to_binary 2/7, [{:decimals, 2}]
  IO.puts Path.extname("some_file.exs")
  IO.puts System.cwd
  System.cmd("whoami", [])
end
