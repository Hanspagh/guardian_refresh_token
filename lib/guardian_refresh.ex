defmodule GuardianRefresh do

    @doc """
    Issue a JWT from a resource that can be exhanged for a access JWT later.
    The resource will be run through the configured serializer
    to obtain a value suitable for storage inside a JWT.
    """
    def issue_refresh_token(object) do
      case Guardian.encode_and_sign(object, :refresh) do
        {:ok, jwt, full_claims} -> {:ok, jwt, full_claims}
        {:error, reason} -> {:error, reason}
      end
    end

    @doc """
    Exhange a refresh token for an access token with the same claims
    """
    def exchange_for_access(jwt) do
      case Guardian.decode_and_verify(jwt) do
        {:ok, found_claims} ->
          do_refresh!(jwt, found_claims)
        {:error, reason} -> {:error, reason}
      end
    end

    defp do_refresh!(_jwt, claims) do
      new_claims = claims
      |> Map.drop(["jti", "iat", "exp", "nbf", "typ"])
      |> Guardian.Claims.jti
      |> Guardian.Claims.nbf
      |> Guardian.Claims.iat
      |> Guardian.Claims.ttl

      {:ok, resource} = Guardian.serializer.from_token(new_claims["sub"])

      case Guardian.encode_and_sign(resource, "token", new_claims) do
        {:ok, jwt, full_claims} -> {:ok, jwt, full_claims}
        {:error, reason} -> {:error, reason}
      end
    end
end
