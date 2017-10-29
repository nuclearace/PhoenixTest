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
    |> LoginAPIController.Plug.remember_me(user, %{"typ" => "access"}, key: "memes")
    |> redirect(to: "/")
    |> halt()
  end

  def subject_for_token(%User{id: id} = _resource, _claims) do
    {:ok, "User:" <> to_string(id)}
  end

  def resource_from_claims(%{"sub" => "User:" <> id}) do
    {:ok, user = Accounts.get_user!(Integer.parse(id))}
  end

  def on_verify(_claims) do
    IO.puts "doing verify"
  end
end
