defmodule AbsFedWeb.Resolvers.Accounts do
  @userdb [
    %{
      id: "1",
      name: "Ada Lovelace",
      birthDate: "1815-12-10",
      username: "@ada"
    },
    %{
      id: "2",
      name: "Alan Turing",
      birthDate: "1912-06-23",
      username: "@complete"
    }
  ]

  def list_users(_parent, _args, _resolution) do
    {:ok, @userdb}
  end

  def get_user(_parent, %{id: id}, _resolution) do
    Enum.find(@userdb, fn(user) ->
      user.id == id
    end)
  end
end

defmodule AbsFedWeb.Schema do
  defmodule AccountTypes do
    use Absinthe.Schema.Notation

    object :user do
      field(:id, non_null(:id))
      field(:name, :string)
      field(:username, :string)
    end
  end

  use Absinthe.Schema
  import_types(AbsFedWeb.Schema.AccountTypes)

  alias AbsFedWeb.Resolvers

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.list_users/3)
    end

    @desc "Get a user by ID"
    field :user,:user do
      arg :id, non_null(:id)
      resolve(&Resolvers.Accounts.get_user/3)
    end

    @desc "My acccount"
    field :me, :user  do
      resolve fn(_, _ , _) ->
        user = List.first(@userdb)
        {:ok, user}
      end
    end
  end
end
