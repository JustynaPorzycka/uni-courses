append([], Y, Y).
append([H|T], Y, [H|Z]) :- append(T,Y,Z).

ostatni([],_):-false.
ostatni([X],X).
ostatni([_|T],X):-ostatni(T,X).

prefix([],_).
prefix([H|T1],[H|T2]):-prefix(T1,T2).


podlista(X,Y):-prefix(X,Y).
podlista(X,[_|T]):- podlista(X,T).

wstaw(X,[],Wynik):-Wynik=[X].
wstaw(X,[H|T],Wynik):-X=<H, Wynik=[X,H|T].
wstaw(X,[H|T],Wynik):- X>H, wstaw(X,T,Wynik2), append([H],Wynik2,Dodane), Wynik=Dodane.

sortuj(A,B) :- sortuj(A,[],B).
sortuj([],Acc,B) :- B=Acc.
sortuj([H|T],[],B) :- sortuj(T,[H],B).
sortuj([H|T], Acc,B) :- Acc\=[], wstaw(H,Acc,Wstawione), sortuj(T, Wstawione, B).

podlista2([],_).
podlista2([H|T],[H1|T2]):-H=H1, podlista2(T,T2).
podlista2(X,[_|T2]):-podlista2(X,T2).

# usun_element([E],E,L2):-L2=[].
# usun_element([H|T], E, L2):-H=E, L2=T.



# wybierz([X],El,R):-El=X,R=[].
# wybierz(L,El,R):-

# permutacja([],B):-B=[].
# permutacja(X,B)


