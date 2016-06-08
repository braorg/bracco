# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bracco.Repo.insert!(%Bracco.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Integer

File.mkdir_p!("priv/static/avatars")

# Mix.Task.run "ecto.drop", ~w(-r Bracco.Repo --quiet)
# Mix.Task.run "ecto.create", ~w(-r Bracco.Repo --quiet)
# Mix.Task.run "ecto.migrate", ~w(-r Bracco.Repo --quiet)

# %Profiles{}
alias Bracco.Profile
Bracco.Repo.insert!(%Profile{description: "Admin"})
Bracco.Repo.insert!(%Profile{description: "Guest"})

# %User{}
alias Bracco.User
user_name = Faker.Internet.user_name
image_url_admin =
  Faker.Avatar.image_url
  |> Bracco.AvatarMgr.convert_to_local_path

Bracco.Repo.insert!(
  %User{
    first_name: Faker.Name.first_name,
    last_name: Faker.Name.last_name,
    email: Faker.Internet.email,
    avatar_url: image_url_admin,
    archived: false,
    username: user_name,
    password_hash: Comeonin.Bcrypt.hashpwsalt(user_name),
    profile_id: 1
  }
)

Enum.each((1..20), fn(_) ->
  user_name = Faker.Internet.user_name
  image_url =
    Faker.Avatar.image_url
    |> Bracco.AvatarMgr.convert_to_local_path

  Bracco.Repo.insert!(
    %User{
      first_name: Faker.Name.first_name,
      last_name: Faker.Name.last_name,
      email: Faker.Internet.email,
      avatar_url: image_url,
      archived: Integer.is_even(:random.uniform(5)),
      username: user_name,
      password_hash: Comeonin.Bcrypt.hashpwsalt(user_name),
      profile_id: 2
    }
  )
end)

# %Note{}
alias Bracco.Note
Enum.each((1..100), fn(_) ->
  Bracco.Repo.insert!(
    %Note{
      title: Faker.Lorem.sentence(1..5),
      description: Faker.Lorem.paragraph(1..10),
      user_id: :random.uniform(10)
    }
  )
end)
