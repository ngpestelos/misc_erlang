% Erlang Programming, p. 56

-module(apply_demo).

-export([main/0]).

main() ->
  Module = examples,
  Function = even,
  Arguments = [10],
  apply(Module, Function, Arguments).
