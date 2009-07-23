% Erlang Programming, p. 83
-module(create_lists).

-export([create/1]).

create(N) ->
  create(N, []).

create(0, L) ->
  L;
create(N, L) ->
  create(N - 1, [N | L]).
