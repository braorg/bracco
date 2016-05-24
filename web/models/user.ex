defmodule Bracco.User do
  use Bracco.Web, :model

  schema "users" do
    field :first_name, :string, size: 50
    field :last_name, :string, size: 50
    field :email, :string, size: 50
    field :avatar_url, :string, size: 100
    field :username, :string, size: 50
    field :password, :string, virtual: true
    field :password_hash, :string
    field :archived, :boolean, default: false
    belongs_to :profile, Bracco.Profile

    timestamps
  end

  @required_fields ~w(first_name last_name username password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
