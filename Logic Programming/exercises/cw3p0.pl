dodaj(0, Y, Y).
dodaj(X, Y, Z) :- Z >= 0, X>=0, X1 is X-1, Z1 is Z-1, dodaj(X1, Y, Z1).

append([], Y, Y).
append([H|T], Y, [H|Z]) :- append(T,Y,Z).

from_to(M,M,[M]).
from_to(N,M,[N|L1]):-N<M, N1 is N+1, from_to(N1,M,L1).

