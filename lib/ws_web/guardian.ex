defmodule WsWeb.Guardian do
  use Guardian, otp_app: :ws

  alias Ws.Accounts
  alias Ws.Accounts.User

  def subject_for_token(%User{id: id} = _resource, _claims) do
    {:ok, "User:" <> to_string(id)}
  end

  def resource_from_claims(%{"sub" => "User:" <> id}) do
    {:ok, Accounts.get_user!(id)}
  end

end
