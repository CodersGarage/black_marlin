defmodule HttpHelper do
  use Tesla.Builder

  plug Tesla.Middleware.BaseUrl, System.get_env("AUTH_URL")
  plug Tesla.Middleware.JSON

  def check_login(client) do
    case post(client, "/auth", %{}) do
      {:ok, resp} ->
        case resp.status do
          200 -> true
          _ -> false
        end
      _ ->
        false
    end
  end

  def check_sub(client) do
    case post(client, "/check_sub", %{}) do
      {:ok, resp} ->
        if resp.status == 200 do
          {true, resp.body["data"]["hash"]}
        end
      _ ->
        {false, ""}
    end
  end

  def check_pub(client) do
    case post(client, "/check_pub", %{}) do
      {:ok, resp} ->
        case resp.status do
          200 -> true
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
