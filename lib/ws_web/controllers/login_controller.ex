defmodule WsWeb.LoginController do
  use WsWeb, :controller

  alias Ws.Accounts
  alias Ws.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render conn, "login.html", changeset: changeset
  end
end
