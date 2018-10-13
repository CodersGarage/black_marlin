defmodule Helper do
  @topic_base "/connections/"

  def send_subscribe_request(client_id, topic) do
    case :emqx_mgmt.subscribe(client_id, make_topic_table(topic)) do
      {error, reason} -> IO.inspect(["Subscribe error = ", error, reason])
      _ -> :ok
    end
  end

  def send_unsubscribe_request(client_id, topic) do
    case :emqx_mgmt.unsubscribe(client_id, topic) do
      {error, reason} -> IO.inspect(["Unsubscribe error = ", error, reason])
      _ -> :ok
    end
  end

  defp make_topic_table(topic) do
    {topic, options} = :emqx_topic.parse(topic)
    [{topic, %{qos: 2}}]
  end

  defmacro topic_base do
    @topic_base
  end
end
