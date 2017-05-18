defmodule YtLogger.Web.PageController do
  use YtLogger.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def history(conn, _params) do
    render conn, "history.html"
  end
end
