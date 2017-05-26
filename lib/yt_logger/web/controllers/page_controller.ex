defmodule YtLogger.Web.PageController do
  use YtLogger.Web, :controller

  alias YtLogger.Account
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
    # Get code from redirect
    code = Map.get(params, "code")
    # Request token with code
    {:ok, token} = Account.request_token(code)
    
    # Get current user data and update token field
    user = Coherence.current_user(conn)
    {:ok, new_user} = Account.update_user(user ,%{g_access_token: token})
    # APPLY CHANGES TO Coherence current session!
    apply(Coherence.Config.auth_module, Coherence.Config.update_login, [conn, new_user, [id_key: Coherence.Config.schema_key]])
    # Request the user's data with the access token
    # user = get_user!(provider, client)
    redirect(conn, to: "/logger", code: code )
  end
end