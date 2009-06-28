% Sharing Pid data between processes (Erlang Programming, p. 100)

-module(share).

-export([start/0]).
-export([transferB/0, transferC/0]).
-export([wait_for_foo/0]).

start() ->
  PidA = spawn(share, wait_for_foo, []),
  PidB = spawn(share, transferB, []),
  PidB ! {transfer, PidA}.

transferB() ->
  receive
    {transfer, Pid} ->
      PidC = spawn(share, transferC, []),
      PidC ! {transfer, Pid}
  end.

transferC() ->
  receive
    {transfer, Pid} ->
      Pid ! foo
  end.

wait_for_foo() ->
  receive
    foo ->
      io:format("Got foo. How about you?~n")
  end.
