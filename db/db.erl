% See Erlang Programming, p. 83
% You may not use the lists library module

-module(db).

-export([new/0, write/3]).
-export([read/2, match/2]).
-export([delete/2, destroy/1]).

new() ->
  [].

write(Key, Element, Db) ->
  [{Key, Element} | Db].

read(Key, [{Key, Element}|_]) ->
  {ok, Element};
read(Key, [{_K, _E} | T]) ->
  read(Key, T);
read(_Key, []) ->
  {error, instance}.

match(Element, Db) ->
  match(Element, Db, []).

delete(Key, Db) ->
  delete(Key, Db, []).

destroy(Db) ->
  ok.

%%% Helper functions

match(Element, [{Key, Element} | T], Acc) ->
  match(Element, T, [Key | Acc]);
match(Element, [{_K, _E} | T], Acc) ->
  match(Element, T, Acc);
match(Element, [], Acc) ->
  Acc.

delete(Key, [{Key, _E} | T], Acc) ->
  delete(Key, T, Acc);
delete(Key, [{OtherKey, OtherElement} | T], Acc) ->
  delete(Key, T, [{OtherKey, OtherElement} | Acc]);
delete(Key, [], Acc) ->
  Acc.
