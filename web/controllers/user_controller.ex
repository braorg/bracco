defmodule Bracco.UserController do
  use Bracco.Web, :controller

  import Ecto.Query
  import Bracco.Gettext

  alias Bracco.User

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, params) do
    page = case params do
      %{"archived" => archived} ->
        User
        |> where([u], u.archived == ^archived)
        |> Repo.paginate(params)
      _ ->
        Repo.paginate(User, params)
    end

    render(conn, "index.json", page: page)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Bracco.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      user = Repo.get!(User, id)
      render(conn, "show.json", user: user)
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(404)
        |> render(Bracco.ChangesetView, "error.json", message: dgettext("errors", "Record not found"))
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    try do
      user = Repo.get!(User, id)
      changeset = User.changeset(user, user_params)

      case Repo.update(changeset) do
        {:ok, user} ->
          render(conn, "show.json", user: user)
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(Bracco.ChangesetView, "error.json", changeset: changeset)
      end
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(404)
        |> render(Bracco.ChangesetView, "error.json", message: dgettext("errors", "Record not found"))
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      user = Repo.get!(User, id)

      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(user)

      send_resp(conn, :no_content, "")
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(404)
        |> render(Bracco.ChangesetView, "error.json", message: dgettext("errors", "Record not found"))
    end
  end
end
