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
yarn install
yarn start
```

The example query should run successfully.