defmodule AnotherParserTest do
  use ExUnit.Case
  doctest AnotherParser

  @db_string "mysql://br812jsanzd91:bwabfiaslx9q81@nfabw8w3nsadf90112.basdfjhdfakx.us-east-1.rds.amazonaws.com:3306/primary_app_db?name=matt&age=21"
  @db_string_sans_params "mysql://br812jsanzd91:bwabfiaslx9q81@nfabw8w3nsadf90112.basdfjhdfakx.us-east-1.rds.amazonaws.com:3306/primary_app_db"
  @db_string_sans_region_and_sub_domain "mysql://br812jsanzd91:bwabfiaslx9q81@nfabw8w3nsadf90112.basdfjhdfakx.amazonaws.com:3306/primary_app_db"

  # HOST — nfabw8w3nsadf90112.basdfjhdfakx.us-east-1.rds.amazonaws.com
  # REGION - us-east-1
  # SUBDOMAIN - rds
  # DOMAIN - amazonaws.com
  # PORT - 3306
  # USER — br812jsanzd91
  # PASS — bwabfiaslx9q81
  # PROTOCOL — mysql
  # DB - primary_app_db
  # PARAMS - {name: "matt", age: "21"}

  test "parse protocol" do
    assert AnotherParser.parse(@db_string)[:protocol] == "mysql"
    assert AnotherParser.parse(@db_string_sans_params)[:protocol] == "mysql"
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:protocol] == "mysql"
  end

  # @tag :skip
  test "parse user" do
    assert AnotherParser.parse(@db_string)[:user] == "br812jsanzd91"
    assert AnotherParser.parse(@db_string_sans_params)[:user] == "br812jsanzd91"
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:user] == "br812jsanzd91"
  end

  # @tag :skip
  test "parse password" do
    assert AnotherParser.parse(@db_string)[:password] == "bwabfiaslx9q81"
    assert AnotherParser.parse(@db_string_sans_params)[:password] == "bwabfiaslx9q81"
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:password] == "bwabfiaslx9q81"
  end

  # @tag :skip
  test "parse host" do
    assert AnotherParser.parse(@db_string)[:host] == "nfabw8w3nsadf90112.basdfjhdfakx.us-east-1.rds.amazonaws.com"
    assert AnotherParser.parse(@db_string_sans_params)[:host] == "nfabw8w3nsadf90112.basdfjhdfakx.us-east-1.rds.amazonaws.com"
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:host] == "nfabw8w3nsadf90112.basdfjhdfakx.amazonaws.com"
  end

  # @tag :skip
  test "parse port" do
    assert AnotherParser.parse(@db_string)[:port] == "3306"
    assert AnotherParser.parse(@db_string_sans_params)[:port] == "3306"
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:port] == "3306"
  end

  # @tag :skip
  test "parse db" do
    assert AnotherParser.parse(@db_string)[:db] == "primary_app_db"
    assert AnotherParser.parse(@db_string_sans_params)[:db] == "primary_app_db"
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:db] == "primary_app_db"
  end

  # @tag :skip
  test "parse region" do
    assert AnotherParser.parse(@db_string)[:region] == "us-east-1"
    assert AnotherParser.parse(@db_string_sans_params)[:region] == "us-east-1"
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:region] == nil
  end

  # @tag :skip
  test "parse domain" do
    assert AnotherParser.parse(@db_string)[:domain] == "amazonaws.com"
    assert AnotherParser.parse(@db_string_sans_params)[:domain] == "amazonaws.com"
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:domain] == "amazonaws.com"
  end

  # @tag :skip
  test "parse sub_domain" do
    assert AnotherParser.parse(@db_string)[:sub_domain] == "rds"
    assert AnotherParser.parse(@db_string_sans_params)[:sub_domain] == "rds"
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:sub_domain] == nil
  end

  # @tag :skip
  test "parse params" do
    # AnotherParser.parse(@db_string)
    #   |> IO.inspect
    #   |> IO.puts
    assert AnotherParser.parse(@db_string)[:params] == %{name: "matt", age: "21"}
    assert AnotherParser.parse(@db_string_sans_params)[:params] == %{}
    assert AnotherParser.parse(@db_string_sans_region_and_sub_domain)[:params] == %{}
  end

  # ---------------------------parse 2 --------------------------- #

  test "parse2 protocol" do
    assert AnotherParser.parse2(@db_string)[:protocol] == "mysql"
    assert AnotherParser.parse2(@db_string_sans_params)[:protocol] == "mysql"
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:protocol] == "mysql"
  end

  # @tag :skip
  test "parse2 user" do
    assert AnotherParser.parse2(@db_string)[:user] == "br812jsanzd91"
    assert AnotherParser.parse2(@db_string_sans_params)[:user] == "br812jsanzd91"
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:user] == "br812jsanzd91"
  end

  # @tag :skip
  test "parse2 password" do
    assert AnotherParser.parse2(@db_string)[:password] == "bwabfiaslx9q81"
    assert AnotherParser.parse2(@db_string_sans_params)[:password] == "bwabfiaslx9q81"
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:password] == "bwabfiaslx9q81"
  end

  # @tag :skip
  test "parse2 host" do
    assert AnotherParser.parse2(@db_string)[:host] == "nfabw8w3nsadf90112.basdfjhdfakx.us-east-1.rds.amazonaws.com"
    assert AnotherParser.parse2(@db_string_sans_params)[:host] == "nfabw8w3nsadf90112.basdfjhdfakx.us-east-1.rds.amazonaws.com"
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:host] == "nfabw8w3nsadf90112.basdfjhdfakx.amazonaws.com"
  end

  # @tag :skip
  test "parse2 port" do
    assert AnotherParser.parse2(@db_string)[:port] == "3306"
    assert AnotherParser.parse2(@db_string_sans_params)[:port] == "3306"
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:port] == "3306"
  end

  # @tag :skip
  test "parse2 db" do
    assert AnotherParser.parse2(@db_string)[:db] == "primary_app_db"
    assert AnotherParser.parse2(@db_string_sans_params)[:db] == "primary_app_db"
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:db] == "primary_app_db"
  end

  # @tag :skip
  test "parse2 region" do
    assert AnotherParser.parse2(@db_string)[:region] == "us-east-1"
    assert AnotherParser.parse2(@db_string_sans_params)[:region] == "us-east-1"
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:region] == nil
  end

  # @tag :skip
  test "parse2 domain" do
    assert AnotherParser.parse2(@db_string)[:domain] == "amazonaws.com"
    assert AnotherParser.parse2(@db_string_sans_params)[:domain] == "amazonaws.com"
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:domain] == "amazonaws.com"
  end

  # @tag :skip
  test "parse2 sub_domain" do
    assert AnotherParser.parse2(@db_string)[:sub_domain] == "rds"
    assert AnotherParser.parse2(@db_string_sans_params)[:sub_domain] == "rds"
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:sub_domain] == nil
  end

  # @tag :skip
  test "parse2 params" do
    assert AnotherParser.parse2(@db_string)[:params] == %{name: "matt", age: "21"}
    assert AnotherParser.parse2(@db_string_sans_params)[:params] == %{}
    assert AnotherParser.parse2(@db_string_sans_region_and_sub_domain)[:params] == %{}
  end
end
