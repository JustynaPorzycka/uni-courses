/* Dany jest acykliczny graf skierowany o wierzchołkach a, b, c, d, e, f  
i krawędziach ab, bc, bd, ce, cf, df, fe.

a. Zdefiniuj predykat krawedz(X,Y) reprezentujący zadany graf. */

wierzcholek(a).
wierzcholek(b).
wierzcholek(c).
wierzcholek(d).
wierzcholek(e).
wierzcholek(f).

krawedz(a,b).
krawedz(b,c).
% krawedz(c,a).
krawedz(b,d).
krawedz(c,e).
krawedz(c,f).
krawedz(d,f).
krawedz(f,e).

/* Zdefiniuj predykat sciezka(X,Y) mówiący o tym, że wierzchołki X, Y 
są połączone ścieżką. Wypróbuj zdefiniowany predykat i znajdź 
wszystkie wyniki następujących zapytań:

?- sciezka(b, f).
?- sciezka(b, Z).
?- sciezka(X,d). */

sciezka(X,Y):- krawedz(X,Y).
sciezka(X,Y):- krawedz(X,Z), sciezka(Z,Y).

/* Napisz i wykonaj zapytania sprawdzające, czy:

a. istnieje ścieżka z a do f przechodząca przez d
b. istnieje ścieżka o długości 3 kończąca się w f
c. istnieje w grafie cykl */

/* ODP:
a. sciezka(a,d), sciezka(d,f).
b. sciezka(_X,_Y), sciezka(_Y,f).
c. krawedz(X,Y), krawedz(Y,Z), sciezka(Z,X).
 */

/* Przetestuj predykat sciezka_dl(X,Y,N) odpowiadający na pytanie 
czy istnieje ścieżka o długości N łącząca wierzchołki X i Y. */

sciezka_dl(X,Y,N) :- N=1, krawedz(X,Y).
sciezka_dl(X,Y,N) :- N>1, N1 is N - 1, krawedz(X,Z), sciezka_dl(Z,Y,N1).

/* Przy pomocy powyższego predykatu znajdź odpowiedź na pytania:

a. Znajdź wszystkie ścieżki o długości 4 kończące się w f
b. Znajdź wszystkie ścieżki o długości 3 zaczynające się w a
c. Znajdź wszystkie ścieżki o długości 3
d. Dlaczego nie można przy pomocy tego predykatu znaleźć długości ścieżki od a do e ?
*/

/* ODP:
a. sciezka_dl(X, f, 4). 
b. sciezka_dl(a, Y, 3).
c. sciezka_dl(X, Y, 3).
d. Nie ma nigdzie wyliczenia N ze słówkiem is.
*/

/* 
Zdefiniuj nowy predykat dl_sciezki(X,Y,N), który umożliwi znajdowanie długości ścieżek.
Przykład użycia predykatu dl_sciezki:
?- dl_sciezki(a,c, N).
N = 2
*/

dl_sciezki(X,Y,N) :- krawedz(X,Y), N=1.
dl_sciezki(X,Y,N) :-
    krawedz(X,Z), writeln(X), dl_sciezki(Z,Y),
    N is N1 + 1. 