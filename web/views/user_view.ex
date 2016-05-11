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
      login: user.login,
      password_hash: user.password_hash}
  end
end
