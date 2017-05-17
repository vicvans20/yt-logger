defmodule YtLogger.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use YtLogger.Web, :controller
      use YtLogger.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: YtLogger.Web
      import Plug.Conn
      import YtLogger.Web.Router.Helpers
      import YtLogger.Web.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/yt_logger/web/templates",
                        namespace: YtLogger.Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import YtLogger.Web.Router.Helpers
      import YtLogger.Web.ErrorHelpers
      import YtLogger.Web.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import YtLogger.Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
