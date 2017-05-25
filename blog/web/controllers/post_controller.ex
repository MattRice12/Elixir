defmodule Blog.PostController do
  use Blog.Web, :controller
  alias Blog.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created!")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Error")
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.delete!
    conn
    |> put_flash(:info, "Deleted Post!")
    |> redirect(to: post_path(conn, :index))
  end

end
