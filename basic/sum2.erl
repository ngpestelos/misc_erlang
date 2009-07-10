% Erlang Programming, p. 82

-module(sum2).

-export([sum/2]).

sum(N, M) ->
  sum(N, M, 0).

sum(N, M, Acc) when N < M ->
  sum(N+1, M, Acc + N);
sum(M, M, Acc) ->
  Acc + M.
