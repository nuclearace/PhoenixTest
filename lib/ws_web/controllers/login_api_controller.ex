defmodule WsWeb.LoginAPIController do
  use WsWeb, :controller
  use Guardian, otp_app: :ws

  alias Ws.Accounts
  alias Ws.Accounts.User
  alias WsWeb.LoginAPIController

  action_fallback WsWeb.FallbackController

  def create(conn, %{"user" => %{"password" => pw, "username" => user}}) do
    case Accounts.get_user(user, pw) do
      {:ok, %User{} = user} -> authenticate_user(conn, user)
      {:error, reason} -> html conn, reason
    end
  end

  defp authenticate_user(conn, user) do
    conn
    |> LoginAPIController.Plug.sign_in(user)
    |> redirect(to: "/")
    |> halt()
  end

  def subject_for_token(%User{} = resource, _claims) do
    {:ok, to_string(resource.username)}
  end

  def resource_from_claims(claims) do
    IO.puts to_string(claims)
  end
end
