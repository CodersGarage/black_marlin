defmodule BlackMarlinAcl do

  def load(env) do
    :emqx_access_control.register_mod(:acl, BlackMarlinAcl, [])
  end

  def unload do
    :emqx_access_control.unregister_mod(:acl, BlackMarlinAcl)
  end

  def init(opts) do
    IO.puts("On Acl init")
    {:ok, opts}
  end

  def check_acl({client, pubsub, topic}, opts) do
    IO.puts("OnAcl check_acl")
    IO.inspect(["client : ", client])
    IO.inspect(["pubsub : ", pubsub])
    IO.inspect(["topic : ", topic])

    case pubsub do
      :publish -> :allow
      _ -> :deny
    end

    #    {:ignore}
    #    {:deny}
  end

  def reload_acl(_State) do
    IO.puts("OnReloadAcl reload_acl")
    :ok
  end

  def description() do
    "BlackMarlin Acl Description"
  end
end
