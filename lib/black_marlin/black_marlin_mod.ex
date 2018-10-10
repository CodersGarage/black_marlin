defmodule BlackMarlinMod do
  require Record

  import MqttHelper
  import Enum

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
    {:ok, client}
  end

  def on_client_disconnected(error, client, _env) do
    IO.inspect(["BlackMarlinMod on_client_disconnected", error, client])
    :ok
  end

  def on_client_subscribe(client, topic, _env) do
    path = elem(at(topic, 0), 0)
    options = elem(at(topic, 0), 1)
    new_topic = [
      {"#{path}/#{client.username}", %{nl: options.nl, qos: 2, rap: options.rap, rc: options.rc, rh: options.rh}}
    ]
    {:ok, new_topic}
  end
end
