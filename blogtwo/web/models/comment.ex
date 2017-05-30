defmodule Blogtwo.Comment do
  use Blogtwo.Web, :model

  schema "comments" do
    field :name, :string
    field :content, :string
    belongs_to :post, Blogtwo.Post, foreign_key: :post_id

    timestamps()
  end

  @required_fields ~w(name content post_id)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end
end
