defmodule MantratronApiWeb.FileView do
  use MantratronApiWeb, :view

  def render("new.json", %{upload_url: upload_url, uuid: uuid}) do
    %{data: %{upload_url: upload_url, uuid: uuid}}
  end

  def render("show.json", %{file: file}) do
    %{data: render_one(file, MantratronApiWeb.FileView, "file.json")}
  end

  def render("file.json", %{file: %{download_url: download_url, duration: duration, uuid: uuid}}) do
    %{download_url: download_url, duration: duration, uuid: uuid}
  end
end
