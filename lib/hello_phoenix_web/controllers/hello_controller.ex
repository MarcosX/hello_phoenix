defmodule HelloPhoenixWeb.HelloController do
  use HelloPhoenixWeb, :controller

  plug :assign_messenger, "Here"

  def index(conn, _params) do
    conn
    |> render("show.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    conn
    |> assign(:messenger, messenger)
    |> render("show.html")
  end

  defp assign_messenger(conn, msg) do
    assign(conn, :messenger, msg)
  end
end
