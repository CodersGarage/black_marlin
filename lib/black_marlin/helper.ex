defmodule Helper do

  def send_subscribe_request(hash) do
    :emqx_mgmt.subscribe(hash, make_topic_table(hash))
  end

  defp make_topic_table(hash) do
    {topic, options} = :emqx_topic.parse("/users/#{hash}")
    {topic, %{nl: options.nl, qos: 2, rap: options.rap, rc: options.rc, rh: options.rh}}
  end
end
