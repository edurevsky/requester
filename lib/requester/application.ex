defmodule Requester.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Requester.Worker.start_link(arg)
      # {Requester.Worker, arg}
      {Requester.UriAgent, [
        {"StackOverflow", "https://stackoverflow.com"},
        {"GitHub", "https://github.com"},
        {"Error", "https://fasdf"},
        {"Google", "https://google.com"}
      ]},
      Requester.RequestServer,
      Requester.LogAgent,
      Requester.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    Supervisor.start_link(children, strategy: :one_for_one, name: Requester.Supervisor)
    |> IO.inspect()
  end
end
