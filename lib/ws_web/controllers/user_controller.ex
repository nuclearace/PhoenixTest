defmodule WsWeb.UserController do
  use WsWeb, :controller

  alias Ws.Accounts
  alias Ws.Accounts.User

  action_fallback WsWeb.FallbackController

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render conn, "new.html", changeset: changeset
  end
end
