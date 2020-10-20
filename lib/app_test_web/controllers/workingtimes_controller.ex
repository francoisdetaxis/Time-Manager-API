defmodule AppTestWeb.WorkingtimesController do
  use AppTestWeb, :controller

  alias AppTest.Data
  alias AppTest.Data.Workingtimes

  action_fallback AppTestWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Data.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtimes" => workingtimes_params}) do
    IO.inspect(workingtimes_params)
    with {:ok, %Workingtimes{} = workingtimes} <- Data.create_workingtimes(workingtimes_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtimes_path(conn, :show, workingtimes))
      |> render("show.json", workingtimes: workingtimes)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtimes = Data.get_workingtimes!(id)
    render(conn, "show.json", workingtimes: workingtimes)
  end

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
