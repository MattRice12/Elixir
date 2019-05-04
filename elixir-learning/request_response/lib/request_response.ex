defmodule RequestResponse do
  # def set_route([route, query_string_params]), do: [route, query_string_params]
  # def set_route([route]), do: [route, nil]

  def set_domains([sub_domain, domain]), do: [sub_domain, domain]
  def set_domains([domain]), do: [nil, domain]
  def set_domains([]), do: [nil, nil]

  def parse_params([_, _, _ | tail], nil) do
    %{
      resource: Enum.at(tail, 0),
      id:       Enum.at(tail, 1)
    }
  end

  def parse_params([_, _, _ | tail], query_string_params) do
    resource = Enum.at(tail, 0)
    id       = Enum.at(tail, 1)

    params = query_string_params
      |> String.split("&")
      |> Enum.map(fn param -> [k, v] = String.split(param, "="); {String.to_atom(k), v} end)
      |> Map.new

    Map.merge(params, %{
      resource: resource,
      id: id
    })
  end

  def parse(raw_request) do
    http_arr = String.split(raw_request, " ")

    method = Enum.at(http_arr, 0)
    uri    = Enum.at(http_arr, 1)
    http_v = Enum.at(http_arr, 2)

    uri_arr             = String.split(uri, "?")
    route               = Enum.at(uri_arr, 0)
    query_string_params = Enum.at(uri_arr, 1)

    uri_fragments = String.split(route, "/")
    protocol = Enum.at(uri_fragments, 0) |> String.slice(0..-2)
    full_url = Enum.at(uri_fragments, 2)

    full_url_arr = String.split(full_url, ".")

    [sub_domain, domain] = set_domains(full_url_arr)

    params = parse_params(uri_fragments, query_string_params)

    %{
      method: method,
      uri: uri,
      http_v: http_v,
      route: route,
      protocol: protocol,
      sub_domain: sub_domain,
      domain: domain,
      full_url: full_url,
      params: params
    }
  end

  ## NOTE: Problems with this approach:
  ##   - Very error prone bc of pattern matching.
  ##   - Also it's harder to read
  # def parse(raw_request) do
  #   request_map = %{}
  #   [method, uri, http_v] = String.split(raw_request, " ")
  #   [route, query_string_params] = String.split(uri, "?") |> set_route
  #   [protocol, _, full_url | uri_fragments] = String.split(route, "/")
  #   protocol = protocol |> String.slice(0..-2)
  #   [sub_domain, domain] = String.split(full_url, ".") |> set_domains
  #
  #   params = parse_params(uri_fragments, query_string_params)
  #
  #   %{
  #       method: method,
  #       uri: uri,
  #       http_v: http_v,
  #       route: route,
  #       protocol: protocol,
  #       sub_domain: sub_domain,
  #       domain: domain,
  #       full_url: full_url,
  #       params: params
  #   }
  # end

  def check_validity(raw_request) do
    try do
      [_method, _uri, _http_v] = String.split(raw_request, " ")

      {:ok, raw_request}
    rescue
      MatchError -> {:error, "INVALID URL"}
    end
  end

  def get_input do
    input = "Supply a valid HTTP Request URL (h for help, q for quit) > "
      |> IO.gets
      |> String.trim("\n")

    case input do
      "q" -> IO.puts "Exiting."
      "h" ->
        IO.puts "A valid HTTP Request looks like:"
        IO.puts "\t'GET http://localhost:3000/students HTTP/1.1'"
        get_input()
      "test1" ->
        url = "GET http://localhost:3000/students HTTP/1.1"
        IO.puts "---- " <> url
        url
          |> parse
          |> IO.inspect
      "test2" ->
        url = "GET http://localhost:3000/students/1?grade=12&district=AISD HTTP/1.1"
        IO.puts "---- " <> url
        url
          |> parse
          |> IO.inspect
      raw_request ->
        case check_validity(raw_request) do
          {:ok, raw_request} ->
            raw_request
            |> parse
            |> IO.inspect
          {:error, e} ->
            IO.puts e
        end
    end
  end
end

# RequestResponse.get_input
