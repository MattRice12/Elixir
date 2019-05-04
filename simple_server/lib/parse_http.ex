defmodule ParseHTTP do
  def parse_get(conn) do
    standard_output_data(conn)
      |> build_params
      |> output
  end

  def parse_post(conn, body) do
    standard_output_data(conn)
      |> build_params(body)
      |> output
  end

  def parse_put(conn, body) do
    standard_output_data(conn)
      |> build_params(body)
      |> output
  end

  def parse_delete(conn) do
    standard_output_data(conn)
      |> build_params
      |> output
  end

  defp build_params(map) do
    params = parse_params(map.query_string)
      |> full_params(map.path_params)
    Map.put(map, :params, params_to_string(params))
  end
  defp build_params(map, body) do
    params = full_params(body, map.path_params)
    Map.put(map, :params, params_to_string(params))
  end

  defp standard_output_data(conn) do
    %{}
      |> Map.put(:method,       conn.method)
      |> Map.put(:http_v,       "HTTP/1.1")
      |> Map.put(:host,         conn.host)
      |> Map.put(:port,         conn.port)
      |> Map.put(:remote_ip,    print_ip(conn.remote_ip))
      |> Map.put(:request_path, conn.request_path)
      |> Map.put(:scheme,       conn.scheme)
      |> Map.put(:path_params,  conn.path_params)
      |> Map.put(:query_string, conn.query_string)
      |> Map.put(:full_url,     "#{conn.scheme}://#{conn.host}:#{conn.port}#{conn.request_path}")
  end

  defp output(map) do
    """
    %{
      method: #{map.method},
      http_v: #{map.http_v},
      host: #{map.host},
      port: #{map.port},
      remote_ip: {#{map.remote_ip}},
      request_path: #{map.request_path},
      scheme: #{map.scheme},
      full_url: #{map.full_url},
      params: %{#{map.params}}
    }
    """
  end

  defp params_to_string(""), do: ""
  defp params_to_string(params) do
    Enum.map_join(params, ",", fn {k, v} -> "\n\s\s\s\s" <> ~s{"#{k}": "#{v}"} end) <> "\n\s\s"
  end

  defp print_ip(ip), do: Enum.join(Tuple.to_list(ip), ", ")

  defp parse_params(""), do: %{}
  defp parse_params(query_string) do
    query_string
      |> String.split("&")
      |> Enum.map(fn param -> [k, v] = String.split(param, "="); {String.to_atom(k), v} end)
      |> Map.new
  end

  defp full_params(params, %{"id" => id}), do: Map.put(params, :id, id)
  defp full_params(params, _), do: params
end
