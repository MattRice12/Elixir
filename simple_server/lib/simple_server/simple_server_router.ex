defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger

  require Logger
  plug(Plug.Logger, log: :debug)

  plug(:match)

  plug(:dispatch)

  get "/hello", do: send_resp(conn, 200, "world")

  # curl -v "http://localhost:8085/test"
  # curl -v "http://localhost:8085/test?grade=12&district=AISD"
  get "/test" do
    {:ok, _, conn} = read_body(conn)
    send_resp(conn, 200, ParseHTTP.parse_get(conn))
  end

  # curl -v "http://localhost:8085/test/1"
  get "/test/:id" do
    {:ok, _, conn} = read_body(conn)
    IO.inspect conn
    send_resp(conn, 200, ParseHTTP.parse_get(conn))
  end

  # curl -v "http://localhost:8085/test" -d '{"grade": "12", "district": "AISD"}'
  post "/test" do
    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    send_resp(conn, 201, ParseHTTP.parse_post(conn, body))
  end

  # curl -v -X PUT "http://localhost:8085/test/1" -d '{"grade": "12", "district": "AISD"}'
  put "/test/:id" do
    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    send_resp(conn, 201, ParseHTTP.parse_put(conn, body))
  end

  # curl -v -X DELETE "http://localhost:8085/test/1"
  delete "/test/:id" do
    {:ok, _, conn} = read_body(conn)
    send_resp(conn, 202, ParseHTTP.parse_delete(conn))
  end

  match _ do
    send_resp(conn, 404, "not found!!!")
  end
end
