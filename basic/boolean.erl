% Erlang Programming, p. 44

-module(boolean).

-export([b_not/1]).
-export([b_and/2]).
-export([b_or/2]).
-export([b_nand/2]).

b_not(false) -> true;
b_not(true)  -> false.

b_and(true, true) -> true;
b_and(_, _) -> false.

b_or(true, _) -> true;
b_or(_, true) -> true;
b_or(_, _)    -> false.

b_nand(A, B) -> b_not(b_and(A, B)).
