defmodule MantratronApi.AccountsTest do
  use MantratronApi.DataCase

  alias MantratronApi.Accounts

  describe "users" do
    alias MantratronApi.Accounts.User

    @valid_attrs %{
      email: "some email",
      password: "some password",
      password_reset_token: "some password_reset_token",
      username: "some username",
      verified: true
    }
    @update_attrs %{
      email: "some updated email",
      password: "some updated password",
      password_reset_token: "some updated password_reset_token",
      username: "some updated username",
      verified: false
    }
    @invalid_attrs %{
      email: nil,
      password: nil,
      password_reset_token: nil,
      username: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      [first] = Accounts.list_users()
      assert first.username == user.username
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      found = Accounts.get_user!(user.id)
      assert found.username == user.username
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      refute user.password_hash == @valid_attrs.password
      assert user.password_reset_token == "some password_reset_token"
      assert user.username == "some username"
      assert user.verified == true
      refute is_nil(user.verify_token)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      refute user.password_hash == @valid_attrs.password
      assert user.password_reset_token == "some updated password_reset_token"
      assert user.username == "some updated username"
      assert user.verified == false
      refute is_nil(user.verify_token)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      found = Accounts.get_user!(user.id)

      assert found.email == "some email"
      refute found.password_hash == @valid_attrs.password
      assert found.password_reset_token == "some password_reset_token"
      assert found.username == "some username"
      assert found.verified == true
      refute is_nil(found.verify_token)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
