%%%-------------------------------------------------------------------
%%% @author Hendrik
%%%-------------------------------------------------------------------
-module(introS).
-author("Hendrik").

%% API
-export([
  insertionS/1, insert/2,
  heapS/1, heapUp/2, heapDown/2, heapSeep/3, swap/3, subList/3, getI/2, list_length/1, replaceI/3,
  introS/3, introSLoop/4, getLength/2, getPivotPoint/2, getPoint/2, getSum/1, partition/4]).

introS(_Pivot, Liste, _SwitchNum) when Liste == [] ->
  io:fwrite("Die Liste darf nicht leer sein")
;
introS(Pivot, Liste, SwitchNum) ->
  Result =
  introSLoop(Pivot, Liste, SwitchNum, 0),
  Result
.
introSLoop(_Pivot, Liste, _SwitchNum, _RekurDepth) when Liste == [] -> [];
introSLoop(Pivot, Liste, SwitchNum, RekurDepth) ->
  Length = getLength(Liste, 0),
  MaxDepth = 2 * math:log2(Length),
  if
    Length < SwitchNum ->
      insertionS(Liste);
    RekurDepth >= MaxDepth ->
      heapS(Liste);
    true ->
      PivotPoint = getPivotPoint(Liste, Pivot),
      [LeftPart|RightPart] = partition([], [], Liste, PivotPoint),
      NewRekurDepth = RekurDepth + 1,
      LoopResult =
      introSLoop(Pivot, LeftPart, SwitchNum, NewRekurDepth)
      ++ introSLoop(Pivot, RightPart, SwitchNum, NewRekurDepth),
      LoopResult
  end
.
getLength(Liste, _Length) when Liste == [] -> 0;
getLength([_Kopf|Rest], Length) when Rest == [] ->
  Length + 1
;
getLength([_Kopf|Rest], Length) ->
  getLength(Rest, Length +1)
.

getPivotPoint([Kopf|Rest], Pivot) ->
  Length = getLength([Kopf|Rest], 0),
  case Pivot of
    left -> Kopf;
    middle -> getPoint([Kopf|Rest],Length div 2);
    right -> getPoint([Kopf|Rest],Length - 1);
    median -> getSum([Kopf|Rest]) / Length;
    random -> getPoint([Kopf|Rest], rand:uniform(Length) - 1)
  end
.

getPoint([Kopf|_Rest], Index) when Index == 0 -> Kopf;
getPoint([_Kopf|Rest], Index) ->
  getPoint(Rest, Index-1)
.

getSum([]) -> 0;
getSum([Kopf|Rest]) ->
  Kopf + getSum(Rest)
.

partition(LeftPart, RightPart, Liste, _PivotPoint) when Liste == [] ->
  [LeftPart|RightPart]
;
partition(LeftPart, RightPart, [Kopf|Rest], PivotPoint) ->
  case Kopf < PivotPoint of
    true -> partition([Kopf|LeftPart], RightPart, Rest, PivotPoint);
    false -> partition(LeftPart, [Kopf|RightPart], Rest, PivotPoint)
  end
.

%Insertion
insertionS([]) -> [];
insertionS([Kopf | Rest]) -> insert(Kopf, insertionS(Rest))
.

insert(SingleKopfReturn, []) ->
  [SingleKopfReturn]
;

insert(Kopf, [KopfRest | RestRest]) when Kopf =< KopfRest ->
  [Kopf, KopfRest | RestRest]
;

insert(RekurKopf, [RekurRestKopf | RekurRestRest]) when RekurKopf > RekurRestKopf ->
  [RekurRestKopf | insert(RekurKopf, RekurRestRest)]
.

%Heap
%%get num of Elements in list
list_length([]) -> 0;
list_length([_H|T]) -> 1 + list_length(T).

%%get Element from Index I
%getI([],0) -> [];
getI([H|_T],0) -> H;
getI([_H|T],I) -> getI(T, I - 1).

%%get sublist from Index S to Index E
%subList(L,S,E) when E > list_length(L)-1 -> subList(L,S,list_length(L)-1);
subList(L,S,E) when S < E -> [getI(L,S)] ++ subList(L,S+1,E);
subList(L,S,E) when S == E -> [getI(L,S)];
subList(_L,S,E) when S > E -> [].

%% Replace Element on Index I with Element R
replaceI(L,I,R) -> subList(L,0,I-1) ++ [R] ++ subList(L,I+1,list_length(L)-1).

%%Swap Element on Index A with Element on Index B
swap(L,A,B) ->
  X = getI(L,A),
  Y = getI(L,B),
  replaceI(replaceI(L,A,Y),B,X).

%% Heap eigenschaften Erstellen ab Startknoten S bis Listenende E
heapSeep(L,S,E) when S*2 >= E -> L;
heapSeep(L,S,E) ->
  J = (S+1)*2-1,

  KL = getI(L,(S+1)*2-1),
  if
    (S+1)*2 =< E ->
      KR = getI(L,(S+1)*2);
    true ->
      KR = KL -1
  end,

  if
    KL < KR ->
      J2 = J + 1;
    true ->
      J2 = J
  end,

  Parent = getI(L,S),
  Next = getI(L,J2),

  if
    Parent < Next ->
      heapSeep(swap(L,S,J2),J2,E);
    true ->
      L
  end.

%% Heap eigenschaften Herstellen
heapUp(L,I) when I >= 0 -> heapUp(heapSeep(L,I,list_length(L)-1),I-1);
heapUp(L,_I) -> L.

%% Sortieren
heapDown(L,I) when I > 0 -> heapDown(heapSeep(swap(L,0,I),0,I-1),I-1);
heapDown(L,_I) -> L.

heapS(L) ->
  %heapSeep(L, 0, list_length(L)-1)
  %heapUp(L,(list_length(L)-1) div 2).
  HeapEnde = list_length(L)-1,
  heapDown(heapUp(L,HeapEnde div 2),HeapEnde).