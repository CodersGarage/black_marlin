defmodule BlackMarlin do
  use Application

  def start(type, args) do
    BlackMarlinAuth.load([])
    BlackMarlinAcl.load([])
    BlackMarlinMod.load([])
    BlackMarlin.Supervisor.start_link()
  end

  def stop(_app) do
    BlackMarlinAuth.unload()
    BlackMarlinAcl.unload()
    BlackMarlinMod.unload()
  end
end
