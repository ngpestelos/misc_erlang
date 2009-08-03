-module(lazymap).

-export([map/2]).

map(F, []) ->
  [];
map(F, [H|T]) ->
  fun() -> [F(H) | map(F, T)] end.
