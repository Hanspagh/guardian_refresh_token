defmodule GuardianRefresh.TestGuardianSerializer do
  @moduledoc false

  @behaviour Guardian.Serializer
  def for_token(%{error: :unknown}), do: {:error, "Unknown resource type"}

  def for_token(aud), do: {:ok, aud}
  def from_token(aud), do: {:ok, aud}
end

ExUnit.start()
