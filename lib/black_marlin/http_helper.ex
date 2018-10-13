defmodule HttpHelper do
  use Tesla.Builder

  plug Tesla.Middleware.BaseUrl, System.get_env("AUTH_URL")
  plug Tesla.Middleware.JSON

  import Helper

  def check_login(client, username) do
    case post(client, "/auth", %{username: username}) do
      {:ok, resp} ->
        case resp.status do
          200 ->
            hash = resp.body["data"]["hash"]
            is_admin = resp.body["data"]["is_admin"]
            case set_user_info(username, hash, is_admin) do
              {:atomic, :ok} -> true
              _ -> false
            end
          _ -> false
        end
      _ ->
        false
    end
  end

  def new_client(token) do
    Tesla.build_client(
      [
        {Tesla.Middleware.Headers, [{"Authorization", "Bearer #{token}"}]}
      ]
    )
  end
end
