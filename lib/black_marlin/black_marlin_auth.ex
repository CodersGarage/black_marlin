defmodule BlackMarlinAuth do
  import HttpHelper

  def load(env) do
    :emqx_access_control.register_mod(:auth, BlackMarlinAuth, [])
  end

  def unload do
    :emqx_access_control.unregister_mod(:auth, BlackMarlinAuth)
  end

  def init(_opts) do
    {:ok, _opts}
  end

  ### check is checking for client connection authorization
  #    {:ignore}
  #    {:error, "Error happend"}
  #    {:ok, false}
  ###
  def check(client, password, _opts) do
    IO.inspect(["OnAuthCheck - ", client, password])

    c = new_client(password)
    case c
         |> check_login(password) do
      true ->
        {:ok, false}
      false ->
        {:error, "Invalid username or password"}
    end
  end

  def description() do
    "BlackMarlin Auth Description"
  end
end
