defmodule Helper do

  def send_subscribe_request(hash) do
    case :emqx_mgmt.subscribe(hash, make_topic_table(hash)) do
      {error, reason} -> IO.inspect(["Subscription error = ", error, reason])
      _ -> IO.inspect(["Subscription success"])
    end
  end

  defp make_topic_table(hash) do
    {topic, options} = :emqx_topic.parse("/users/#{hash}")
    IO.inspect(["topic = ", topic])
    IO.inspect(["Opts = ", options])
    [{topic, %{qos: 2}}]
  end
end
