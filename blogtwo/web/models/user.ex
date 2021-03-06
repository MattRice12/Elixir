defmodule Blogtwo.User do
  use Blogtwo.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :posts, Blogtwo.Post

    timestamps()
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password_hash])
    |> validate_required([:email, :password_hash])
  end
end
