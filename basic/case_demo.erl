% case constructs (see Erlang Programming, p. 49)

-module(case_demo).

-export([safe/1, preferred/1]).

% Will not compile
%unsafe(X) ->
%  case X of
%    one -> Y = true;
%    _   -> Z = two
%  end,
%  Y.

safe(X) ->
  case X of
    one -> Y = 12;
    _   -> Y = 196
  end,
  X + Y.

preferred(X) ->
  Y = case X of
        one -> 12;
        _   -> 196
      end,
  X + Y.
