defmodule HelloPhoenixWeb.PageView do
  use HelloPhoenixWeb, :view

  def render("show.json", %{page: page}) do
    %{data: render_one(page, HelloPhoenixWeb.PageView, "page.json")}
  end

  def render("page.json", %{page: page}) do
    %{title: page.title}
  end

  def message do
    "Hello from the view!"
  end

  def handler_info(conn) do
    "Request handled by: #{controller_module conn}.#{action_name conn}"
  end

  def connection_keys(conn) do
    conn
    |> Map.from_struct()
    |> Map.keys()
  end
end
