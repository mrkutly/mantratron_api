defmodule MantratronApiWeb.FileController do
  use MantratronApiWeb, :controller

  action_fallback MantratronApiWeb.FallbackController

  def new(conn, %{"filename" => filename}) do
    {:ok, upload_url} = MantratronApi.Audio.get_presigned_url(filename)
    render(conn, "new.json", upload_url: upload_url)
  end

  def new(_conn, _assigns), do: {:bad_request, "Missing query parameter: filename"}
end
