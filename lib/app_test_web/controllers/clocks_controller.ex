defmodule AppTestWeb.ClocksController do
  use AppTestWeb, :controller

  alias AppTest.Data
  alias AppTest.Data.Clocks

  action_fallback AppTestWeb.FallbackController

  def index(conn, _params) do
    clocks = Data.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clocks" => clocks_params}) do
    with {:ok, %Clocks{} = clocks} <- Data.create_clocks(clocks_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
      |> render("show.json", clocks: clocks)
    end
  end

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
