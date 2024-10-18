defmodule ExampleApi.Repo do
  use Ecto.Repo,
    otp_app: :example_api,
    adapter: Ecto.Adapters.Postgres
end
