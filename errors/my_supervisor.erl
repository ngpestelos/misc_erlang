-module(my_supervisor).
-export([start_link/2, stop/1]).
-export([init/1]).

start_link(Name, ChildSpecList) ->
  register(Name, spawn_link(my_supervisor, init, [ChildSpecList])),
  ok.

stop(Name) ->
  Name ! {stop, self()},
  receive {reply, Reply} -> Reply end.

init(ChildSpecList) ->
  process_flag(trap_exit, true),
  loop(start_children(ChildSpecList)).

start_children([]) -> [];
start_children([{M, F, A} | ChildSpecList]) ->
  case (catch apply(M, F, A)) of
    {ok, Pid} ->
      [{Pid, {M, F, A}} | start_children(ChildSpecList)];
    _ ->
      start_children(ChildSpecList)
  end.

restart_child(Pid, ChildList) ->
  {value, {Pid, {M, F, A}}} = lists:keysearch(Pid, 1, ChildList),
  {ok, NewPid} = apply(M, F, A),
  [{NewPid, {M, F, A}} | lists:keydelete(Pid, 1, ChildList)].

loop(ChildList) ->
  receive
    {'EXIT', Pid, _Reason} ->
      NewChildList = restart_child(Pid, ChildList),
      loop(NewChildList);
    {stop, From} ->
      From ! {reply, terminate(ChildList)}
  end.

terminate([{Pid, _} | ChildList]) ->
  exit(Pid, kill),
  terminate(ChildList);
terminate(_ChildList) -> ok.
