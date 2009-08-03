% See Erlang Programming, p. 200

-module(multigen).

-export([ten/0]).
-export([eleven/0]).
-export([twelve/0]).

ten() ->
  [{X, Y} || X <- lists:seq(1, 3), Y <- lists:seq(X, 3)].

eleven() ->
  [{X, Y} || X <- lists:seq(1, 4), X rem 2 == 0, Y <- lists:seq(X, 4)].

twelve() ->
  [{X, Y} || X <- lists:seq(1, 4), X rem 2 == 0, Y <- lists:seq(X, 4), X + Y > 4].
