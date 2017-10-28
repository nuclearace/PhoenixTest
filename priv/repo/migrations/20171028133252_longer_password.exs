defmodule Ws.Repo.Migrations.LongerPassword do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :password, :string, size: 1024
    end
  end
end
