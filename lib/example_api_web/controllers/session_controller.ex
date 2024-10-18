defmodule ExampleApiWeb.SessionController do
  use ExampleApiWeb, :controller
  alias ExampleApi.Accounts
  alias ExampleApi.Guardian

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        case Guardian.encode_and_sign(user) do
          {:ok, token, _claims} ->
            conn
            |> put_status(:ok)
            |> json(%{token: token})
          {:error, reason} ->
            conn
            |> put_status(:unauthorized)
            |> json(%{error: "Failed to generate token: #{reason}"})
        end
      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid email or password"})
    end
  end
end
