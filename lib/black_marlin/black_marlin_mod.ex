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
    hook_add(:"client.disconnected", &BlackMarlinMod.on_client_disconnected/3, [env])
    hook_add(:"client.subscribe", &BlackMarlinMod.on_client_subscribe/3, [env])
    hook_add(:"client.unsubscribe", &BlackMarlinMod.on_client_unsubscribe/3, [env])
  end

  def unload do
    hook_del(:"client.connected", &BlackMarlinMod.on_client_connected/4)
    hook_del(:"client.disconnected", &BlackMarlinMod.on_client_disconnected/3)
    hook_del(:"client.subscribe", &BlackMarlinMod.on_client_subscribe/3)
    hook_del(:"client.unsubscribe", &BlackMarlinMod.on_client_unsubscribe/3)
  end

  def on_client_connected(client, connect_code, connect_info, _env) do
    IO.inspect(["BlackMarlinMod on_client_connected", client, connect_code, connect_info])

    send_subscribe_request(client.client_id, "#{topic_base}")
    send_subscribe_request(client.client_id, "#{topic_base}#{client.username}}")

    {:ok, client}
  end

  def on_client_disconnected(error, client, _env) do
    IO.inspect(["BlackMarlinMod on_client_disconnected", error, client])

    send_unsubscribe_request(client.client_id, "#{topic_base}")
    send_unsubscribe_request(client.client_id, "#{topic_base}#{client.username}}")

    :ok
  end
end
