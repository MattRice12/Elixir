defmodule Blog.PostController do
  use Blog.Web, :controller
  alias Blog.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, :index, posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    render(conn, :show, post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, :new, changeset: changeset)
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
        |> put_flash(:info, "Something went wrong!")
        |> render(:new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)
    render(conn, :edit, post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully!")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, :edit, post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.delete!
    conn
    |> put_flash(:info, "Post Deleted!")
    |> redirect(to: post_path(conn, :index))
  end

end
