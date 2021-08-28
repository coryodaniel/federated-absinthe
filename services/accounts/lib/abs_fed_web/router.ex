defmodule AbsFedWeb.Router do
  use AbsFedWeb, :router

  forward "/graphql", Absinthe.Plug.GraphiQL,
    schema: AbsFedWeb.Schema,
    interface: :playground
end
