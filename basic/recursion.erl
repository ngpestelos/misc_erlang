% Recursion example (Erlang Programming, p. 59)

-module(recursion).

-export([bump/1]).
-export([member/2]).

bump([]) -> [];
bump([Head | Tail]) -> [Head + 1 | bump(Tail)].

member(_, [])    -> false;
member(H, [H|_]) -> true;
member(H, [_|T]) -> member(H, T).
