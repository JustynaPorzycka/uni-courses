display_lab([]).
display_lab([H|T]) :- 
    display_line(H), 
    nl, 
    display_lab(T).

display_line([]).
display_line([x|T]) :- 
    write('x '), 
    display_line(T).
display_line([o|T]) :- 
    write('  '), 
    display_line(T).

path(Labyrinth, Start, End, Path) :-
    path_helper(Labyrinth, Start, End, [Start], Path).

path_helper(_, [X, Y], [X, Y], ReversedPath, Path) :-
    reverse(ReversedPath, Path).
path_helper(Labyrinth, [X, Y], End, Visited, Path) :-
    neighbor([X, Y], Next),
    valid_move(Labyrinth, Next),
    \+ member(Next, Visited),
    path_helper(Labyrinth, Next, End, [Next | Visited], Path).

valid_move(Labyrinth, [X, Y]) :-
    nth1(X, Labyrinth, Row),
    nth1(Y, Row, o).

neighbor([X, Y], [X1, Y]) :- X1 is X + 1.
neighbor([X, Y], [X1, Y]) :- X1 is X - 1.
neighbor([X, Y], [X, Y1]) :- Y1 is Y + 1.
neighbor([X, Y], [X, Y1]) :- Y1 is Y - 1.

display_lab_with_path(Labyrinth, Path) :-
    display_rows_with_path(Labyrinth, Path, 1).

display_rows_with_path([], _, _).
display_rows_with_path([Row|Rest], Path, RowNumber) :-
    display_row_with_path(Row, Path, RowNumber, 1),
    nl,
    NextRow is RowNumber + 1,
    display_rows_with_path(Rest, Path, NextRow).

display_row_with_path([], _, _, _).
display_row_with_path([Cell|Rest], Path, Row, Col) :-
    display_cell_with_path(Cell, Path, Row, Col),
    NextCol is Col + 1,
    display_row_with_path(Rest, Path, Row, NextCol).

display_cell_with_path('x', _, _, _) :- write('x ').
display_cell_with_path('o', Path, Row, Col) :-
    (member([Row, Col], Path) -> write('. '); write('  ')).
display_cell_with_path(' ', _, _, _) :- write('  ').



labyrinth([[o, x, x, x, x], [o, o, o, o, x], [x, o, x, o, x], [x, o, x, o, x], [x, o, o, o, x], [o, o, x, x, x]]).
?- labyrinth(Lab), path(Lab,[2,1],[5,4],Path), display_lab_with_path(Lab, Path).