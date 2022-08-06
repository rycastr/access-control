defmodule AccessControlWeb.PageController do
  use AccessControlWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
