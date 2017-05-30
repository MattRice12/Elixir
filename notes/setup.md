## Initial Setup

  Reference:
    https://medium.com/@Stephanbv/elixir-phoenix-lets-code-authentication-todo-application-part-1-599ee94cd04d

  Create Project:
    `mix phoenix.new <name>`

  Setup Database:
    `mix ecto.create`

  Start Server:
    `mix phoenix.server`
    visit: localhost:4000


## Create Models
  Generate Model:
    Post: `mix phoenix.gen.model Post posts title:string body:text`

    User: `mix phoenix.gen.model User users email:string password_hash:string`

  Migrate:
    `mix ecto.migrate`

## Bootstrap alternative
  `mix phoenix.gen.html Post posts title:string body:text`
    - This builds models, views, and controller

## iEX console
  `iex -S mix`

  Add data:
  ```iex(4)> alias Blog.Repo
     iex(5)> alias Blog.Post
     iex(6)> Repo.insert(%Post{title: "First Post", body: "Hi this is the body of the first post"})
  ```

  View data:
  `Repo.all(Post)`

## Seed
  priv/repo/seeds.exs
  ```Create 1

    alias Blog.Repo
    alias Blog.Post

    Repo.insert %Post{
      title: "First Post",
      body: "Hi this is the body of the first post"
    }

  ```

  ```Loop 100 times

    (1..100) |> Enum.each(fn _ -> (Repo.insert %Post{
        title: "First Post",
        body: "Hi this is the body of the first post"
      }) end)

  ```


  `mix run priv/repo/seeds.exs`

## Controller
  Create a controller: `web/controllers/post_controller.ex`

  Index action:
  ```web/controllers/post_controller.ex

    defmodule Blog.PostController do
      use Blog.Web, :controller
      alias Blog.Post

      def index(conn, _params) do
        posts = Repo.all(Post)
        render(conn, "index.html", posts: posts)
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

  Now we create the html file. The name of the file must be the same name as the corresponding action in the user controller (controller index function --> views index.html.eex).
  ```web/templates/post/index.html.eex

    <h1>Posts</h1>
    <ul>
      <%= for post <- @posts do %>
        <li>
          <h2><%= post.title %></h2>
          <p><%= post.body %></p>
        </li>
      <% end %>
    </ul>

  ```

## Delete

  Controller:
  ```web/controllers/post_controller.ex

    def delete(conn, %{"id" => id}) do
      post = Repo.get!(Post, id) |> Repo.delete!
      conn
      |> put_flash(:info, "Deleted Post!")
      |> redirect(to: post_path(conn, :index))
    end

  ```

  View:
  ```web/templates/post/new.html.eex

    <%= link("Delete", to: post_path(@conn, :delete, post), method: :delete, data: [confirm: "Are you sure?"], class: "del-post") %>

  ```
