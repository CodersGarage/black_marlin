defmodule BlackMarlinAuth do
  import HttpHelper

  def load(env) do
    :emqttd_access_control.register_mod(:auth, BlackMarlinAuth, [])
  end

  def unload do
    :emqttd_access_control.unregister_mod(:auth, BlackMarlinAuth)
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
    IO.puts("OnAuth check")

    c = new_client(password)
    case c
         |> check_login() do
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
