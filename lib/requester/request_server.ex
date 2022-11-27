defmodule Requester.RequestServer do
  use GenServer

  @me :request_server

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: @me)
  end

  def init(_) do
    {:ok, []}
  end

  def make_requests() do
    GenServer.cast(@me, :make_requests)
  end

  def handle_cast(:make_requests, _) do
    Requester.UriAgent.get_uris()
    |> Enum.map(fn uri -> Task.async(fn -> Requester.HttpRequest.go(uri) end) end)
    |> Enum.each(fn task -> Task.await(task, 10_000) end)
    {:noreply, []}
  end
end
