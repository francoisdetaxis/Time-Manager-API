defmodule AppTest.DataTest do
  use AppTest.DataCase

  alias AppTest.Data

  describe "users" do
    alias AppTest.Data.Users

    @valid_attrs %{"\"": "some \""}
    @update_attrs %{"\"": "some updated \""}
    @invalid_attrs %{"\"": nil}

    def users_fixture(attrs \\ %{}) do
      {:ok, users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_users()

      users
    end

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Data.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Data.get_users!(users.id) == users
    end

#    test "create_users/1 with valid data creates a users" do
#      assert {:ok, %Users{} = users} = Data.create_users(@valid_attrs)
##      assert users." == "some \""
#      assert users." == "some \""
#    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_users(@invalid_attrs)
    end

#    test "update_users/2 with valid data updates the users" do
#      users = users_fixture()
#      assert {:ok, %Users{} = users} = Data.update_users(users, @update_attrs)
##      assert users." == "some updated \""
#      assert users." == "some updated \""
#    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_users(users, @invalid_attrs)
      assert users == Data.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Data.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Data.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Data.change_users(users)
    end
  end

  describe "users" do
    alias AppTest.Data.Users

    @valid_attrs %{email: "some email", username: "some username"}
    @update_attrs %{email: "some updated email", username: "some updated username"}
    @invalid_attrs %{email: nil, username: nil}

    def users_fixture(attrs \\ %{}) do
      {:ok, users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_users()

      users
    end

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Data.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Data.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      assert {:ok, %Users{} = users} = Data.create_users(@valid_attrs)
      assert users.email == "some email"
      assert users.username == "some username"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      assert {:ok, %Users{} = users} = Data.update_users(users, @update_attrs)
      assert users.email == "some updated email"
      assert users.username == "some updated username"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_users(users, @invalid_attrs)
      assert users == Data.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Data.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Data.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Data.change_users(users)
    end
  end

  describe "clocks" do
    alias AppTest.Data.Clocks

    @valid_attrs %{status: "some status", time: "some time", user: "some user"}
    @update_attrs %{status: "some updated status", time: "some updated time", user: "some updated user"}
    @invalid_attrs %{status: nil, time: nil, user: nil}

    def clocks_fixture(attrs \\ %{}) do
      {:ok, clocks} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_clocks()

      clocks
    end

    test "list_clocks/0 returns all clocks" do
      clocks = clocks_fixture()
      assert Data.list_clocks() == [clocks]
    end

    test "get_clocks!/1 returns the clocks with given id" do
      clocks = clocks_fixture()
      assert Data.get_clocks!(clocks.id) == clocks
    end

    test "create_clocks/1 with valid data creates a clocks" do
      assert {:ok, %Clocks{} = clocks} = Data.create_clocks(@valid_attrs)
      assert clocks.status == "some status"
      assert clocks.time == "some time"
      assert clocks.user == "some user"
    end

    test "create_clocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_clocks(@invalid_attrs)
    end

    test "update_clocks/2 with valid data updates the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{} = clocks} = Data.update_clocks(clocks, @update_attrs)
      assert clocks.status == "some updated status"
      assert clocks.time == "some updated time"
      assert clocks.user == "some updated user"
    end

    test "update_clocks/2 with invalid data returns error changeset" do
      clocks = clocks_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_clocks(clocks, @invalid_attrs)
      assert clocks == Data.get_clocks!(clocks.id)
    end

    test "delete_clocks/1 deletes the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{}} = Data.delete_clocks(clocks)
      assert_raise Ecto.NoResultsError, fn -> Data.get_clocks!(clocks.id) end
    end

    test "change_clocks/1 returns a clocks changeset" do
      clocks = clocks_fixture()
      assert %Ecto.Changeset{} = Data.change_clocks(clocks)
    end
  end

  describe "workingtimes" do
    alias AppTest.Data.Workingtimes

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00], user: "some user"}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01], user: "some updated user"}
    @invalid_attrs %{end: nil, start: nil, user: nil}

    def workingtimes_fixture(attrs \\ %{}) do
      {:ok, workingtimes} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_workingtimes()

      workingtimes
    end

    test "list_workingtimes/0 returns all workingtimes" do
      workingtimes = workingtimes_fixture()
      assert Data.list_workingtimes() == [workingtimes]
    end

    test "get_workingtimes!/1 returns the workingtimes with given id" do
      workingtimes = workingtimes_fixture()
      assert Data.get_workingtimes!(workingtimes.id) == workingtimes
    end

    test "create_workingtimes/1 with valid data creates a workingtimes" do
      assert {:ok, %Workingtimes{} = workingtimes} = Data.create_workingtimes(@valid_attrs)
      assert workingtimes.end == ~N[2010-04-17 14:00:00]
      assert workingtimes.start == ~N[2010-04-17 14:00:00]
      assert workingtimes.user == "some user"
    end

    test "create_workingtimes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_workingtimes(@invalid_attrs)
    end

    test "update_workingtimes/2 with valid data updates the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{} = workingtimes} = Data.update_workingtimes(workingtimes, @update_attrs)
      assert workingtimes.end == ~N[2011-05-18 15:01:01]
      assert workingtimes.start == ~N[2011-05-18 15:01:01]
      assert workingtimes.user == "some updated user"
    end

    test "update_workingtimes/2 with invalid data returns error changeset" do
      workingtimes = workingtimes_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_workingtimes(workingtimes, @invalid_attrs)
      assert workingtimes == Data.get_workingtimes!(workingtimes.id)
    end

    test "delete_workingtimes/1 deletes the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{}} = Data.delete_workingtimes(workingtimes)
      assert_raise Ecto.NoResultsError, fn -> Data.get_workingtimes!(workingtimes.id) end
    end

    test "change_workingtimes/1 returns a workingtimes changeset" do
      workingtimes = workingtimes_fixture()
      assert %Ecto.Changeset{} = Data.change_workingtimes(workingtimes)
    end
  end

  describe "clocks" do
    alias AppTest.Data.Clocks

    @valid_attrs %{status: "some status", time: "some time"}
    @update_attrs %{status: "some updated status", time: "some updated time"}
    @invalid_attrs %{status: nil, time: nil}

    def clocks_fixture(attrs \\ %{}) do
      {:ok, clocks} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_clocks()

      clocks
    end

    test "list_clocks/0 returns all clocks" do
      clocks = clocks_fixture()
      assert Data.list_clocks() == [clocks]
    end

    test "get_clocks!/1 returns the clocks with given id" do
      clocks = clocks_fixture()
      assert Data.get_clocks!(clocks.id) == clocks
    end

    test "create_clocks/1 with valid data creates a clocks" do
      assert {:ok, %Clocks{} = clocks} = Data.create_clocks(@valid_attrs)
      assert clocks.status == "some status"
      assert clocks.time == "some time"
    end

    test "create_clocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_clocks(@invalid_attrs)
    end

    test "update_clocks/2 with valid data updates the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{} = clocks} = Data.update_clocks(clocks, @update_attrs)
      assert clocks.status == "some updated status"
      assert clocks.time == "some updated time"
    end

    test "update_clocks/2 with invalid data returns error changeset" do
      clocks = clocks_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_clocks(clocks, @invalid_attrs)
      assert clocks == Data.get_clocks!(clocks.id)
    end

    test "delete_clocks/1 deletes the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{}} = Data.delete_clocks(clocks)
      assert_raise Ecto.NoResultsError, fn -> Data.get_clocks!(clocks.id) end
    end

    test "change_clocks/1 returns a clocks changeset" do
      clocks = clocks_fixture()
      assert %Ecto.Changeset{} = Data.change_clocks(clocks)
    end
  end

  describe "workingtimes" do
    alias AppTest.Data.Workingtimes

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{end: nil, start: nil}

    def workingtimes_fixture(attrs \\ %{}) do
      {:ok, workingtimes} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_workingtimes()

      workingtimes
    end

    test "list_workingtimes/0 returns all workingtimes" do
      workingtimes = workingtimes_fixture()
      assert Data.list_workingtimes() == [workingtimes]
    end

    test "get_workingtimes!/1 returns the workingtimes with given id" do
      workingtimes = workingtimes_fixture()
      assert Data.get_workingtimes!(workingtimes.id) == workingtimes
    end

    test "create_workingtimes/1 with valid data creates a workingtimes" do
      assert {:ok, %Workingtimes{} = workingtimes} = Data.create_workingtimes(@valid_attrs)
      assert workingtimes.end == ~N[2010-04-17 14:00:00]
      assert workingtimes.start == ~N[2010-04-17 14:00:00]
    end

    test "create_workingtimes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_workingtimes(@invalid_attrs)
    end

    test "update_workingtimes/2 with valid data updates the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{} = workingtimes} = Data.update_workingtimes(workingtimes, @update_attrs)
      assert workingtimes.end == ~N[2011-05-18 15:01:01]
      assert workingtimes.start == ~N[2011-05-18 15:01:01]
    end

    test "update_workingtimes/2 with invalid data returns error changeset" do
      workingtimes = workingtimes_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_workingtimes(workingtimes, @invalid_attrs)
      assert workingtimes == Data.get_workingtimes!(workingtimes.id)
    end

    test "delete_workingtimes/1 deletes the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{}} = Data.delete_workingtimes(workingtimes)
      assert_raise Ecto.NoResultsError, fn -> Data.get_workingtimes!(workingtimes.id) end
    end

    test "change_workingtimes/1 returns a workingtimes changeset" do
      workingtimes = workingtimes_fixture()
      assert %Ecto.Changeset{} = Data.change_workingtimes(workingtimes)
    end
  end
end
