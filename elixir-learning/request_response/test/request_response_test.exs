defmodule RequestResponseTest do
  use ExUnit.Case
  doctest RequestResponse

  @base_url "GET http://localhost:3000/students HTTP/1.1"
  @expanded_url "GET http://localhost:3000/students?grade=12&district=AISD HTTP/1.1"
  @expanded_url_with_id "GET http://localhost:3000/students/1?grade=12&district=AISD HTTP/1.1"

  test "parse raw_request method" do
    assert RequestResponse.parse(@base_url)[:method] == "GET"
  end

  test "parse raw_request uri" do
    assert RequestResponse.parse(@expanded_url)[:uri] == "http://localhost:3000/students?grade=12&district=AISD"
  end

  test "parse raw_request http_v" do
    assert RequestResponse.parse(@expanded_url)[:http_v] == "HTTP/1.1"
  end

  test "parse raw_request route" do
    assert RequestResponse.parse(@expanded_url)[:route] == "http://localhost:3000/students"
  end

  test "parse raw_request protocol" do
    assert RequestResponse.parse(@expanded_url)[:protocol] == "http"
  end

  test "parse raw_request full_url" do
    assert RequestResponse.parse(@expanded_url)[:full_url] == "localhost:3000"
  end

  test "parse raw_request domain" do
    assert RequestResponse.parse("GET http://sub_domain.domain/students?grade=12&district=AISD HTTP/1.1")[:domain] == "domain"
  end

  test "parse raw_request sub_domain" do
    assert RequestResponse.parse("GET http://sub_domain.domain/students?grade=12&district=AISD HTTP/1.1")[:sub_domain] == "sub_domain"
  end

  test "parse raw_request nil sub_domain" do
    assert RequestResponse.parse("GET http://domain/students?grade=12&district=AISD HTTP/1.1")[:sub_domain] == nil
  end

  test "parse raw_request params" do
    assert RequestResponse.parse(@expanded_url)[:params] == %{id: nil, resource: "students", grade: "12", district: "AISD"}
  end

  test "parse raw_request resource" do
    assert RequestResponse.parse(@expanded_url)[:params][:resource] == "students"
  end

  test "parse raw_request no id" do
    assert RequestResponse.parse(@expanded_url)[:params][:id] == nil
  end

  test "parse raw_request id" do
    assert RequestResponse.parse(@expanded_url_with_id)[:params][:id] == "1"
  end

  test "parse_params resource" do
    assert RequestResponse.parse_params(["http", "", "localhost:3000", "resource", "1"], nil)[:resource] == "resource"
  end

  test "parse_params id" do
    assert RequestResponse.parse_params(["http", "", "localhost:3000", "resource", "1"], nil)[:id] == "1"
  end

  test "parse_params params" do
    assert RequestResponse.parse_params(["http", "", "localhost:3000", "resource", "1"], "grade=12&district=AISD")[:grade] == "12"
    assert RequestResponse.parse_params(["http", "", "localhost:3000", "resource", "1"], "grade=12&district=AISD")[:district] == "AISD"
  end
end
