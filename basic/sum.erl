% Erlang Programming, p. 82

-module(sum).

-export([sum/1]).

sum(N) when integer(N), N > 0 ->
  sum(N, 0).

sum(0, Acc) ->
  Acc;
sum(N, Acc) ->
  sum(N-1, Acc + N).
