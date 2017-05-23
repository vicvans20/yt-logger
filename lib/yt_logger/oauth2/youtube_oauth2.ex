defmodule YoutubeOauth2 do
    @moduledoc """
  An OAuth2 strategy for Youtube Google.
  """
  use OAuth2.Strategy
  alias OAuth2.Strategy.AuthCode

  defp config do
    [
     strategy: OAuth2.Strategy.AuthCode,
     site: "https://accounts.google.com",
     authorize_url: "/o/oauth2/auth",
     token_url: "/o/oauth2/token"
   ]
  end

  # Public API

  def client do
    Application.get_env(:oauth2, Google)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def authorize_url!(_params \\ []) do
    OAuth2.Client.authorize_url!(client(), scope: "https://www.googleapis.com/auth/youtube.readonly")
  end

  def get_token!(params \\ [], _headers \\ []) do
    c = client()
    client_secret = c.client_secret
    params = Keyword.put(params, :client_secret, client_secret)
    OAuth2.Client.get_token!(c, params)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end


defmodule Google do
  @moduledoc """
  An OAuth2 strategy for Google.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
    [strategy: Google,
     site: "https://accounts.google.com",
     authorize_url: "/o/oauth2/auth",
     token_url: "/o/oauth2/token"]
  end

  # Public API

  def client do
    Application.get_env(:oauth2_example, Google)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(client(), params)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
