% Erlang Programming, p. 83
-module(create_lists2).

-export([create/1]).

create(N) ->
  create(N, []).

create(0, L) ->
  reverse(L);
create(N, L) ->
  create(N - 1, [N | L]).

reverse([]) ->
  [];
reverse(L) ->
  reverse(L, []).

reverse([], L) ->
  L;
reverse([H | T], L) ->
  reverse(T, [H | L]).
