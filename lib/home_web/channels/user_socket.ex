defmodule HomeWeb.UserSocket do
  use Phoenix.Socket
  use Drab.Socket

  ## Channels
  # channel "room:*", HomeWeb.RoomChannel
  channel "garage_doors", HomeWeb.GarageDoorsChannel
  channel "sprinkler", HomeWeb.SprinklerChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
