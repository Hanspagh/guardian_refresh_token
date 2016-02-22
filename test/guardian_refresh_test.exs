defmodule GuardianRefreshTest do
  @moduledoc false
  use ExUnit.Case, async: true


  test "can issue refrsh token" do
    {:ok, jwt, _} =  GuardianRefresh.issue_refresh_token("data")
    {:ok, claims} = Guardian.decode_and_verify(jwt)
    assert claims["typ"] == "refresh"
    #TODO assert that token is long living
  end

  test "can exchange refresh token to access token" do
    {:ok, jwtRefresh, _} =  GuardianRefresh.issue_refresh_token("data")
    {:ok, jwt, _} = GuardianRefresh.exchange_for_access(jwtRefresh)
    {:ok, claims} = Guardian.decode_and_verify(jwt)
    assert claims["typ"] == "token"
    #TODO assert that token is short living
  end
end
