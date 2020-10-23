defmodule AppTestWeb.WorkingtimesController do
  use AppTestWeb, :controller

  alias AppTest.Data
  alias AppTest.Data.Workingtimes
  alias AppTest.Repo
  alias AppTest.Data.Users
  action_fallback AppTestWeb.FallbackController

  def index(conn, _params) do
    startDate = _params["start"]
    endDate = _params["end"]
    user = _params["usersId"]
    working_times = Data.get_all_workingtimes_by_user!(user, startDate, endDate)
    render(conn, "index.json", workingtimes: working_times)
  end

  def create(conn, %{"workingtimes" => workingtimes_params, "usersId" => usersId}) do
    user = Repo.get(Users, usersId)
    endDate = NaiveDateTime.from_iso8601!(workingtimes_params["end"])
    startDate = NaiveDateTime.from_iso8601!(workingtimes_params["start"])
    working_time_changeset = Ecto.build_assoc(user, :workingtimes, %{end: endDate, start: startDate })
    Repo.insert(working_time_changeset)

      #conn
      #|> put_status(:created)
      #|> redirect(to: Routes.users_path(conn, :show, user))
    conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtimes_path(conn, :show, working_time_changeset))
      |> render("show.json", workingtimes: working_time_changeset)
  end

  def show(conn, %{"usersId" => usersId, "id" => id}) do
    working_times = Data.get_one_workingtimes_by_user!(usersId, id)
    render(conn, "show.json", workingtimes: working_times)
  end

  #def show(conn, %{"id" => id}) do
    #workingtimes = Data.get_workingtimes!(id)
   # render(conn, "show.json", workingtimes: workingtimes)
  #end

  def update(conn, %{"id" => id, "workingtimes" => workingtimes_params}) do
    workingtimes = Data.get_workingtimes!(id)

    with {:ok, %Workingtimes{} = workingtimes} <- Data.update_workingtimes(workingtimes, workingtimes_params) do
      render(conn, "show.json", workingtimes: workingtimes)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtimes = Data.get_workingtimes!(id)

    with {:ok, %Workingtimes{}} <- Data.delete_workingtimes(workingtimes) do
      send_resp(conn, :no_content, "")
    end
  end
end
