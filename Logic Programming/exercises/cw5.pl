wygrywa(L, K, X) :- member(X,L), X>=K.
wygrywa(L, K, X) :- member(X,L), X<K, K1 is K-X, \+ wygrywa(L,K1,Y).

graj(L,K) :- member(X,L), wygrywa(L,K,X), X>=K, write('Liczba='), writeln(X).
graj(L,K) :- wygrywa(L,K,X), write('Liczba='), writeln(X), 
             write('Podaj liczbe z listy '), write(L), read(Z), W is X+Z, W>=K, write('Wygrales.').
graj(L,K) :- wygrywa(L,K,X), write('Liczba='), writeln(X), 
             write('Podaj liczbe z listy '), write(L), read(Z), W is X+Z, W<K, K1 is K-W, graj(L,K1).


graj(L,K) :- wygrywa(L,K,X), X>=K, write('Wygralem, moja liczba: '), writeln(X).
graj(L,K) :- wygrywa(L,K,X), X<K, write('Mój ruch: '), writeln(X), 
             write('Podaj liczbe z listy '), write(L), read(Z), 




