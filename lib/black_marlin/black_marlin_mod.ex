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
    hook_add(:"message.publish", &BlackMarlinMod.on_message_publish/2, [env])
    hook_add(:"message.delivered", &BlackMarlinMod.on_message_delivered/3, [env])
  end

  def unload do
    hook_del(:"client.connected", &BlackMarlinMod.on_client_connected/4)
    hook_del(:"message.publish", &BlackMarlinMod.on_message_publish/2)
    hook_del(:"message.delivered", &BlackMarlinMod.on_message_delivered/3)
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

  def on_message_publish(msg, _env) do

    cond do
      is_system_message(msg) or is_presence_message(msg) ->
        {:ok, msg}
      true ->
        IO.inspect(["on_message_publish = ", msg])
        {:ok, msg}
    end

  end

  def on_message_delivered(a, b, c) do
    IO.inspect(["on_message_delivered = ", a, b, c])
  end

end
