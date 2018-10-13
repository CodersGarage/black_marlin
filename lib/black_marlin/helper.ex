defmodule Helper do
  @topic_base "/connections/"
  @mnesia_table_name Connection

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

  def boot_mnesia() do
    :mnesia.create_schema([node()])
    :mnesia.start()
    :mnesia.create_table(@mnesia_table_name, [attributes: [:uuid, :hash, :is_admin]])
  end

  def set_user_info(uuid, hash, is_admin) do
    data = fn ->
      :mnesia.write({@mnesia_table_name, uuid, hash, is_admin})
    end

    :mnesia.transaction(data)
  end

  def read_user_info(uuid) do
    data = fn ->
      :mnesia.match_object({@mnesia_table_name, uuid, :_, :_})
    end

    case :mnesia.transaction(data) do
      {:atomic, result} ->
        cond do
          length(result) > 0 ->
            {:ok, Enum.at(result, 0)}
          true ->
            {:not_found, {}}
        end
      _ -> {:not_found, {}}
    end
  end

  def is_admin(uuid) do
    data = fn ->
      :mnesia.match_object({@mnesia_table_name, uuid, :_, true})
    end

    case :mnesia.transaction(data) do
      {:atomic, result} ->
        cond do
          length(result) > 0 ->
            true
          true ->
            false
        end
      _ -> false
    end
  end
end
