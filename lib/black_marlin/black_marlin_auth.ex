defmodule BlackMarlinAuth do

  def load(env) do
    :emqttd_access_control.register_mod(:auth, BlackMarlinAuth, [])
  end

  def unload do
    :emqttd_access_control.unregister_mod(:auth, BlackMarlinAuth)
  end

  def init(_opts) do
    IO.puts("On Auth init")
    {:ok, _opts}
  end

  ### check is checking for client connection authorization
  def check(client, password, _opts) do
    IO.puts("OnAuth check")

    case is_authorized(client, password) do
      true ->
        {:ok, false}
      false ->
        {:error, "Invalid username or password"}
    end

    #    {:ignore}
    #    {:error, "Error happend"}
    #    {:ok, false}
  end

  defp is_authorized(client, password) do
    username = MqClient.get_mq_client_username(client)
    if username == "admin" and password == "admin" do
      true
    else
      false
    end
  end

  def description() do
    "BlackMarlin Auth Description"
  end
end
