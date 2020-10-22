defmodule AppTestWeb.ClocksController do
  use AppTestWeb, :controller

  alias AppTest.Data
  alias AppTest.Data.Clocks
  alias AppTest.Repo
  alias AppTest.Data.Users

  action_fallback AppTestWeb.FallbackController

  def index(conn, _params) do
    usersId = _params["usersId"]
    clocks = Data.get_all_clock_by_user!(usersId)
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clocks" => clocks_params, "usersId" => usersId}) do
    user = Repo.get(Users, usersId)
    timeclock = NaiveDateTime.from_iso8601!(clocks_params["time"])
    statusclock = clocks_params["status"]
    clock_changeset = Ecto.build_assoc(user, :clocks, %{time: timeclock, status: statusclock })
    Repo.insert(clock_changeset)

    conn
    |> put_status(:created)
    #|> redirect(to: Routes.users_path(conn, :show, user))
    #conn
    #|> put_status(:created)
    #|> put_resp_header("location", Routes.workingtimes_path(conn, :show, workingtimes_params))
    |> render("show.json", clocks: clock_changeset)
  end

  #def create(conn, %{"usersId" => usersId} ,%{"clocks" => clocks_params}) do
    #with {:ok, %Clocks{} = clocks} <- Data.create_clocks(usersId, clocks_params) do
      #conn
      #|> put_status(:created)
      #|> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
      #|> render("show.json", clocks: clocks)
    #end
  #end

  #def show(conn, %{"usersId" => usersId}) do
    #clock_times = Data.get_all_clock_by_user!(usersId)
   # render(conn, "show.json", clocks: clock_times)
  #end

  def show(conn, %{"id" => id}) do
    clocks = Data.get_clocks!(id)
    render(conn, "show.json", clocks: clocks)
  end

  def update(conn, %{"id" => id, "clocks" => clocks_params}) do
    clocks = Data.get_clocks!(id)

    with {:ok, %Clocks{} = clocks} <- Data.update_clocks(clocks, clocks_params) do
      render(conn, "show.json", clocks: clocks)
    end
  end

  def delete(conn, %{"id" => id}) do
    clocks = Data.get_clocks!(id)

    with {:ok, %Clocks{}} <- Data.delete_clocks(clocks) do
      send_resp(conn, :no_content, "")
    end
  end
end
