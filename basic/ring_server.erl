-module(ring_server).

-export([start/3]).
-export([loop/1]).

start(M, N, Message) ->
  Pids = setup_pids(N, []),
  [Head | Tail] = Pids,
  register(head, Head),
  link_pids(Head, Tail),
  head ! {ring, Message}.

setup_pids(0, L) ->
  lists:reverse(L);
setup_pids(N, L) ->
  P = spawn(ring_server, loop, [nopid]),
  setup_pids(N-1, [P | L]).

link_pids(Pid, []) ->
  Pid ! {link, head};
link_pids(Pid, [Next | Rest]) ->
  Pid ! {link, Next},
  link_pids(Next, Rest).

loop(Pid) ->
  receive
    {link, P} ->
      loop(P);
    {ring, Msg} ->
      io:format("~p~n", [self()]),
      Pid ! {ring, Msg},
      loop(Pid);
    stop ->
      ok 
  end.
