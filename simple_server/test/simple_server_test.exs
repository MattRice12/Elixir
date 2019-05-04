defmodule SimpleServerTest do
  use ExUnit.Case
  use Plug.Test

  alias SimpleServer.Router

  @opts Router.init([])

  test "greets the world" do
    conn = conn(:get, "/hello")
    resp = send_resp(conn, 200, "world")
    assert resp.resp_body == "world"
  end

  test "test index - GET" do
    conn = conn(:get, "/test")
    resp = send_resp(conn, 200, ParseHTTP.parse_get(conn))

    assert resp.status == 200
    assert resp.resp_body == """
    %{
      method: GET,
      http_v: HTTP/1.1,
      host: www.example.com,
      port: 80,
      remote_ip: {127, 0, 0, 1},
      request_path: /test,
      scheme: http,
      full_url: http://www.example.com:80/test,
      params: %{
      }
    }
    """
  end

  test "test index with params - GET" do
    conn = conn(:get, "/test?grade=12&district=AISD")
    resp = send_resp(conn, 200, ParseHTTP.parse_get(conn))

    assert resp.status == 200
    assert resp.resp_body == """
    %{
      method: GET,
      http_v: HTTP/1.1,
      host: www.example.com,
      port: 80,
      remote_ip: {127, 0, 0, 1},
      request_path: /test,
      scheme: http,
      full_url: http://www.example.com:80/test,
      params: %{
        \"district\": \"AISD\",
        \"grade\": \"12\"
      }
    }
    """
  end

  # NOTE: This test does not capture path_params in the request
  test "test show - GET" do
    conn = conn(:get, "/test/1")
    {:ok, _, conn} = read_body(conn)
    resp = send_resp(conn, 200, ParseHTTP.parse_get(conn))

    assert resp.status == 200
    assert resp.resp_body == """
    %{
      method: GET,
      http_v: HTTP/1.1,
      host: www.example.com,
      port: 80,
      remote_ip: {127, 0, 0, 1},
      request_path: /test/1,
      scheme: http,
      full_url: http://www.example.com:80/test/1,
      params: %{
      }
    }
    """
  end

  # NOTE: This test does not capture path_params in the request
  test "test show with params - GET" do
    conn = conn(:get, "/test/1?grade=12&district=AISD")
    resp = send_resp(conn, 200, ParseHTTP.parse_get(conn))

    assert resp.resp_body == """
    %{
      method: GET,
      http_v: HTTP/1.1,
      host: www.example.com,
      port: 80,
      remote_ip: {127, 0, 0, 1},
      request_path: /test/1,
      scheme: http,
      full_url: http://www.example.com:80/test/1,
      params: %{
        \"district\": \"AISD\",
        \"grade\": \"12\"
      }
    }
    """
  end

  test "test show with params - POST" do
    conn = conn(:post, "/test")
    body = %{grade: 12, district: "AISD"}
    resp = send_resp(conn, 201, ParseHTTP.parse_post(conn, body))

    assert resp.status == 201
    assert resp.resp_body == """
    %{
      method: POST,
      http_v: HTTP/1.1,
      host: www.example.com,
      port: 80,
      remote_ip: {127, 0, 0, 1},
      request_path: /test,
      scheme: http,
      full_url: http://www.example.com:80/test,
      params: %{
        \"district\": \"AISD\",
        \"grade\": \"12\"
      }
    }
    """
  end

  # NOTE: This test does not capture path_params in the request
  test "test show with params - PUT" do
    conn = conn(:put, "/test/1")
    body = %{grade: 12, district: "AISD"}
    resp = send_resp(conn, 201, ParseHTTP.parse_put(conn, body))

    assert resp.status == 201
    assert resp.resp_body == """
    %{
      method: PUT,
      http_v: HTTP/1.1,
      host: www.example.com,
      port: 80,
      remote_ip: {127, 0, 0, 1},
      request_path: /test/1,
      scheme: http,
      full_url: http://www.example.com:80/test/1,
      params: %{
        \"district\": \"AISD\",
        \"grade\": \"12\"
      }
    }
    """
  end

  # NOTE: This test does not capture path_params in the request
  test "test show with params - DELETE" do
    conn = conn(:delete, "/test/1")
    resp = send_resp(conn, 202, ParseHTTP.parse_delete(conn))

    assert resp.status == 202
    assert resp.resp_body == """
    %{
      method: DELETE,
      http_v: HTTP/1.1,
      host: www.example.com,
      port: 80,
      remote_ip: {127, 0, 0, 1},
      request_path: /test/1,
      scheme: http,
      full_url: http://www.example.com:80/test/1,
      params: %{
      }
    }
    """
  end

  test "no matching route" do
    conn = conn(:get, "/no_match")
    resp = send_resp(conn, 404, "not found")

    assert resp.status == 404
    assert resp.resp_body == "not found"
  end
end
