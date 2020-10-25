defmodule AppTestWeb.ClocksView do
  use AppTestWeb, :view
  alias AppTestWeb.ClocksView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClocksView, "clocks.json")}
  end

  def render("show.json", %{clocks: clocks}) do
    IO.puts "#################################clocks INSIDE RENDER HIGH#####################################"
    IO.inspect(clocks)
    IO.puts "######################################################################"
    %{data: render_one(clocks, ClocksView, "clocks.json")}
  end

  def render("clocks.json", %{clocks: clocks}) do
    IO.puts "#################################clocks INSIDE RENDER LOW#####################################"
    IO.inspect(clocks)
    IO.puts "######################################################################"
    %{id: clocks.id,
      time: clocks.time,
      status: clocks.status}
  end
end
