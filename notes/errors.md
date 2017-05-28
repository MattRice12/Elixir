## Errors:
  1. In the controller:
    ```web/controllers/post_controller.ex

    {:error, changeset} ->
      conn
      |> put_flash(:info, "Oops, something went wrong")
      |> render("new.html", changeset: changeset)

    ```

  -OR-

  2. In the view
    ```web/templates/post/new.html.eex

        <%= form_for @changeset, post_path(@conn, :create), fn f -> %>
          <%= if @changeset.action do %>
            <div class=”alert alert-danger”>
            <p>Oops, something went wrong</p>
          <% end %>
        ...
        <% end %>

    ```
