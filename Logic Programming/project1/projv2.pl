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

% Example usage:
% path([[o, x, x, x, x], [o, o, o, o, x], [x, o, x, o, x], [x, o, x, o, x], [x, o, o, o, x], [o, o, x, x, x]], [1,1], [5,1], Path).
% Path = [[5, 1], [5, 2], [4, 2], [3, 2], [2, 2], [2, 1], [1, 1]].

display_lab(Labyrinth, Path) :-
    display_lab_with_path(Labyrinth, Path, 1, 1).

display_lab_with_path([], _, _, _).
display_lab_with_path([H|T], Path, Row, Col) :-
    display_row_with_path(H, Path, Row, 1),
    nl,
    NewRow is Row + 1,
    display_lab_with_path(T, Path, NewRow, Col).

display_row_with_path([], _, _, _).
display_row_with_path([o|T], Path, Row, Col) :-
    (member([Row, Col], Path) -> write('. '); write('  ')),
    NewCol is Col + 1,
    display_row_with_path(T, Path, Row, NewCol).
display_row_with_path([x|T], _, Row, Col) :-
    write('x '),
    NewCol is Col + 1,
    display_row_with_path(T, _, Row, NewCol).

% Example usage:
% display_lab([[o, x, o], [o, x, o], [o, o, o]], [[1, 1], [2, 1], [3, 1], [3, 2], [3, 3], [2, 3], [1, 3]]).


