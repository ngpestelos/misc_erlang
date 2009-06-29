% Erlang Programming, p. 115

-module(echo_server).

-export([start/0, print/1, stop/0]).
-export([loop/0]).

start() ->
  register(echo_server, spawn(echo_server, loop, [])).

print(Term) ->
  echo_server ! {print, Term}.

stop() ->
  echo_server ! stop.

loop() ->
  receive
    {print, Term} ->
      io:format("~p~n", [Term]),
      loop();
    stop ->
      ok
  end.
