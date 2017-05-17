defmodule YtLogger.Web.PageController do
  use YtLogger.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
