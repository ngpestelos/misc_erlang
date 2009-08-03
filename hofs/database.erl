% See Erlang Programming, p. 199

-module(database).

-export([persons/0]).
-export([books/1]).
-export([persons/1]).
-export([eight/0]).
-export([nine/0]).

data() ->
  [{francesco, harryPotter}, {simon, jamesBond},
   {marcus, jamesBond}, {francesco, daVinciCode}].

persons() ->
  [Person || {Person, _} <- data()].

books(Person) ->
  [Book || {Person1, Book} <- data(), Person1 == Person].

persons(Book) ->
  [Person || {Person, Book1} <- data(), Book1 == Book].

eight() ->
  % List of books and the list of people who read them
  [{Book, [Person || {Person, B} <- data(), Book == B ]} || {_, Book} <- data()].

nine() ->
  % Shadowed
  [{Book, [Person || {Person, Book} <- data()]} || {_, Book} <- data()].
