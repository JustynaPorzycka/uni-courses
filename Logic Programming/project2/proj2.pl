canvas(W, H, S) :-
    canvas_row(W, Row),
    canvas_rows(H, Row, S).

canvas_row(0, []).
canvas_row(W, [' ' | Rest]) :-
    W > 0,
    W1 is W - 1,
    canvas_row(W1, Rest).

canvas_rows(0, _, []).
canvas_rows(H, Row, [Row | Rest]) :-
    H > 0,
    H1 is H - 1,
    canvas_rows(H1, Row, Rest).

% ===========================================================================

point(S1, [X, Y], Z, S2) :-
    point_rows(S1, [X, Y], Z, 0, S2).

point_rows([], _, _, _, []).
point_rows([Row|Rest], [X, Y], Z, CurrentY, [NewRow|NewRest]) :-
    CurrentY =\= Y,
    NewRow = Row,
    NextY is CurrentY + 1,
    point_rows(Rest, [X, Y], Z, NextY, NewRest).
point_rows([Row|Rest], [X, Y], Z, Y, [NewRow|NewRest]) :-
    point_row(Row, X, Z, 0, NewRow),
    NextY is Y + 1,
    point_rows(Rest, [X, Y], Z, NextY, NewRest).

point_row([], _, _, _, []).
point_row([_|Rest], X, Z, CurrentX, [Z|NewRest]) :-
    CurrentX =:= X,
    NextX is CurrentX + 1,
    point_row(Rest, X, Z, NextX, NewRest).
point_row([Elem|Rest], X, Z, CurrentX, [Elem|NewRest]) :-
    CurrentX =\= X,
    NextX is CurrentX + 1,
    point_row(Rest, X, Z, NextX, NewRest).

% ===========================================================================

line(S1, [X1, Y1], [X1, Y1], Z, S2) :-
    point(S1, [X1, Y1], Z, S2).
line(S1, [X1, Y1], [X2, Y2], Z, S2) :-
    check_if_in_line([X1, Y1], [X2, Y2]),
    draw_line(S1, [X1, Y1], [X2, Y2], Z, S2).

check_if_in_line([X1, Y1], [X1, Y2]) :- 
    Y1 \= Y2.
check_if_in_line([X1, Y1], [X2, Y1]) :- 
    X1 \= X2.
check_if_in_line([X1, Y1], [X2, Y2]) :- 
    X1 \= X2, Y1 \= Y2, DiffX is abs(X1 - X2), DiffY is abs(Y1 - Y2), DiffX =:= DiffY.

generate_points([X, Y], [X, Y], [[X, Y]]) :- !.
generate_points([X, Y1], [X, Y2], [[X, Y1] | Rest]) :-
    Y1 < Y2,
    NextY is Y1 + 1,
    generate_points([X, NextY], [X, Y2], Rest).
generate_points([X, Y1], [X, Y2], A) :-
    Y1 > Y2,
    generate_points([X, Y2], [X, Y1], A).
generate_points([X1, Y], [X2, Y], [[X1, Y] | Rest]) :-
    X1 < X2,
    NextX is X1 + 1,
    generate_points([NextX, Y], [X2, Y], Rest).
generate_points([X1, Y], [X2, Y], A) :-
    X1 > X2,
    generate_points([X2, Y], [X1, Y], A).
generate_points([X1, Y1], [X2, Y2], [[X1, Y1] | Rest]) :-
    X1 < X2, Y1 < Y2,
    NextX is X1 + 1,
    NextY is Y1 + 1,
    generate_points([NextX, NextY], [X2, Y2], Rest).  
generate_points([X1, Y1], [X2, Y2], [[X1, Y1] | Rest]) :-  
    X1 > X2, Y1 > Y2,
    generate_points([X2, Y2], [X1, Y1], Rest). 
generate_points([X1, Y1], [X2, Y2], [[X1, Y1] | Rest]) :-
    X1 < X2, Y1 > Y2,
    NextX is X1 + 1,
    NextY is Y1 - 1,
    generate_points([NextX, NextY], [X2, Y2], Rest).  
generate_points([X1, Y1], [X2, Y2], [[X1, Y1] | Rest]) :-  
    X1 > X2, Y1 < Y2,
    generate_points([X2, Y2], [X1, Y1], Rest). 

draw_line(S1, [X1, Y1], [X2, Y2], Z, S2) :-
    generate_points([X1, Y1], [X2, Y2], GenPoints),
    draw_pixel(S1, GenPoints, Z, S2).

draw_pixel(S1, [P], Z, S2):-
    point(S1, P, Z, S2).
draw_pixel(S1, [P | Rest], Z, S2):-
    Rest \= [],
    point(S1, P, Z, S3),
    draw_pixel(S3, Rest, Z, S2).

% ===========================================================================

poly(S1, ListPoints, Z, S2):-
    poly_helper(S1, ListPoints, Z, S3, LastPoint),
    [FirstPoint | _] = ListPoints,
    line(S3, FirstPoint, LastPoint, Z, S2).

poly_helper(S1, [P1, P2], Z, S2, LastPoint):-
    line(S1, P1, P2, Z, S2),
    LastPoint = P2.
poly_helper(S1, [P1, P2 | Rest], Z, S2, LastPoint) :-
    line(S1, P1, P2, Z, S3),
    poly_helper(S3, [P2 | Rest], Z, S2, LastPoint).

% ===========================================================================

clean(S1, X1, Y1, X2, Y2, S2) :-
    clean_rows(S1, X1, Y1, X2, Y2, 0, S2).

clean_rows([], _, _, _, _, _, []).
clean_rows([Row|Rest], X1, Y1, X2, Y2, CurrentY, [NewRow|NewRest]) :-
    (CurrentY < Y1 ; CurrentY > Y2),
    NewRow = Row,
    NextY is CurrentY + 1,
    clean_rows(Rest, X1, Y1, X2, Y2, NextY, NewRest).
clean_rows([Row|Rest], X1, Y1, X2, Y2, CurrentY, [CleanedRow|NewRest]) :-
    (CurrentY >= Y1, CurrentY =< Y2),
    clean_row(Row, X1, X2, 0, CleanedRow),
    NextY is CurrentY + 1,
    clean_rows(Rest, X1, Y1, X2, Y2, NextY, NewRest).

clean_row([], _, _, _, []).
clean_row([Elem|Rest], X1, X2, CurrentX, [CleanedElem|NewRest]) :-
    (CurrentX < X1 ; CurrentX > X2),
    CleanedElem = Elem,
    NextX is CurrentX + 1,
    clean_row(Rest, X1, X2, NextX, NewRest).
clean_row([_|Rest], X1, X2, CurrentX, [' '|NewRest]) :-
    (CurrentX >= X1, CurrentX =< X2),
    NextX is CurrentX + 1,
    clean_row(Rest, X1, X2, NextX, NewRest).

% ===========================================================================

copy(S1, X, Y, S2, S3) :- 
    canvas_size(S2, W, H),
    NewW is W + X, 
    NewH is H + Y,
    overlay(S1, 0, X, Y, NewW, NewH, S2, S3).

canvas_size(S1, Width, Height) :-
    length(S1, Height),
    ( Height > 0 -> 
        nth0(0, S1, Row),
        length(Row, Width)
    ; 
        Width = 0
    ).

overlay([], _, _, _, _, _, _, []).
overlay([CurrentRow|Rest], CurrentY, StartX, StartY, EndX, EndY, S2, Result) :- 
    CurrentY < StartY, 
    NextY is CurrentY + 1, 
    overlay(Rest, NextY, StartX, StartY, EndX, EndY, S2, RestResult),  Result = [CurrentRow|RestResult].
overlay([CurrentRow|Rest], CurrentY, StartX, StartY, EndX, EndY, [RowS2|RowsS2], Result) :- 
    CurrentY >= StartY,
    CurrentY < EndY,
    NextY is CurrentY + 1, 
    overlay(Rest, NextY, StartX, StartY, EndX, EndY, RowsS2, RestResult), 
    overlay_row(CurrentRow, 0, StartX, EndX, RowS2, RowResult),  Result = [RowResult|RestResult].

overlay_row([], _, _, _, _, []).
overlay_row([Element|Rest], CurrentX, StartX, EndX, RowS2, Result) :- 
    CurrentX < StartX,
    NextX is CurrentX + 1,
    overlay_row(Rest, NextX, StartX, EndX, RowS2, RestResult),  
    Result = [Element|RestResult].
overlay_row([_|Rest], CurrentX, StartX, EndX, [HS2|TS2], Result) :- 
    CurrentX >= StartX,
    CurrentX < EndX, 
    NextX is CurrentX + 1,  
    overlay_row(Rest, NextX, StartX, EndX, TS2, RestResult), !, Result = [HS2|RestResult].


















