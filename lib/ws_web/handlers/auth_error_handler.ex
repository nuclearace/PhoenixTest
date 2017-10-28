defmodule WsWeb.AuthErrorHandler do
  use WsWeb, :controller
  alias WsWeb.AuthErrorHandler

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> redirect(to: "/users/login")
    |> halt()
  end
end
