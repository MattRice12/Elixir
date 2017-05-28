
## Create User Model
  Create user model and migration:
    `mix phoenix.gen.model User users email:string password_hash:string`


  Update user model (don't need to change migration file):
    ```web/models/user.ex

      defmodule Blogtwo.User do
        use Blogtwo.Web, :model

        schema "users" do
          field :email, :string
          field :password, :string, virtual: true
          field :password_hash, :string

          timestamps()
        end
      end
    ```

  Run migration:
    `mix ecto.migrate`

  Insert data in iEX:
    `iex -S mix`

    ```iex

      alias Blog.Repo
      alias Blog.User
      Repo.insert(%User{email: "foo@bar.com", password_hash: "password"})
    ```

  View all users:
    `Repo.all(User)`

## Controller
    ```user_controller.ex

      defmodule Blogtwo.UserController do
        use Blogtwo.Web, :controller
        alias Blogtwo.User

        def index(conn, _params) do
          users = Repo.all(User)
          render(conn, :index, users: users)
        end

        def show(conn, %{"id" => id}) do
          user = Repo.get!(User, id)
          render(conn, :show, user: user)
        end

        def new(conn, _params) do
          changeset = User.changeset(%User{})
          render(conn, :new, changeset: changeset)
        end

        def create(conn, %{"user" => user_params}) do
          changeset = User.changeset(%User{}, user_params)
          case Repo.insert(changeset) do
            {:ok, user} ->
              conn
              |> put_flash(:info, "User Created!")
              |> redirect(to: user_path(conn, :index))
            {:error, changeset} ->
              conn
              |> put_flash(:info, "Something went wrong!")
              |>render(:new, changeset: changeset)
          end
        end
      end
    ```

## Router
  `resources "/users", UserController`

  `mix phoenix.routes`

## Views
  ```web/view/user_view.ex

    defmodule Blog.UserView do
      use Blog.Web, :view
    end
  ```

  ```web/templates/user/index.html.eex
    <h1>Users</h1>
    <table class="table">
      <%= for user <- @users do %>
        <tr>
          <td><%= link(user.email, to: user_path(@conn, :show, user)) %></td>
        </tr>
      <% end %>
    </table>
    <%= link("New User", to: user_path(@conn, :new), class: "new-user") %>
  ```

  ```web/templates/user/show.html.eex
    <div>
      <h1><%= @user.email %></h1>
      <a href="/users">Back</a>
    </div>
  ```

  ```web/templates/user/new.html.eex
    <h1>New User</h1>
    <%= form_for @changeset, user_path(@conn, :create), fn f -> %>

      <div class="form-group">
        <%= text_input f, :email, placeholder: "john_smith@example.com", class: "form-control" %>
      </div>

      <div class="form-group">
        <%= text_input f, :password_hash, placeholder: "password", class: "form-control", type: "password" %>
      </div>

      <%= submit "Submit", class: "btn btn-primary" %>
    <% end %>
  ```
