# Federating Absinthe Elixir w/ GraphQL Mesh

Federating the Absinthe GraphQL elixir library with GraphQL Mesh.
## Setup

Mac OS Setup

```shell
brew install gpg asdf
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install
```

## Run GraphQL Mesh Example App

[GraphQL Mesh](https://github.com/Urigo/graphql-mesh) includes a [federation example](https://github.com/Urigo/graphql-mesh/tree/master/examples/federation-example) federating 4 nodejs graphs. This example replaces the `accounts` nodejs app with Absinthe.

```shell
pushd services/accounts && mix do deps.get, compile && popd
yarn install
export APOLLO_KEY=your-key
export APOLLO_GRAPH_REF=your-graph-ref
yarn start
```

The example query should run successfully.

## How it works

The GraphQL Mesh config file `.meshrc.yml` contains a list of APIs that can be included in the mesh. GraphQL Mesh supports 12 API sources including GraphQL (with or without federation support), gRPC, OpenAPI, and others.

When adding a graphql source that does **not** support federation, a transform can be used.

Here is an example of extending the root query and allowing other fields to access the accounts' user fields.

```yaml
  - name: accounts
    handler:
      graphql:
        endpoint: http://localhost:9871/graphql
    transforms:
      - federation:
          types:
            - name: Query # Note: Absinthe defaults the root query type name to "RootQueryType"
              config:
                extend: true
            - name: User
              config:
                keyFields:
                  - id
                resolveReference:
                  queryFieldName: user
```

The query name on line 8 of the YAML above needs to match the name of the root query in Absinthe.

```ex
query name: "Query" do
  # ...
end
```