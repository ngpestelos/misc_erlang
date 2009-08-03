-module(double).

-export([doubleAll/1]).

doubleAll([]) ->
  [];
doubleAll([X|Xs]) ->
  [X*2 | doubleAll(Xs)].
