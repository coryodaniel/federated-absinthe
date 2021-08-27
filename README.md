# Federating Absinthe Elixir w/ GraphQL Mesh

An attempt to configure federation w/ Absinthe GraphQL and GraphQL Mesh.

## Setup

Mac OS Setup

```shell
brew install gpg asdf
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install
```

## Run GraphQL Mesh Example App

[GraphQL Mesh](https://github.com/Urigo/graphql-mesh) includes a [federation example](https://github.com/Urigo/graphql-mesh/tree/master/examples/federation-example) federating 4 nodejs graphs.

```shell
cd federation-example/
yarn install
yarn start
```

The example query should run successfully.

## Run GraphQL Mesh w/ Absinthe

Change the scripts in `package.json`:

```js
  // add a "_" to skip accounts-js
  "_start-service-accounts": "nodemon services/accounts-js/index.js",
  // remove the "_" to start accounts-ex
  "start-service-accounts": "cd services/accounts-ex && mix phx.server",
```

Run the example:

```shell
cd federation-example
yarn install #if you haven't
yarn start
```

The example crashes with:

```
🕸️ - Server: Could not add key directives or extend types: Query
```

If you comment out all of the federation transforms `types`, the server will start, elixir will be queried for `user` queries, but `user` fields in other schemas are `null`:

```yaml
sources:
  - name: accounts
    handler:
      graphql:
        endpoint: http://localhost:9871/graphql
    transforms:
      - federation:
          types:
            # Removing this sort of makes it work.
            # - name: Query
            #   config:
            #     extend: false
            # - name: User
            #   config:
            #     keyFields:
            #       - id
            #     resolveReference:
            #       queryFieldName: user
```