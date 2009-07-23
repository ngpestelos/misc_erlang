-module(print_even).

-export([print/1]).

print(N) ->
  even(N, []).

even(0, L) ->
  print_list(L);
even(N, L) when N rem 2 == 0 ->
  even(N-1, [N | L]);
even(N, L) ->
  even(N-1, L).

print_list([]) ->
  ok;
print_list([H | T]) ->
  io:format("Number:~p~n", [H]),
  print_list(T).
