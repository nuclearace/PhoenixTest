defmodule WsWeb.LoginAPIController do
  use WsWeb, :controller

  alias Ws.Accounts

  action_fallback WsWeb.FallbackController

  def create(conn, %{"user" => %{"password" => pw, "username" => user}}) do
    if Accounts.valid_password!(user, pw) do
      conn
      |> redirect(to: "/")
      |> halt()
    else
      html conn, "bad"
    end
  end
end
