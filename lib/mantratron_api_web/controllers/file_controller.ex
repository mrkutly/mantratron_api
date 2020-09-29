defmodule MantratronApiWeb.FileController do
  use MantratronApiWeb, :controller
  alias MantratronApi.Audio

  action_fallback MantratronApiWeb.FallbackController

  def new(conn, %{"filename" => filename}) do
    uuid = ~s(#{Ecto.UUID.generate()}-#{filename})
    {:ok, upload_url} = Audio.get_upload_url(uuid)
    render(conn, "new.json", upload_url: upload_url, uuid: uuid)
  end

  def new(_conn, _assigns), do: {:bad_request, "Missing query parameter: filename"}

  def create(conn, %{"uuid" => uuid, "duration" => duration}) do
    with {:ok, file} <- Audio.create_file(%{duration: duration, uuid: uuid}),
         {:ok, download_url} <- Audio.get_download_url(uuid) do
      render(conn, "show.json",
        file: %{uuid: uuid, duration: duration, download_url: download_url}
      )
    end
  end

  def create(_conn, _assigns),
    do: {:bad_request, "Missing one of the required body parameters: uuid, duration"}
end
