defmodule AnotherParser do
  defp parse_db_params([db, params_str]), do: [db, params_str]
  defp parse_db_params([db]),             do: [db, nil]

  defp parse_host([_, _, region, sub_domain, domain, com]), do: [nil, nil, region, sub_domain, domain, com]
  defp parse_host([_, _, domain, com]), do: [nil, nil, nil, nil, domain, com]

  def parse_params(nil), do: %{}
  def parse_params(params) do
    params
      |> String.split("&")
      |> Enum.map(fn param ->
        [k, v] = String.split(param, "=")
        {String.to_atom(k), v}
      end)
      |> Map.new
  end

  def parse(database_string) do
    [protocol, user, pw_host, ending] = String.split(database_string, ":")
    [password, host]  = String.split(pw_host, "@")
    [port, db_params] = String.split(ending, "/")
    [db, params_str]  = parse_db_params(String.split(db_params, "?"))

    [_, _, region, sub_domain, domain, com] = parse_host(String.split(host, "."))

    params = parse_params(params_str)

    %{
      protocol: protocol,
      user: String.slice(user, 2..-1),
      password: password,
      host: host,
      port: port,
      db: db,
      region: region,
      sub_domain: sub_domain,
      domain: Enum.join([domain, com], "."),
      params: params
    }
  end

  def parse2(database_string) do
    db_arr = String.split(database_string, ":")

    protocol = Enum.at(db_arr, 0)
    user_str = Enum.at(db_arr, 1)
    pw_host  = Enum.at(db_arr, 2)
    ending   = Enum.at(db_arr, 3)

    user = String.slice(user_str, 2..-1)

    pw_host_arr = String.split(pw_host, "@")
    password    = Enum.at(pw_host_arr, 0)
    host        = Enum.at(pw_host_arr, 1)

    port_db_params_arr = String.split(ending, "/")
    port               = Enum.at(port_db_params_arr, 0)
    db_params          = Enum.at(port_db_params_arr, 1)

    db_params_arr = String.split(db_params, "?")
    db            = Enum.at(db_params_arr, 0)
    params_str    = Enum.at(db_params_arr, 1)

    [_, _, region, sub_domain, domain, com] = parse_host(String.split(host, "."))

    params = parse_params(params_str)

    %{
      protocol: protocol,
      user: user,
      password: password,
      host: host,
      port: port,
      db: db,
      region: region,
      sub_domain: sub_domain,
      domain: Enum.join([domain, com], "."),
      params: params
    }
  end
end

database_string = "mysql://br812jsanzd91:bwabfiaslx9q81@nfabw8w3nsadf90112.basdfjhdfakx.us-east-1.rds.amazonaws.com:3306/primary_app_db?name=matt&age=21"

AnotherParser.parse(database_string)
  # |> IO.inspect
  # |> IO.puts
