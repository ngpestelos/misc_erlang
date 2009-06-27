% Erlang Programming, p. 65-67

-module(tail_recursion).

-export([bump/1]).
-export([merge/2]).
-export([average/1]).

bump(List) -> bump_acc(List, []).

bump_acc([], Acc) -> reverse(Acc);
bump_acc([Head | Tail], Acc) -> bump_acc(Tail, [Head + 1 | Acc]).

reverse(List) -> reverse_acc(List, []).

reverse_acc([], Acc) -> Acc;
reverse_acc([Head | Tail], Acc) -> reverse_acc(Tail, [Head | Acc]).

merge(Xs, Ys) ->
  lists:reverse(mergeL(Xs, Ys, [])).

mergeL([X|Xs], Ys, Zs) ->
  mergeR(Xs, Ys, [X | Zs]);
mergeL([], [], Zs) ->
  Zs.

mergeR(Xs, [Y | Ys], Zs) ->
  mergeL(Xs, Ys, [Y | Zs]);
mergeR([], [], Zs) ->
  Zs.

average(List) ->
  average_acc(List, 0, 0).

average_acc([], Sum, Length) ->
  Sum / Length;
average_acc([H | T], Sum, Length) ->
  average_acc(T, H + Sum, Length + 1).

