-module(reverse).

-export([revAll/1]).

revAll([]) ->
  [];

revAll([X | Xs]) ->
  [lists:reverse(X) | revAll(Xs)].
