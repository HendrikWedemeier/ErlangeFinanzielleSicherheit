%%%-------------------------------------------------------------------
%%% @author Hendrik
%%%-------------------------------------------------------------------
-module(radixS).
-author("Hendrik").

%% API
-export([sorting/13, fillBuckets/13, concatBuckets/12, radixS/2, getDigitOfNumber/3, quaddro10/2]).

radixS(_Liste, Stelle) when Stelle =< 0 -> io:fwrite("Die Stelligkeit muss mindestens 1 sein");
radixS(Liste, _Stelle) when Liste == [] -> io:fwrite("Die Liste darf nicht leer sein");

radixS(Liste, Stelle) ->
  sorting(Liste, Stelle, [], [], [], [], [], [], [], [], [], [], Stelle)
.
sorting(Liste, Stelle, _B0, _B1, _B2, _B3, _B4, _B5, _B6, _B7, _B8, _B9, _StelleOrig) when Stelle == 0 -> Liste
;
sorting(Liste, Stelle, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, StelleOrig) ->
  fillBuckets(Liste, Stelle, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, StelleOrig)
.

fillBuckets([ZahlHead|ListeRest], Stelle, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, StelleOrig) when ListeRest == [] ->
  case getDigitOfNumber(ZahlHead, Stelle, StelleOrig) of
    0 -> concatBuckets(Stelle, B0 ++ [ZahlHead], B1, B2, B3, B4, B5, B6, B7, B8, B9, StelleOrig);
    1 -> concatBuckets(Stelle, B0, B1 ++ [ZahlHead], B2, B3, B4, B5, B6, B7, B8, B9, StelleOrig);
    2 -> concatBuckets(Stelle, B0, B1, B2 ++ [ZahlHead], B3, B4, B5, B6, B7, B8, B9, StelleOrig);
    3 -> concatBuckets(Stelle, B0, B1, B2, B3 ++ [ZahlHead], B4, B5, B6, B7, B8, B9, StelleOrig);
    4 -> concatBuckets(Stelle, B0, B1, B2, B3, B4 ++ [ZahlHead], B5, B6, B7, B8, B9, StelleOrig);
    5 -> concatBuckets(Stelle, B0, B1, B2, B3, B4, B5 ++ [ZahlHead], B6, B7, B8, B9, StelleOrig);
    6 -> concatBuckets(Stelle, B0, B1, B2, B3, B4, B5, B6 ++ [ZahlHead], B7, B8, B9, StelleOrig);
    7 -> concatBuckets(Stelle, B0, B1, B2, B3, B4, B5, B6, B7 ++ [ZahlHead], B8, B9, StelleOrig);
    8 -> concatBuckets(Stelle, B0, B1, B2, B3, B4, B5, B6, B7, B8 ++ [ZahlHead], B9, StelleOrig);
    9 -> concatBuckets(Stelle, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9 ++ [ZahlHead], StelleOrig)
  end
;
fillBuckets([ZahlHead|ListeRest], Stelle, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, StelleOrig) ->
  case getDigitOfNumber(ZahlHead, Stelle, StelleOrig) of
    0 -> fillBuckets(ListeRest, Stelle, B0 ++ [ZahlHead], B1, B2, B3, B4, B5, B6, B7, B8, B9, StelleOrig);
    1 -> fillBuckets(ListeRest, Stelle, B0, B1 ++ [ZahlHead], B2, B3, B4, B5, B6, B7, B8, B9, StelleOrig);
    2 -> fillBuckets(ListeRest, Stelle, B0, B1, B2 ++ [ZahlHead], B3, B4, B5, B6, B7, B8, B9, StelleOrig);
    3 -> fillBuckets(ListeRest, Stelle, B0, B1, B2, B3 ++ [ZahlHead], B4, B5, B6, B7, B8, B9, StelleOrig);
    4 -> fillBuckets(ListeRest, Stelle, B0, B1, B2, B3, B4 ++ [ZahlHead], B5, B6, B7, B8, B9, StelleOrig);
    5 -> fillBuckets(ListeRest, Stelle, B0, B1, B2, B3, B4, B5 ++ [ZahlHead], B6, B7, B8, B9, StelleOrig);
    6 -> fillBuckets(ListeRest, Stelle, B0, B1, B2, B3, B4, B5, B6 ++ [ZahlHead], B7, B8, B9, StelleOrig);
    7 -> fillBuckets(ListeRest, Stelle, B0, B1, B2, B3, B4, B5, B6, B7 ++ [ZahlHead], B8, B9, StelleOrig);
    8 -> fillBuckets(ListeRest, Stelle, B0, B1, B2, B3, B4, B5, B6, B7, B8 ++ [ZahlHead], B9, StelleOrig);
    9 -> fillBuckets(ListeRest, Stelle, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9 ++ [ZahlHead], StelleOrig)
    end
.

concatBuckets(Stelle, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, StelleOrig) ->
  NeueListe = B0 ++ B1 ++ B2 ++ B3 ++ B4 ++ B5 ++ B6 ++ B7 ++ B8 ++ B9,
  sorting(NeueListe, Stelle - 1, [], [], [], [], [], [], [], [], [], [], StelleOrig)
.

getDigitOfNumber(Number, Stelle, StelleOrig) ->
  X = Number rem quaddro10(10,StelleOrig + 1 - Stelle),
  Digit = X div quaddro10(10,StelleOrig - Stelle),
  Digit
.

quaddro10(_Num, 0) -> 1
;
quaddro10(Num, Stelle) ->
  Num * quaddro10(Num, Stelle - 1)
.
