## Model & Migration
  Generate Model:
    Post: `mix phoenix.gen.model Post posts title:string body:string`

  Migrate:
    `mix ecto.migrate`

## iEX console
  `iex -S mix`

  Add data:
  ```iex(4)> alias Blog.Repo
     iex(5)> alias Blog.Post
     iex(6)> Repo.insert(%Post{title: "First Post", body: "Hi this is the body of the first post"})
  ```

  View data:
  `Repo.all(Post)`

## Controller
  ```web/controllers/post_controller.ex

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
  ```

## Router
  View all routes: `mix phoenix.routes`

  Setup:
  ```ex
    scope "/", Blog do
      pipe_through :browser # Use the default browser stack

      get "/", PageController, :index
      resources "/posts", PostController
    end
  ```

## Views
  Setup a new file in the view folder. This file looks for the associating html template.
  ```web/views/post_view.ex

    defmodule Blog.PostView do
      use Blog.Web, :view
    end

  ```

  **index.html.eex**
    ```web/templates/post/index.html.eex

      <h1>Posts</h1>
      <ul class="post-ul">
        <%= for post <- @posts do %>
          <li class="post-li">
            <div class="post-head">
              <h2><%= link(post.title, to: post_path(@conn, :show, post)) %></h2>
              <%= link("Delete", to: post_path(@conn, :delete, post), method: :delete, data: [confirm: "Are you sure?"], class: "btn btn-danger btn-sm del-post") %>
            </div>

            <p><%= post.body %></p>
          </li>
        <% end %>
        <%= link("Create New Post", to: post_path(@conn, :new), class: "new-post") %>
      </ul>
    ```

  **show.html.eex**

  ```web/templates/post/show.html.eex
    <div>
      <h1><%= @post.title %></h1>
      <%= link("Edit", to: post_path(@conn, :edit, @post), method: :get, class: "btn btn-primary btn-sm del-post") %>
    </div>

    <p><%= @post.body %></p>
  ```


  **new.html.eex**

    ```web/templates/post/new.html.eex
      <h1>New post</h1>
      <%= form_for @changeset, post_path(@conn, :create), fn f -> %>
        <%= if @changeset.action do %>
          <div class=”alert alert-danger”>
          <p>Oops, something went wrong</p>
        <% end %>

        <div class="form-group">
          <%= text_input f, :title, placeholder: "Post Title", class: "form-control" %>
        </div>

        <div class="form-group">
          <%= text_input f, :body, placeholder: "Write something creative", class: "form-control" %>
        </div>

        <%= submit "Submit", class: "btn btn-primary" %>
      <% end %>
    ```

  **edit.html.eex**
    ```web/templates/post/edit.html.eex
    
      <h1>Edit post</h1>
      <%= form_for @changeset, post_path(@conn, :update, @post), fn f -> %>
        <%= if @changeset.action do %>
          <div class=”alert alert-danger”>
          <p>Oops, something went wrong</p>
        <% end %>

        <div class="form-group">
          <%= text_input f, :title, placeholder: "Post Title", class: "form-control" %>
        </div>

        <div class="form-group">
          <%= text_input f, :body, placeholder: "Write something creative", class: "form-control" %>
        </div>

        <%= submit "Submit", class: "btn btn-primary" %>
      <% end %>
    ```
