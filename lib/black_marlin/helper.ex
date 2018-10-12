defmodule Helper do

  def send_subscribe_request(hash) do
    :emqx_mgmt.subscribe(hash, "/users/#{hash}}", 2)
  end

end
