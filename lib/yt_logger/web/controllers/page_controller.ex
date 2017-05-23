defmodule YtLogger.Web.PageController do
  use YtLogger.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def history(conn, _params) do
    # CHECK IF WE HAVE A VALID CLIENT IF NOT CREATE AUTH URL AND REDIRECT
    # ex. redirect conn, external: authorize_url!(provider)
    render conn, "history.html", oauth2_url: YoutubeOauth2.authorize_url!()
  end

  def yt_oauth(conn, params) do
    IO.inspect params
    code = Map.get(params, "code")

    # Exchange an auth code for an access token
    # client = get_token!(provider, code)

    # Request the user's data with the access token
    # user = get_user!(provider, client)

    render conn, "history.html", code: code
  end
end