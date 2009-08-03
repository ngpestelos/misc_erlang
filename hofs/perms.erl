-module(perms).

-export([splits/1]).
-export([main/0]).
-export([perms/1]).
-export([insert/3]).

perms([]) ->
  [[]];
perms([X | Xs]) ->
  [insert(X, As, Bs) || Ps <- perms(Xs),
                        {As, Bs} <- splits(Ps)].

splits([]) ->
  [{[], []}];
splits([X|Xs] = Ys) ->
  [ {[], Ys} | [ {[X|As], Bs} || {As, Bs} <- splits(Xs)] ].

insert(X, As, Bs) ->
  lists:append([As, [X], Bs]).

main() ->
  splits([1,2,3,4]).
