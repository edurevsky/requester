defmodule Requester.LogAgent do
  use Agent

  @me :log_agent

  def start_link(_) do
    Agent.start_link(fn -> Map.new() end, name: @me)
  end

  def add_log({uri_alias, _uri, _status_code, _date} = log) do
    Agent.update(@me, fn logs -> Map.put(logs, uri_alias, log) end)
  end

  def get_logs() do
    Agent.get(@me, fn logs -> logs end)
  end
end
