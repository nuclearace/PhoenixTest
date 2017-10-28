defmodule Ws.Accounts.User do
  require Logger

  use Ecto.Schema

  import Ecto.Changeset

  alias Ws.Accounts.User
  alias Comeonin.Bcrypt


  schema "users" do
    field :firstname, :string
    field :lastname, :string
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def update_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :username])
    |> validate_required([:firstname, :lastname, :username])
    |> unique_constraint(:username)
  end

  def changeset(%User{} = user, %{"password" => pw} = attrs) when pw != "" do
    attrs = %{attrs | "password" => Bcrypt.hashpwsalt(pw)}

    user
    |> cast(attrs, [:firstname, :lastname, :username, :password])
    |> validate_required([:firstname, :lastname, :username, :password])
    |> unique_constraint(:username)
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :username, :password])
    |> validate_required([:firstname, :lastname, :username, :password])
    |> unique_constraint(:username)
  end
end
