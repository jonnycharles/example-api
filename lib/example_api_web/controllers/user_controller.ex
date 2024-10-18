defmodule ExampleApiWeb.UserController do
  use ExampleApiWeb, :controller
  alias ExampleApi.Accounts
  alias ExampleApi.Accounts.User

  action_fallback ExampleApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> json(%{data: %{id: user.id, email: user.email}})
    end
  end
end
