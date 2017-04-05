defmodule BullyRPi do
  use BLE.GenNode
  require Logger
  alias Nerves.{Leds, Networking}
  alias BLE.GenNode

  @interface :eth0

  def start(_type, _args) do
    Leds.set [{:green, true}]

    unless :os.type == {:unix, :darwin} do     # don't start networking unless we're on nerves
      {:ok, _} = Networking.setup @interface
    end
    :timer.sleep 2000
    # spawn fn -> RPiNode.start_node() end
    Leds.set [{:green, false}]

    {:ok, self()}
  end

  def on_role_change(:worker, nodeState) do
     Leds.set [{:green, false}]
    {:ok, nodeState}
  end

  def on_role_change(:leader, nodeState) do
    Leds.set [{:green, true}]
    {:ok, nodeState}
  end
end
