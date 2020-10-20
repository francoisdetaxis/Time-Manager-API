defmodule AppTestWeb.WorkingtimesControllerTest do
  use AppTestWeb.ConnCase

  alias AppTest.Data
  alias AppTest.Data.Workingtimes

  @create_attrs %{
    end: ~N[2010-04-17 14:00:00],
    start: ~N[2010-04-17 14:00:00]
  }
  @update_attrs %{
    end: ~N[2011-05-18 15:01:01],
    start: ~N[2011-05-18 15:01:01]
  }
  @invalid_attrs %{end: nil, start: nil}

  def fixture(:workingtimes) do
    {:ok, workingtimes} = Data.create_workingtimes(@create_attrs)
    workingtimes
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all workingtimes", %{conn: conn} do
      conn = get(conn, Routes.workingtimes_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create workingtimes" do
    test "renders workingtimes when data is valid", %{conn: conn} do
      conn = post(conn, Routes.workingtimes_path(conn, :create), workingtimes: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.workingtimes_path(conn, :show, id))

      assert %{
               "id" => id,
               "end" => "2010-04-17T14:00:00",
               "start" => "2010-04-17T14:00:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.workingtimes_path(conn, :create), workingtimes: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update workingtimes" do
    setup [:create_workingtimes]

    test "renders workingtimes when data is valid", %{conn: conn, workingtimes: %Workingtimes{id: id} = workingtimes} do
      conn = put(conn, Routes.workingtimes_path(conn, :update, workingtimes), workingtimes: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.workingtimes_path(conn, :show, id))

      assert %{
               "id" => id,
               "end" => "2011-05-18T15:01:01",
               "start" => "2011-05-18T15:01:01"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, workingtimes: workingtimes} do
      conn = put(conn, Routes.workingtimes_path(conn, :update, workingtimes), workingtimes: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete workingtimes" do
    setup [:create_workingtimes]

    test "deletes chosen workingtimes", %{conn: conn, workingtimes: workingtimes} do
      conn = delete(conn, Routes.workingtimes_path(conn, :delete, workingtimes))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.workingtimes_path(conn, :show, workingtimes))
      end
    end
  end

  defp create_workingtimes(_) do
    workingtimes = fixture(:workingtimes)
    %{workingtimes: workingtimes}
  end
end
