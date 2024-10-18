defmodule ExampleApiWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :example_api,
    module: ExampleApi.Guardian,
    error_handler: ExampleApiWeb.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
