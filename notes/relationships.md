## Generate
  `mix phoenix.gen.html Post posts title:string body:text`

  `mix phoenix.gen.model Comment comments name:string content:text post_id:references:posts`

## Models
  ```web/models/comment.ex
    defmodule Blog.Comment do
      use Blog.Web, :model

      schema "comments" do
        field :name, :string
        field :content, :string
        belongs_to :post, Blog.Post, foreign_key: :post_id

        timestamps()
      end

      @required_fields ~w(name content post_id)
      @optional_fields ~w()

      def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, @required_fields, @optional_fields)
      end
    end
  ```

  ```web/models/post.ex
    schema "posts" do
      field :title, :string
      field :body, :string

      has_many :comments, Blog.Comment

      timestamps()
    end  
  ```

## Router

  ```web/router.ex
    resources "/posts", PostController do
      post "/comment", PostController, :add_comment
    end
  ```

## Controller
  ```post_controller.ex
    defmodule Blogtwo.PostController do
      use Blogtwo.Web, :controller

      alias Blogtwo.Post
      alias Blogtwo.Comment

      plug :scrub_params, "comment" when action in [:add_comment]

      ...

      def show(conn, %{"id" => id}) do
        post = Repo.get(Post, id) |> Repo.preload([:comments])
        changeset = Comment.changeset(%Comment{})
        render(conn, "show.html", post: post, changeset: changeset)
      end

      ...

      def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
        changeset = Comment.changeset(%Comment{}, Map.put(comment_params, "post_id", post_id))
        post = Post |> Repo.get(post_id) |> Repo.preload([:comments])

        if changeset.valid? do
          Repo.insert(changeset)
          conn
          |> put_flash(:info, "Comment added.")
          |> redirect(to: post_path(conn, :show, post))
        else
          render(conn, "show.html", post: post, changeset: changeset)
        end
      end
    ```

## Views

  ```post/comment_form.html.eex
    <%= form_for @changeset, @action, fn f -> %>
      <%= if f.errors != [] do %>
        <div class="alert alert-danger">
          <p>Error</p>
          <ul>
            <%= for {attr, message} <- f.errors do %>
              <li><%= humanize(attr) %> <%= message %></li>
            <% end %>
          </ul>
        </div>
      <% end %>

      <div class="form-group">
        <label>Name</label>
        <%= text_input f, :name, class: "form-control" %>
      </div>

      <div class="form-group">
        <label>Content</label>
        <%= textarea f, :content, class: "form-control" %>
      </div>

      <div class="form-group">
        <%= submit "Add comment", class: "btn btn-primary" %>
      </div>
    <% end %>
  ```

  ```post/comments.html.eex
    <h3> Comments: </h3>
    <table class="table">
      <thead>
        <tr>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <%= for comment <- @post.comments do %>
          <tr>
            <td><%= comment.name %></td>
            <td><%= comment.content %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
  ```

  ```post/show.html.eex
    <%= render "comment_form.html", post: @post, changeset: @changeset, action: post_post_path(@conn, :add_comment, @post) %>

    <%= render "comments.html", post: @post %>
  ```
