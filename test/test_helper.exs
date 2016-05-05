ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Bracco.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Bracco.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Bracco.Repo)

