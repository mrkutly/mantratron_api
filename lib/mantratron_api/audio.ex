defmodule MantratronApi.Audio do
  @moduledoc """
  The Audio context.
  """

  import Ecto.Query, warn: false
  alias MantratronApi.Repo

  alias MantratronApi.Audio.File

  @doc """
  Returns the list of files.

  ## Examples

      iex> list_files()
      [%File{}, ...]

  """
  def list_files do
    Repo.all(File)
  end

  @doc """
  Gets a single file.

  Raises `Ecto.NoResultsError` if the File does not exist.

  ## Examples

      iex> get_file!(123)
      %File{}

      iex> get_file!(456)
      ** (Ecto.NoResultsError)

  """
  def get_file!(id), do: Repo.get!(File, id)

  @doc """
  Creates a file.

  ## Examples

      iex> create_file(%{field: value})
      {:ok, %File{}}

      iex> create_file(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_file(attrs \\ %{}) do
    %File{}
    |> File.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a file.

  ## Examples

      iex> update_file(file, %{field: new_value})
      {:ok, %File{}}

      iex> update_file(file, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_file(%File{} = file, attrs) do
    file
    |> File.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a file.

  ## Examples

      iex> delete_file(file)
      {:ok, %File{}}

      iex> delete_file(file)
      {:error, %Ecto.Changeset{}}

  """
  def delete_file(%File{} = file) do
    Repo.delete(file)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking file changes.

  ## Examples

      iex> change_file(file)
      %Ecto.Changeset{data: %File{}}

  """
  def change_file(%File{} = file, attrs \\ %{}) do
    File.changeset(file, attrs)
  end

  @doc """
  Creates a presigned url for aws file uploads.

  ## Examples

      iex> get_upload_url("markssickaudio.mp3")
      {:ok, "https://s3.amazonaws.com/mantratron-audio/marssickaudio.mp3..."}

  """
  def get_upload_url(filename) do
    ExAws.Config.new(:s3)
    |> ExAws.S3.presigned_url(:put, "mantratron-audio", filename, [])
  end

  @doc """
  Creates a presigned url for aws file downloads.

  ## Examples

      iex> get_download_url("markssickaudio.mp3")
      {:ok, "https://s3.amazonaws.com/mantratron-audio/marssickaudio.mp3..."}

  """
  def get_download_url(filename) do
    ExAws.Config.new(:s3)
    |> ExAws.S3.presigned_url(:get, "mantratron-audio", filename, [])
  end
end
