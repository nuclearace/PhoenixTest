defmodule WsWeb.LoginAPIController do
  use WsWeb, :controller

  alias Ws.Accounts
  alias Ws.Accounts.User
  alias WsWeb.Guardian

  action_fallback WsWeb.FallbackController

  def create(conn, %{"user" => %{"password" => pw, "username" => user}}) do
    case Accounts.get_user(user, pw) do
      {:ok, %User{} = user} -> authenticate_user(conn, user)
      {:error, reason} -> html conn, reason
    end
  end

  defp authenticate_user(conn, user) do
    conn
    |> Guardian.Plug.remember_me(user, %{}, key: "guardian_memes_token")
    |> redirect(to: "/")
    |> halt()
  end
end
