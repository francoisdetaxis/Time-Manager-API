defmodule AppTestWeb.ClocksController do
  use AppTestWeb, :controller

  alias AppTest.Data
  alias AppTest.Data.Clocks
  alias AppTest.Repo
  alias AppTest.Data.Users

  action_fallback AppTestWeb.FallbackController

  def index(conn, _params) do
    clocks = Data.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clocks" => clocks_params, "usersId" => usersId}) do
    user = Repo.get(Users, usersId)
    timeclock = NaiveDateTime.from_iso8601!(clocks_params["time"])
    statusclock = clocks_params["status"]
    clock_changeset = Ecto.build_assoc(user, :clocks, %{time: timeclock, status: statusclock })
    {:ok, %Clocks{} = clockss} = Repo.insert(clock_changeset)

    conn
    |> put_status(:created)
      #|> put_resp_header("location", Routes.workingtimes_path(conn, :show, working_time_changeset))
    |> render("show.json", clocks: clockss)
  end

  #def show(conn, %{"usersId" => usersId}) do
  #clock_times = Data.get_all_clock_by_user!(usersId)
  # render(conn, "show.json", clocks: clock_times)
  #end

  def show(conn, %{"id" => usersId}) do
    clocks = Data.get_clocks_by_user(usersId)
    render(conn, "index.json", clocks: clocks)
  end

end
