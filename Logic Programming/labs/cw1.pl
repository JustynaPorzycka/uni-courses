mezczyzna(jacek).
mezczyzna(karol).
mezczyzna(witold).
mezczyzna(mariusz).
mezczyzna(onufry).
mezczyzna(michal).
mezczyzna(czarek).
mezczyzna(roman).
mezczyzna(franek).

kobieta(ala).
kobieta(wanda).
kobieta(kunegunda).
kobieta(magda).
kobieta(ola).
kobieta(zuzanna).
kobieta(aneta).
kobieta(ewa).
kobieta(nina).

dziecko(ola, ala).
dziecko(magda, ala).
dziecko(michal, ala).
dziecko(ola, jacek).
dziecko(magda, jacek).
dziecko(michal, jacek).
dziecko(czarek, wanda).
dziecko(roman, wanda).
dziecko(czarek, karol).
dziecko(wanda, karol).
dziecko(franek,witold).
dziecko(zuzanna,witold).
dziecko(franek,kunegunda).
dziecko(zuzanna,kunegunda).
dziecko(onufry, magda).
dziecko(aneta, magda).
dziecko(onufry, mariusz).
dziecko(aneta, mariusz).
dziecko(ewa, onufry).
dziecko(nina, onufry).
dziecko(ewa, ola).
dziecko(nina, ola).

syn(X,Y) :- mezczyzna(X), dziecko(X,Y).
corka(X,Y) :- kobieta(X), dziecko(X,Y).
wnuk(X,Y) :- dziecko(X,Z), dziecko(Z,Y).
dziadek(X,Y) :- wnuk(Y,X), mezczyzna(X).
dziadek(X) :- dziadek(X,_), mezczyzna(X).
potomek(X,Y) :- dziecko(X,Y); wnuk(X,Y).

/* Czy Karol jest mężczyzną?
Czy Zuzanna jest kobietą?
Czyim dzieckiem jest Onufry?
Jakie córki ma Jacek?
Wypisz wszystkie pary Dziadek-Wnuk
Wypisz wszystkich potomków Magdy. */

corki_jacka :-
    corka(X, jacek),
    write(X), nl,
    fail.
corki_jacka.

dziadkowie_i_wnukowie :-
    dziadek(X,Y),
    write([Y,X]), nl,
    fail.
dziadkowie_i_wnukowie.

potomkowie_magdy :-
    potomek(X, magda),
    write(X), nl,
    fail.
potomkowie_magdy.



suma(wektor(X,Y,Z), wektor(A,B,C), wektor(P,Q,R)) :-
    P is X+A,
    Q is Y+B,
    R is Z+C.

iloczyn_skalarny(wektor(X,Y,Z), wektor(A,B,C), W) :-
    W is X*A + Y*B + Z*C.