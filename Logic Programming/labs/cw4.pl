silnia(N,S):-silnia(N,1,S).

silnia(0,Acc,S):-S=Acc.
silnia(1,Acc,S):-S=Acc.
silnia(N,Acc,S):-N1 is N-1, Acc2 is Acc*N, silnia(N1,Acc2,S).

fib(0,1).
fib(1,1).
fib(N,F):-fib(N,1,1,F).

fib(N,A,B,F):- N>1, A1=B, B1 is A+B, N1 is N-1, fib(N1,A1,B1,F).
fib(1,_,B,B). 


sumy(L,X,Y):-sumy(L,0,0,X,Y).
sumy([],D,U,D,U).
sumy([H|T],D,U,X,Y):-H>0, D1 is D+H, sumy(T,D1,U,X,Y).
sumy([H|T],D,U,X,Y):-H=<0, U1 is U+H, sumy(T,D,U1,X,Y).

# Napisz predykat spłaszcz(L, P), wyznaczający liste P będącą spłaszczeniem listy L.

# Przykład:
# splaszcz([a, [1, [ b, [], c ], a, 1]], P).
# P = [a,1,b,c,a,1]

splaszcz(L,P):-splaszcz(L,A,P).
splaszcz([],A,A).

r(N,V):-r(N,0,V).
r(0,S,V):- V is S+1.
r(N,S,V):- N1 is N-1, S1 is ((2*S)+1), r(N1,S1,V).

