import Config

config :requester, Requester.Scheduler, jobs: [
  {"* * * * *", fn -> GenServer.cast(:request_server, :make_requests) end},
]
