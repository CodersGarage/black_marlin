defmodule MqttHelper do

  def is_system_message(msg) do
    case msg do
      {
        :message,
        _,
        _,
        :emqx_sys,
        _,
        _,
        _,
        _,
        _
      } -> true
      _ -> false
    end
  end

  def is_presence_message(msg) do
    case msg do
      {
        :message,
        _,
        _,
        :emqx_mod_presence,
        _,
        _,
        _,
        _,
        _
      } -> true
      _ -> false
    end
  end
end
