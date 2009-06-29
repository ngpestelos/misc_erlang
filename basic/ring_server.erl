-module(ring_server).

-export([start/2]).
-export([loop/1, head_loop/1]).

start(N, Message) ->
  Head = spawn(ring_server, head_loop, [nopid]),
  register(head, Head),
  [Next | _T] = setup_pids(N-1, []),
  head ! {link, Next},
  head ! {start, Message}.


setup_pids(0, L) ->
  L;
setup_pids(N, []) ->
  % will be last
  P = spawn(ring_server, loop, [nopid]),
  P ! {link, head},
  setup_pids(N-1, [P]);
setup_pids(N, L) ->
  [Next | _T] = L,
  P = spawn(ring_server, loop, [nopid]),
  P ! {link, Next},
  setup_pids(N-1, [P | L]). 


head_loop(Next) ->
  receive
    {link, N} ->
      %io:format("link ~p~p~n", [self(), N]),
      head_loop(N);
    {start, Message} ->
      io:format("start ~p ~p~n", [self(), Next]),
      Next ! {ring, Message},
      head_loop(Next);
    {ring, Msg} ->
      io:format("head got message ~p ~p~n", [self(), Msg]),
      Next ! stop,
      head_loop(Next);
    stop ->
      ok
  end.

loop(Next) ->
  receive
    {link, P} ->
      loop(P);
    {ring, Msg} ->
      io:format("got message ~p ~p~n", [self(), Msg]),
      Next ! {ring, Msg},
      loop(Next);
    stop ->
      %io:format("stop ~p~p~n", [self(), Next]),
      Next ! stop,
      ok           % ok! 
  end.
