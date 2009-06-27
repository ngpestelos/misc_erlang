% http://www.youtube.com/watch?v=OpYPKBQhSZ4

-module(test).

-export([start/0]).
-export([loop/0]).

start() ->
    spawn(test, loop, []).

loop() ->
    receive
        Anything ->
            erlang:display({self(), Anything}),
            loop()
    end.
