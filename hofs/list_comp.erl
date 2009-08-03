-module(list_comp).

-export([one/0]).
-export([two/0]).
-export([three/0]).

one() ->
  [X + 1 || X <- [1,2,3]].

two() ->
  [X || X <- [1,2,3], X rem 2 == 0].

three() ->
  [X + 1 || X <- [1,2,3], X rem 2 == 0].
