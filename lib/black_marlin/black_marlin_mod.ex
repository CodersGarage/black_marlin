defmodule BlackMarlinMod do
  require Record

  import MqttHelper
  import Enum
  import Helper

  def hook_add(a, b, c) do
    :emqx.hook(a, b, c)
  end

  def hook_del(a, b) do
    :emqx.unhook(a, b)
  end

  def load(env) do
    hook_add(:"client.connected", &BlackMarlinMod.on_client_connected/4, [env])
  end

  def unload do
    hook_del(:"client.connected", &BlackMarlinMod.on_client_connected/4)
  end

  def on_client_connected(client, connect_code, connect_info, _env) do
    IO.inspect(["BlackMarlinMod on_client_connected", client, connect_code, connect_info])

    case read_user_info(client.username) do
      {:ok, data} ->
        data = Tuple.to_list(data)
        is_admin = Enum.at(data, 3)
        hash = Enum.at(data, 2)

        if !is_admin do
          send_subscribe_request(client.client_id, "#{topic_base}")
          send_subscribe_request(client.client_id, "#{topic_base}#{hash}")
        end
    end

    {:ok, client}
  end
end
