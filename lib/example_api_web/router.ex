defmodule ExampleApiWeb.Router do
  use ExampleApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ExampleApiWeb.Guardian.AuthPipeline
  end

  scope "/api", ExampleApiWeb do
    pipe_through :api

    post "/users", UserController, :create
    post "/sessions", SessionController, :create
  end

  scope "/api", ExampleApiWeb do
    pipe_through [:api, :auth]

    get "/protected_resources", ProtectedResourceController, :index
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:example_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ExampleApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
