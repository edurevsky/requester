defmodule Requester.UriAgent do
  use Agent

  @me :uri_agent

  def start_link(uris) do
    Agent.start_link(fn -> uris end, name: @me)
  end

  def get_uris() do
    Agent.get(@me, fn uris -> uris end)
  end

  def add_uri(uri) do
    Agent.update(@me, fn uris -> [uri | uris] end)
  end
end
