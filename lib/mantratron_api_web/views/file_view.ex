defmodule MantratronApiWeb.FileView do
  use MantratronApiWeb, :view

  def render("new.json", %{upload_url: upload_url}) do
    %{data: upload_url}
  end
end
