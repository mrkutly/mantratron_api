defmodule MantratronApi.Repo do
  use Ecto.Repo,
    otp_app: :mantratron_api,
    adapter: Ecto.Adapters.Postgres
end
