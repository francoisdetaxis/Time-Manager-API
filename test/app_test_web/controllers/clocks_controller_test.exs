defmodule AppTestWeb.ClocksControllerTest do
  use AppTestWeb.ConnCase

  alias AppTest.Data
  alias AppTest.Data.Clocks

  @create_attrs %{
    status: "some status",
    time: "some time"
  }
  @update_attrs %{
    status: "some updated status",
    time: "some updated time"
  }
  @invalid_attrs %{status: nil, time: nil}

  def fixture(:clocks) do
    {:ok, clocks} = Data.create_clocks(@create_attrs)
    clocks
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all clocks", %{conn: conn} do
      conn = get(conn, Routes.clocks_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create clocks" do
    test "renders clocks when data is valid", %{conn: conn} do
      conn = post(conn, Routes.clocks_path(conn, :create), clocks: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.clocks_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => "some status",
               "time" => "some time"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.clocks_path(conn, :create), clocks: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update clocks" do
    setup [:create_clocks]

    test "renders clocks when data is valid", %{conn: conn, clocks: %Clocks{id: id} = clocks} do
      conn = put(conn, Routes.clocks_path(conn, :update, clocks), clocks: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.clocks_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => "some updated status",
               "time" => "some updated time"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, clocks: clocks} do
      conn = put(conn, Routes.clocks_path(conn, :update, clocks), clocks: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete clocks" do
    setup [:create_clocks]

    test "deletes chosen clocks", %{conn: conn, clocks: clocks} do
      conn = delete(conn, Routes.clocks_path(conn, :delete, clocks))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.clocks_path(conn, :show, clocks))
      end
    end
  end

  defp create_clocks(_) do
    clocks = fixture(:clocks)
    %{clocks: clocks}
  end
end
