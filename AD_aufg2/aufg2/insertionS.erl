%%%-------------------------------------------------------------------
%%% @author Hendrik
%%%-------------------------------------------------------------------
-module(insertionS).
-author("Hendrik").
-export([insertionS/1, insert/2]).

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
