## New
  **in index.html.eex**
    `<%= link("Create New Post", to: post_path(@conn, :new), class: "new-post") %>`


## Create
  **in new.html.eex**
    `<%= form_for @changeset, post_path(@conn, :create), fn f -> %>`


## Edit
  **in index.html.eex / show.html.eex**
    `<%= link("Edit", to: post_path(@conn, :edit, @post), method: :get, class: "btn btn-primary btn-sm del-post") %>`


## Update
  **in edit.html.eex**
    `<%= form_for @changeset, post_path(@conn, :update, @post), fn f -> %>`


## Delete
  **in index.html.eex / show.html.eex**
    `<%= link("Delete", to: post_path(@conn, :delete, post), method: :delete, data: [confirm: "Are you sure?"], class: "btn btn-danger btn-sm del-post") %>`
