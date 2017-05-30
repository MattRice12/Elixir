defmodule Blogtwo.Post do
  use Blogtwo.Web, :model

  schema "posts" do
    field :title, :string
    field :body, :string

    belongs_to :user, Blogtwo.User, foreign_key: :user_id
    has_many :comments, Blogtwo.Comment, on_delete: :delete_all

    timestamps()
  end

  @required_fields ~w(title body user_id)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end
end
