# SimpleServer

This app is intended to practice building a simple router that takes requests, parses, and prints select parts of the response.


# Run

Run curl commands to get output of routes specified below


  1. Start server:
    - $ iex -S mix

  2. curl command:
    - $ curl -v <url>


## Examples


    1.
      - $ curl -v "http://localhost:8085/hello"
      - #=> world%


    2.
      - $ curl -v "http://localhost:8085/test"
      - #=> %{
                method: GET,
                http_v: HTTP/1.1,
                host: localhost,
                port: 8085,
                remote_ip: {127, 0, 0, 1},
                request_path: /test,
                scheme: http,
                full_url: http://localhost:8085/test,
                params: %{
                }
              }

# Curl commands

curl -v "http://localhost:8085/test"
curl -v "http://localhost:8085/test?grade=12&district=AISD"
curl -v "http://localhost:8085/test/1"
curl -v "http://localhost:8085/test" -d '{"grade": "12", "district": "AISD"}'
curl -v -X PUT "http://localhost:8085/test/1" -d '{"grade": "12", "district": "AISD"}'
curl -v -X DELETE "http://localhost:8085/test/1"

# Run tests

1. If the server is on, turn it off.
2. Run `mix test`
