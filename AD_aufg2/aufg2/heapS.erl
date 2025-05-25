-module(heapS).
-compile(export_all).

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
