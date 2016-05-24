defmodule Bracco.UserView do
  use Bracco.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Bracco.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Bracco.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      avatar_url: user.avatar_url,
      username: user.username,
      archived: user.archived,
      profile_id: user.profile_id}
  end
end
