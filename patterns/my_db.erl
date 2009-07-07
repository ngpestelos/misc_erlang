% Exercise 5-1

-module(my_db).

-export([start/0, stop/0]).
-export([loop/1]).
-export([write/2, read/1, delete/1, match/1]).

start() ->
  State = [],
  register(my_db, spawn(my_db, loop, [State])).

stop() ->
  my_db ! {stop, self()},
  receive
    {reply, Reply} ->
      Reply
  end.

write(Key, Element) ->
  my_db ! {write, self(), Key, Element},
  receive
    {reply, Reply} ->
      Reply
  end.

read(Key) ->
  my_db ! {read, self(), Key},
  receive
    {reply, Reply} ->
      Reply
  end.

delete(Key) ->
  my_db ! {delete, self(), Key},
  receive
    {reply, Reply} ->
      Reply
  end.

match(Element) ->
  my_db ! {match, self(), Element},
  receive
    {reply, Reply} ->
      Reply
  end.


loop(Data) ->
  receive
    {write, Pid, Key, Element} ->
      {Result, NewData} = write(Key, Element, Data),
      reply(Pid, {reply, Result}),
      loop(NewData);
    {delete, Pid, Key} ->
      {Result, NewData} = delete(Key, Data),
      reply(Pid, {reply, Result}),
      loop(NewData);
    {read, Pid, Key} ->
      Result = find(Key, Data),
      reply(Pid, {reply, Result}),
      loop(Data);
    {match, Pid, Element} ->
      Result = match(Element, Data, []),
      reply(Pid, {reply, Result}),
      loop(Data);
    {stop, Pid} ->
      reply(Pid, {reply, ok})
  end.

write(Key, Element, Data) ->
  {ok, NewData} = delete(Key, Data),
  {ok, [{Key, Element} | NewData]}.

delete(Key, Data) ->
  delete(Key, Data, []).

delete(_Key, [], R) ->
  {ok, R};
delete(Key, [{Key, _Element} | T], R) ->
  {ok, R ++ T}; % we only have one key to match
delete(Key, [Other | T], R) ->
  delete(Key, T, [Other | R]).

find(_Key, []) ->
  {error, instance};
find(Key, [{Key, Element} | _Data]) ->
  {ok, Element};
find(Key, [_H | Data]) ->
  find(Key, Data).

reply(Pid, Msg) ->
  Pid ! Msg.

match(_Element, [], Result) ->
  Result;
match(Element, [{Key, Element} | Data], Result) ->
  match(Element, Data, [Key | Result]);
match(Element, [_H | Data], Result) ->
  match(Element, Data, Result).
