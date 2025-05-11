-module(insertionsort). 
-export([for/4, while/2, while/4, test/0, insertionS/1, exception/1, ausl/2, compare/3]). 

%-------------------------WHILE-------------------------- 
while(L, StopIndex) -> while(L,0, StopIndex, []). 
while(_, Acc, StopIndex, WhileConcat) when Acc == StopIndex -> WhileConcat;

while([H|T], Acc, StopIndex, WhileConcat) ->
   Liste = WhileConcat ++ [H],
   io:fwrite("~w~n",[H]), 
   while(T,Acc+1, StopIndex, Liste).
%-------------------------FOR----------------------------
for(N,Index,Liste,CurrentElement) when N > 0, Index < N ->  
   if
      CurrentElement < 0 ->
         io:fwrite("CurrentElement nicht gesetzt\n"),
         NewCurrent = ausl(Liste, Index),
         for(N, Index,Liste, NewCurrent);
      true ->
         io:format("CurrentElement ist: ~p.\n", [CurrentElement]),
         compare(Index, Liste, CurrentElement)
   end
.
%-------------------------GETELEMENT---------------------
ausl(L,I) when L == [] -> exception(3);
ausl([H|T],0) ->
  H;

ausl([H|T],I) ->
   io:fwrite("lese aus\n"),
  ausl(T,I - 1).
%-------------------------COMPARE------------------------
compare(Index, Liste, CurrentElement) ->
   PrevElement = ausl(Liste, Index - 1),
   Windex = Index,
   if
      CurrentElement < PrevElement ->         
         Test = [CurrentElement] ++ while(Liste, Index),
         io:format("Test ist: ~p.\n", [Test]);
         true ->
         io:fwrite("nicht cool\n")
   end
.
%--------------------------------------------------------
%--------------------------------------------------------

insertionS(Liste) when Liste == [] -> exception(1);

insertionS(Liste) -> 
   for(10,1,Liste,-1).

exception(Exnumber) ->
   case Exnumber of
      1 -> io:fwrite("Die Liste ist leer! \n");
      2 -> io:fwrite("Es sind nur Zahlen erlaubt! \n");
      3 -> io:fwrite("Der Index ist Out of Bounds! \n")
   end.

%-------------------------TEST---------------------------  
test() -> 
   X = [1,2,3,4], 
   ausl(X,0).
