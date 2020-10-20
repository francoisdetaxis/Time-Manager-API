defmodule AppTestWeb.UsersController do
  use AppTestWeb, :controller

  alias AppTest.Data
  alias AppTest.Data.Users

  action_fallback AppTestWeb.FallbackController

#  def index(conn, _params) do
#    users = Data.list_users()
#    render(conn, "index.json", users: users)
#  end


  def index(conn, params) do
    users = Data.get_users_by_username!(params)
    render(conn, "show.json", users: users)
  end

  def create(conn, %{"users" => users_params}) do
    with {:ok, %Users{} = users} <- Data.create_users(users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.users_path(conn, :show, users))
      |> render("show.json", users: users)
    end
  end

#  def show(conn, %{"email" => email, "username" => username}) do
#    users = Data.get_users_by_username!(email, username)
#    render(conn, "show.json", users: users)
#  end

  def show(conn, %{"id" => id}) do
    users = Data.get_users!(id)
    render(conn, "show.json", users: users)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Data.get_users!(id)

    with {:ok, %Users{} = users} <- Data.update_users(users, users_params) do
      render(conn, "show.json", users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Data.get_users!(id)

    with {:ok, %Users{}} <- Data.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end
end
