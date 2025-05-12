-module(insertionsort). 
%-export([for/4, while/2, while/4, test/0, insertionS/1, exception/1, ausl/2, compare/3]). 
-compile(export_all).

insertionS([]) -> [];
insertionS([H|T]) -> insert(H, insertionS(T)).

insert(H, []) -> [H];
insert(H, [H2|T2]) when H =< H2 -> [H, H2 | T2];
insert(H, [H2|T2]) when H > H2 -> [H2 | insert(H, T2)].
