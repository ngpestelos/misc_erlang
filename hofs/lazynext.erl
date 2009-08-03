-module(lazynext).

-export([next/1]).

next(Seq) ->
  fun() -> [Seq | next(Seq+1)] end.
