-module(shape).

-import(math, [sqrt/1]).
-export([area/1]).

area({square, Side}) ->
  Side * Side;
area({circle, Radius}) ->
  math:pi() * Radius * Radius;
area({triangle, A, B, C}) ->
  S = (A + B + C)/2,
  math:sqrt(S*(S-A)*(S-B)*(S-C));
area(Other) ->
  {error, invalid_object}.
