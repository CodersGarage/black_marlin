defmodule Helper do

  def send_subscribe_request(hash) do
    topic = {"/users/#{hash}", %{qos: 2}}
    :emqx_mgmt.subscribe(hash, topic)
  end

end
