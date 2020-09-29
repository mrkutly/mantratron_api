defmodule MantratronApi.Helpers do
  @moduledoc """
  Helper functions for use in the MantratronApi
  """

  @doc """
  Generates a random base64-encoded token of the supplied length.

  ## Examples

      iex> MantratronApi.Helpers.gen_token()
      "YhITAU98OGK2IS6TTeGqiQ=="

      iex> MantratronApi.Helpers.gen_token(50)
      "7G9VsJQH/7OZvP0Z7ZWhb5k+Dh1JPJyFUINC+4m34gxUiusGZ31pR59V1ET5HVr68hk="
  """
  def gen_token(length \\ 24) do
    :crypto.strong_rand_bytes(length) |> :base64.encode()
  end
end
