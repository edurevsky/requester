defmodule Requester.HttpRequest do
  def go({_, uri} = request) do
    HTTPoison.get(uri) |> handle(request)
  end

  defp handle({:error, _}, {uri_alias, uri}) do
    IO.puts("An error occured while requesting to '#{uri_alias}'")
    Requester.LogAgent.add_log({uri_alias, uri, :error, DateTime.utc_now()})
  end

  defp handle({:ok, request}, {uri_alias, uri}) do
    %_{status_code: status_code} = request
    log_tuple = {uri_alias, uri, status_code, DateTime.utc_now()}
    Requester.LogAgent.add_log(log_tuple)
    log(log_tuple)
  end

  defp log({status_code, uri_alias, uri, time}) do
    IO.puts("[#{Calendar.strftime(time, "%H:%M:%S")}] #{status_code} - #{uri_alias} - #{uri}")
  end
end
