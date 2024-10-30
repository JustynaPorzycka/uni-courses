modul(X,Y):- X>=0, Y=X.
modul(X,Y):-X<0, Y is X+(-2)*X.

silnia(0,S):-S=1.
silnia(N,S):- N>0, N1 is N-1, silnia(N1,S1), S is S1*N.

suma(0,S):-S=0.
suma(N,S):- N>=0, N1 is N-1, suma(N1,S1), S is S1+N.

/* Zdefiniuj predykaty delta(A,B,C,D) i pierw(A,B,C,X) 
pozwalające na wyznaczenie delty i pierwiastków równania 
kwadratowego Ax^2+Bx+C = 0. Predykat delta powinien uzgadniać 
argument D z deltą równania kwadratowego. Predykat pierw 
powinien uzgadniać argument X z kolejnymi pierwiastkami równania. */


delta(A,B,C,D):- D is B*B- 4*A*C.

pierw(A,B,C,X):- delta(A,B,C,D), D=:=0, X is (-B)/(2*A).
pierw(A,B,C,X):- delta(A,B,C,D), D>0, ((X is ((-B) - sqrt(D))/(2*A)) ; (X is ((-B) + sqrt(D))/(2*A))).
