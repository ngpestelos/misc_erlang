-module(hof1).

-export([evens/1]).
-export([palins/1]).
-export([map/2]).
-export([filter/2]).
-export([foreach/2]).
-export([times/1]).
-export([double/1]).
-export([palin/1]).

evens([]) ->
  [];
evens([X|Xs]) ->
  case X rem 2 == 0 of
    true ->
      [X | evens(Xs)];
    _ ->
      evens(Xs)
  end.

palins([]) ->
  [];
palins([X|Xs]) ->
  case palin(X) of
    true ->
      [X | palins(Xs)];
    _ ->
      palins(Xs)
  end.

palin(X) ->
  X == lists:reverse(X).

map(_F, []) ->
  [];
map(F, [X | Xs]) ->
  [F(X) | map(F, Xs)].

filter(_F, []) ->
  [];
filter(F, [X | Xs]) ->
  case F(X) of
    true ->
      [X | filter(F, Xs)];
    _ ->
      filter(F, Xs)
  end.

foreach(_F, []) ->
  [];
foreach(F, [X | Xs]) ->
  F(X),
  foreach(F, Xs).

times(X) ->
  fun(Y) -> X*Y end.

double(Xs) ->
  map(times(2), Xs).
