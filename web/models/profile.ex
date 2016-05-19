defmodule Bracco.Profile do
  use Bracco.Web, :model

  schema "profiles" do
    field :description, :string

    timestamps
  end
end
