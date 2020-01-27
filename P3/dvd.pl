% Relacao de filmes
%    filme(id, titulo, ano, diretor, nacionalidade).
%
filme(f1, 'Monty Python: O Sentido da Vida', 1983, 'Terry Jones', uk).
filme(f2, 'Edukators', 2004, 'Hans Weingartner', de).
filme(f3, 'Lavoura Arcaica', 2001, 'Luiz Fernando Carvalho', br).
filme(f4, 'Lisbela e o Prisioneira', 2003, 'Guel Arraes', br).
filme(f5, 'Abril despedacado', 2001, 'Walter Salles', br).
filme(f6, 'Diarios de motocicleta', 2004, 'Walter Salles', br).

% Relacao de paises
%     pais(sigla, nome).
%
pais(uk, 'Unided Kingdom').
pais(de, 'Alemanha').
pais(br, 'Brasil').

% Relacao de DVD (a caixa em si)
%     dvd(id do DVD, id do filme, estante).
%
dvd(d1, f1, est1).
dvd(d2, f2, est1).
dvd(d4, f4, est1).
dvd(d3, f3, est2).
dvd(d5, f5, est3).
dvd(d6, f1, est1).
dvd(d7, f2, est4).
dvd(d8, f2, est4).

% Relacao de clientes
%     cliente(cod, nome, telefone).
%
cliente(c1, 'Bob', '333-3112').
cliente(c2, 'Zeca', '245-1099').
cliente(c3, 'Tom', '323-0685').
cliente(c4, 'Bianca', '333-4391').
cliente(c5, 'Alice', '251-7439').
cliente(c6, 'Maria', '212-3271').

% Relacao de locacoes
%     locacao(cod cliente, nro do DVD, data de entrega)
%
locacao(c1, d1, '2005-11-07').
locacao(c1, d2, '2005-11-07').
locacao(c3, d5, '2005-11-09').
locacao(c2, d3, '2005-11-10').
locacao(c3, d3, '2005-11-11').
locacao(c4, d8, '2005-11-12').
locacao(c5, d7, '2005-11-12').
locacao(c6, d6, '2005-11-12').
locacao(c1, d5, '2005-11-13').
locacao(c1, d6, '2005-11-13').
locacao(c6, d2, '2005-11-14').
locacao(c3, d7, '2005-11-14').
locacao(c3, d8, '2005-11-14').
locacao(c5, d1, '2005-11-15').

% Questao 1. A. Foi utilizado um findall, primeiramente recuperando o código do DVD com o título correspondente e verificando
% se existem duas locacoes de clientes diferentes, logo após ordenando e eliminando as reperidas com um sort.
umA(R) :-
    findall(T, (filme(IF,T,_,_,_), dvd(ID, IF,_), locacao(C1, ID, _), locacao(C2, ID, _), C2 \== C1), R_), sort(R_, R).
/*
1 ?- umA(R).
R = ['Abril despedacado', 'Edukators', 'Lavoura Arcaica', 'Monty Python: O Sentido da Vida'].
*/

% Questao 1. B.
% Esta regra recebe uma lista e retorna uma lista contendo apenas os ultimos elementos. Vamos utiliza-la para
% recuperar o dia da locacao.
doisUltimos([H,T], [H,T]) :- !.
doisUltimos([_,_|T], LF) :-
    doisUltimos(T, LF).
% Aqui fazemos um findall, recuperando o pais para cada locacao. Para comparar as datas, primeiramente convertemos a string
% para uma lista. Depois, recuperamos os dois ultimos elementos da lista e criamos uma string, concatenando-os. Finalmente, essa
% string é transformada em um átomo de número, podendo-o então comparar com o dia 11 e o dia 14.
umB(R) :-
    findall(NP, (cliente(C, 'Tom', _), locacao(C, Dvd, DataS), string_to_list(DataS, DataL), doisUltimos(DataL, DiaL), atom_chars(DiaN, DiaL)
    , atom_number(DiaN, DiaF), DiaF =< 14, DiaF >= 11, dvd(Dvd, F, _), filme(F, _, _, _, P), pais(P, NP)), R). 

/*
1 ?- umB(R).
R = ['Brasil', 'Alemanha', 'Alemanha'].
*/

% Letra C:

% Pega duas locaoes, um

c(Quantidade) :- findall(Id,
	(
	locacao(c1, IdDvd, _), locacao(c3, IdDvd, _), dvd(IdDvd, Id, _), filme(Id, _, _, _, Nacionalidade), pais(Nacionalidade, NomePais), NomePais \== 'Brasil'
	),
	Filmes),
	leng(Filmes, Quantidade).




% Letra D: 

% cria conjuntos de elementos agrupados pelo Nome do pais (Pais), ignorando os outros atibutos que não sao necessarios (Ano, Cod, Id, Diretor)

% setof(Titulo, Ano ^ Cod ^ Id ^ Diretor ^ (pais(Cod, Pais), filme(Id, Titulo, Ano, Diretor, Cod), Ano > 2000), Filmes).
/*
1 ?- setof(Titulo, Ano ^ Cod ^ Id ^ Diretor ^ (pais(Cod, Pais), filme(Id, Titulo, Ano, Diretor, Cod), Ano > 2000), Filmes).
Pais = 'Alemanha',
Filmes = ['Edukators'] ;
Pais = 'Brasil',
Filmes = ['Abril despedacado', 'Diarios de motocicleta', 'Lavoura Arcaica', 'Lisbela e o Prisioneira'].
*/


% Questao 2
% simplesmente adiciona o primeiro elemento da lista ao final, realizando a rotacao.

rotacionar([H|T], L) :- concat(T, [H], L).


rotacoes(Lista, L) :- rotacionar(Lista, L), L \== Lista.


% Questao 3
% Pega-se todas as possibilidades de jogadas que pode-se obter em D lancamentos usando-se a funcao solucao, e depois verifica-se em quais a soma dos valores dos dados(que e obtida com a funcao soma), é igua a S


lado(1).
lado(2).
lado(3).
lado(4).
lado(5).
lado(6).

possibilidades(0, []) :- !.
possibilidades(N, [H|Resto]) :- lado(H),
						   N1 is N - 1,
						   possibilidades(N1, Resto).

solucao(N, L) :- possibilidades(N,L).

soma([], 0) :- !.
soma([H|T], Valor) :- soma(T, Valor_), Valor is H + Valor_.

dados(D, S, L) :- solucao(D, L), soma(L, Valor), Valor =:= S. 


% ?- dados_(4, 8, L).
% L = [1, 1, 1, 5] ;
% L = [1, 1, 2, 4] ;
% L = [1, 1, 3, 3] ;
% L = [1, 1, 4, 2] ;
% L = [1, 1, 5, 1] ;
% L = [1, 2, 1, 4] ;
% L = [1, 2, 2, 3] ;
% L = [1, 2, 3, 2] ;
% L = [1, 2, 4, 1] ;
% L = [1, 3, 1, 3] ;
% L = [1, 3, 2, 2] ;
% L = [1, 3, 3, 1] ;
% L = [1, 4, 1, 2] ;
% L = [1, 4, 2, 1] ;
% L = [1, 5, 1, 1] ;
% L = [2, 1, 1, 4] ;
% L = [2, 1, 2, 3] ;
% L = [2, 1, 3, 2] ;
% L = [2, 1, 4, 1] ;
% L = [2, 2, 1, 3] ;
% L = [2, 2, 2, 2] ;
% L = [2, 2, 3, 1] ;
% L = [2, 3, 1, 2] ;
% L = [2, 3, 2, 1] ;
% L = [2, 4, 1, 1] ;
% L = [3, 1, 1, 3] ;
% L = [3, 1, 2, 2] ;
% L = [3, 1, 3, 1] ;
% L = [3, 2, 1, 2] ;
% L = [3, 2, 2, 1] ;
% L = [3, 3, 1, 1] ;
% L = [4, 1, 1, 2] ;
% L = [4, 1, 2, 1] ;
% L = [4, 2, 1, 1] ;
% L = [5, 1, 1, 1] ;
% false.