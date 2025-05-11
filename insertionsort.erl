-module(insertionsort). 
-export([for/4, while/1, while/2, test/0, insertionS/1, exception/1, ausl/2, getEle/5]). 

%-------------------------WHILE-------------------------- 
while(L) -> while(L,0). 
while([], Acc) -> Acc;

while([_|T], Acc) ->
   io:fwrite("~w~n",[Acc]), 
   while(T,Acc+1).
%-------------------------FOR----------------------------
for(N,I,Liste,CurrentElement) when N > 0, I < N ->  
   if
      CurrentElement < 0 ->
         getEle(Liste,I,N,I,Liste);
      true ->
         io:fwrite("gay")
   end,
   io:fwrite("lol \n"),
   for(N,I+1,Liste,CurrentElement);

for(N,I,Liste,CurrentElement) when N > 0; I == N ->  
      ok.
%-------------------------GETELEMENT---------------------
getEle(L,I,N,I_old,Liste_old) when L == [] -> exception(3);

getEle([H|T],0,N,I_old,Liste_old) ->
  for(N,I_old,Liste_old,H);

getEle([H|T],I,N,I_old,Liste_old) ->
   getEle(T,I - 1,N,I_old,Liste_old).
%-------------------------TEST---------------------------  
test() -> 
   X = [1,2,3,4], 
   ausl(X,0).

ausl(L,I) when L == [] -> exception(3);

ausl([H|T],0) ->
  H;

ausl([H|T],I) ->
   ausl(T,I - 1).
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

