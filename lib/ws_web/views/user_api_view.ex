defmodule WsWeb.UserAPIView do
  use WsWeb, :view
  alias WsWeb.UserAPIView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserAPIView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserAPIView, "user.json")}
  end

  def render("user.json", %{user_api: user}) do
    %{id: user.id,
      firstname: user.firstname,
      lastname: user.lastname,
      username: user.username}
  end
end
