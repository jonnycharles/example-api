defmodule ExampleApiWeb.FallbackController do
  use ExampleApiWeb, :controller

  # Called for any actions that return {:error, ...}
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ExampleApiWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # Handle 404 Not Found errors
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ExampleApiWeb.ErrorJSON)
    |> render(:"404")
  end

  # Add more error handlers as needed
end
