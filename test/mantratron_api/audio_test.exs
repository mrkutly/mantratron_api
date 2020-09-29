defmodule MantratronApi.AudioTest do
  use MantratronApi.DataCase

  alias MantratronApi.Audio

  describe "files" do
    alias MantratronApi.Audio.File

    @valid_attrs %{duration: 42, url: "some url"}
    @update_attrs %{duration: 43, url: "some updated url"}
    @invalid_attrs %{duration: nil, url: nil}

    def file_fixture(attrs \\ %{}) do
      {:ok, file} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Audio.create_file()

      file
    end

    test "list_files/0 returns all files" do
      file = file_fixture()
      assert Audio.list_files() == [file]
    end

    test "get_file!/1 returns the file with given id" do
      file = file_fixture()
      assert Audio.get_file!(file.id) == file
    end

    test "create_file/1 with valid data creates a file" do
      assert {:ok, %File{} = file} = Audio.create_file(@valid_attrs)
      assert file.duration == 42
      assert file.url == "some url"
    end

    test "create_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Audio.create_file(@invalid_attrs)
    end

    test "update_file/2 with valid data updates the file" do
      file = file_fixture()
      assert {:ok, %File{} = file} = Audio.update_file(file, @update_attrs)
      assert file.duration == 43
      assert file.url == "some updated url"
    end

    test "update_file/2 with invalid data returns error changeset" do
      file = file_fixture()
      assert {:error, %Ecto.Changeset{}} = Audio.update_file(file, @invalid_attrs)
      assert file == Audio.get_file!(file.id)
    end

    test "delete_file/1 deletes the file" do
      file = file_fixture()
      assert {:ok, %File{}} = Audio.delete_file(file)
      assert_raise Ecto.NoResultsError, fn -> Audio.get_file!(file.id) end
    end

    test "change_file/1 returns a file changeset" do
      file = file_fixture()
      assert %Ecto.Changeset{} = Audio.change_file(file)
    end
  end
end
