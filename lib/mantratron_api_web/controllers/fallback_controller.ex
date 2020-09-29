defmodule MantratronApiWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:bad_request, error}) do
    conn
    |> put_status(:bad_request)
    |> put_view(MantratronApiWeb.ErrorView)
    |> render("400.json", %{error: error})
  end
end
