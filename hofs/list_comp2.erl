% See Erlang Programming, p. 200

-module(list_comp2).
-export([append/1]).
-export([map/2]).
-export([filter/2]).

map(F, Xs) -> [ F(X) || X <- Xs].

filter(P, Xs) -> [ X || X <- Xs, P(X)].

% Join a list of lists (see flatmap) 
append(Xss) -> [ X || Xs <- Xss, X <- Xs].
