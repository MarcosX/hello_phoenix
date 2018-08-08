defmodule HelloPhoenixWeb.PageController do
  use HelloPhoenixWeb, :controller

  def index(conn, %{"redirect" => "true"}) do
    redirect conn, to: hello_path(conn, :index)
  end

  def index(conn, params) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> put_flash(:error,  "Err")
    |> render(:index, params: URI.encode_query(params))
  end

  def show(conn, _params) do
    page = %{title: "A Title"}

    render conn, "show.json", page: page
  end

  def test(conn, _params) do
    render conn, "test.html"
  end
end
