:- use_module(library(clpfd)).

visibility(_, [], 0) :- !.
visibility(Pivot, [H|T], N) :-
        (
                H > Pivot -> visibility(H, T, N_), N is (N_ + 1);
                visibility(Pivot, T, N)
        ).

check_visibility([], []) :- true, !.
check_visibility([A|B], [H|T]) :-
        A =:= 0, check_visibility(B, T);
        visibility(0, H, N), N =:= A, check_visibility(B, T).

check_visibility_reversed([], []) :- true, !.
check_visibility_reversed([A|B], [H|T]) :-
        A =:= 0, check_visibility_reversed(B, T);
        reverse(H,Reversed_H), visibility(0, Reversed_H, N), N =:= A, check_visibility_reversed(B, T).
                                                            
sudoku(N, Rows, Left, Right, Top, Bottom) :-
        length(Rows, N), % retorna True se o numero de elementos na linha é n
        maplist(same_length(Rows), Rows), % verifica se cada linha tem um numero de colunas igual ao numero de linhas
        append(Rows, Vs), Vs ins 1..N, % estipula um intervalo no qual uma variavel Vs adicionada ao final de Rows deve estar
        maplist(all_distinct, Rows), % verifica se os elementos de todas as linhas são distintos
        transpose(Rows, Columns), % transpoe a tabuleiro 
        maplist(all_distinct, Columns), % verifica se os elementos de todas as colunas sao distintos
        maplist(label, Rows), % aplica a função label a cada linha para obter os valores presentes em cada posicao
        check_visibility(Left, Rows),
        check_visibility_reversed(Right, Rows),
        check_visibility(Top, Columns),
        check_visibility_reversed(Bottom, Columns).

problem(6, [[_ ,_ ,_ ,_ ,_, _],
            [_ ,_ ,_ ,_ ,_, _],
            [_ ,_ ,_ ,_ ,_, _],
            [_ ,_ ,_ ,_ ,_, _],
            [_ ,_ ,_ ,_ ,_ ,_],
            [_ ,_ ,_ ,_ ,_, _]]).

problem(5, [[_ ,_ ,_ ,_ ,_],
            [_ ,_ ,_ ,_ ,_],
            [_ ,_ ,_ ,_ ,_],
            [_ ,_ ,_ ,_ ,_],
            [_ ,_ ,_ ,_ ,_]]).
% 003
% problem(6, Rows), sudoku(6, Rows,[2,3,3,4,2,1], [2,4,2,3,1,4], [4,1,2,2,3,2],[1,3,5,2,4,2]), maplist(portray_clause, Rows).
% problem(5, Rows), sudoku(5, Rows, [1, 4, 3, 2, 0], [3, 2, 3, 0, 1], [0, 3, 3, 0, 0], [0, 2, 2, 2, 1]), maplist(portray_clause, Rows).
