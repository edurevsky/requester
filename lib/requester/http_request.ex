defmodule Requester.HttpRequest do
  def go({_, uri} = request) do
    HTTPoison.get(uri) |> handle(request)
  end

  defp handle({:error, _}, {uri_alias, _}) do
    IO.puts("An error occured while requesting to '#{uri_alias}'")
  end

  defp handle({:ok, request}, {uri_alias, uri}) do
    %_{status_code: status_code} = request
    log(status_code, uri_alias, uri)
  end

  defp log(status_code, uri_alias, uri) do
    IO.puts("#{status_code} - #{uri_alias} - #{uri}")
  end
end
