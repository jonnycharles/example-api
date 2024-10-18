defmodule ExampleApiWeb.ProtectedResourceController do
  use ExampleApiWeb, :controller

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    json(conn, %{message: "This is a protected resource", user_id: user.id})
  end
end
