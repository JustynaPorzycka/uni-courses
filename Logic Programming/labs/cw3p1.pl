liczba(0).
liczba(s(X)) :- liczba(X).

dodaj(0, Y, Y).
dodaj(s(X), Y, s(Z)) :- dodaj(X, Y, Z).

mniejszy(0,0):- false.
mniejszy(_,0):-false.
mniejszy(0,_) :- true. 
mniejszy(s(X),s(Y)) :- mniejszy(X,Y).


mnoz(X,Y,Z):- mnoz(X,Y,0,Z).
mnoz(0,0,_,Z):- Z=0.
mnoz(0,_,_,Z):-Z=0.
mnoz(_,0,_,Z):-Z=0.
mnoz(s(0),X,Acc,Z):-dodaj(Acc,X,Acc2),Z=Acc2.
mnoz(X, s(0),Acc,Z):-dodaj(Acc,X,Acc2),Z=Acc2.
mnoz(X,s(Y),Acc,Z):- dodaj(Acc,X,Acc2), mnoz(X,Y,Acc2,Z).



