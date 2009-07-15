-module(add_one).
-export([start/0, request/1, loop/0]).

start() ->
  register(add_one, spawn_link(add_one, loop, [])).

request(Int) ->
  add_one ! {request, self(), Int},
  receive
    {result, Result}  -> Result
    after 1000        -> timeout
  end.

loop() ->
  receive
    {request, Pid, Msg} ->
      Pid ! {result, Msg + 1}
  end,
  loop().
