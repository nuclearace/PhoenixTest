defmodule WsWeb.RoomChannel do
  use Phoenix.Channel
  alias WsWeb.Presence

  @filtered_words ~r/bovine|cow|cuck|dog/i

  def join("room:lobby", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: filter_message(body)}
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
        online_at: inspect(System.system_time(:seconds))
    })
    {:noreply, socket}
  end

  defp filter_message(msg) do
    Regex.replace @filtered_words, msg, "{Redacted}"
  end
end
