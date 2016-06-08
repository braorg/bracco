defmodule Bracco.Repo do
  use Ecto.Repo, otp_app: :bracco
  use Scrivener, page_size: 5
end
