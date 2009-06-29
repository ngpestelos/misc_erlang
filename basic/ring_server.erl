-module(ring_server).

-export([start/3]).
-export([loop/1, head_loop/1]).

start(M, N, Message) ->
  [Next | Tail] = setup_pids(N - 1, []),
  link_pids(Next, Tail),
  Head = spawn(ring_server, head_loop, [Next]),
  register(head, Head),
  head ! {start, Message}.

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

head_loop(Next) ->
  receive
    {ring, _Msg} ->
      io:format("ring ~p~p~n", [self(), Next]),
      Next ! stop,
      head_loop(Next);
    {start, Msg} ->
      io:format("start ~p~p~n", [self(), Next]),
      Next ! {ring, Msg},
      head_loop(Next);
    stop ->
      io:format("head stop ~p~p~n", [self(), Next]),
      ok
  end.

loop(Next) ->
  receive
    {link, P} ->
      loop(P);
    {ring, Msg} ->
      io:format("loop ~p~p~n", [self(), Next]),
      Next ! {ring, Msg},
      loop(Next);
    stop ->
      io:format("stop ~p~p~n", [self(), Next]),
      Next ! stop,
      ok           % ok! 
  end.
