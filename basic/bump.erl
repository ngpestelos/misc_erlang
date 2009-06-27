% Recursion example (Erlang Programming, p. 59)

% Adds 1 to each element of a list.

-module(bump).

-export([bump/1]).

bump([]) -> [];
bump([Head | Tail]) -> [Head + 1 | bump(Tail)].
