/*
   Programacao Logica - Prof. Alexandre G. Silva - 30set2015
   
   RECOMENDACOES:
   
   - O nome deste arquivo deve ser 'programa.pl'
   
   - O nome do banco de dados deve ser 'desenhos.pl'
   
   - Dicas de uso podem ser obtidas na execucação: 
     ?- menu.
     
   - Exemplo de uso:
     ?- load.
     ?- searchAll(id1).
     
   - Matheus Alves <14200754>
   - João Colombo <14200741>
   - Guilherme Reinaldo <151

   */

% Apaga os predicados 'xy' da memoria e carrega os desenhos a partir de um arquivo de banco de dados
load :-
    retractall(xy(_,_,_)),
    open('desenhos.pl', read, Stream),
    repeat,
        read(Stream, Data),
        (Data == end_of_file -> true ; assert(Data), fail),
        !,
        close(Stream).

% Ponto de deslocamento, se <Id> existente
new(Id,X,Y) :-
    xy(Id,_,_),
    assertz(xy(Id,X,Y)),
    !.

% Ponto inicial, caso contrario
new(Id,X,Y) :-
    asserta(xy(Id,X,Y)),
    !.

% Exibe opcoes de busca
search :-
    write('searchAll(Id).     -> Ponto inicial e todos os deslocamentos de <Id>'), nl,
    write('searchFirst(Id,N). -> Ponto inicial e os <N-1> primeiros deslocamentos de <Id>'), nl,
    write('searchLast(Id,N).  -> Lista os <N> ultimos deslocamentos de <Id>').

searchFirst(Id, N) :-
    findall(
                PONTOS,
                (
                    xy(Id, X, Y),
                    append([Id], [X], LCORDX),
                    append(LCORDX, [Y], PONTOS)
                ), 
                LTODOS
            ),
    between(1, N, PRIMEIRO),
    nth1(PRIMEIRO, LTODOS, ELEMENTO), 
    print(ELEMENTO), nl, 
    false.
searchLast(Id, N) :-
    findall(
                PONTOS,
                (
                    xy(Id, X, Y),
                    append([Id], [X], LCORDX),
                    append(LCORDX, [Y], PONTOS)
                ), 
                LTODOS
            ),
    length(LTODOS,Tamanho),
    Inicio is Tamanho-N,
    between(Inicio, Tamanho, PRIMEIRO),
    nth0(PRIMEIRO, LTODOS, ELEMENTO), 
    print(ELEMENTO), nl, 
    false.

searchAll(Id) :-
    listing(xy(Id,_,_)).

% Exibe opcoes de alteracao
change :-
    write('change(Id,X,Y,Xnew,Ynew).  -> Altera um ponto de <Id>'), nl,
    write('changeFirst(Id,Xnew,Ynew). -> Altera o ponto inicial de <Id>'), nl,
    write('changeLast(Id,Xnew,Ynew).  -> Altera o deslocamento final de <Id>').

% Altera um ponto especifico de <ID>
change(Id, X, Y, Xnew, Ynew) :-
    (findall(
                PONTOS,
                (
                    xy(Idgeneric, Xgeneric, Ygeneric), 
                    append([Idgeneric], [Xgeneric], LCORDX), 
                    append(LCORDX, [Ygeneric], PONTOS)
                ),
                TODOS
            ),
    length(TODOS, Tamanho),
    retractall(xy(_,_,_)),
    retractall(log(_,_,_)),
    between(0, Tamanho, PRIMEIRO),
    nth0(PRIMEIRO, TODOS, ELEMENTO),
    nth0(0, ELEMENTO, NOVOID),
    nth0(1, ELEMENTO, NOVOX),
    nth0(2, ELEMENTO, NOVOY),
    (
        Id = NOVOID, X = NOVOX , Y = NOVOY ->
            new(Id, Xnew, Ynew);
        new(NOVOID, NOVOX, NOVOY)), false
    );
    true.

% Altera o ponto Inicio de <ID>
changeFirst(Id, Xnew, Ynew) :-
    remove(Id, _, _), !,
    asserta(xy(Id, Xnew, Ynew)), !.

changeLast(Id,NOVOX, NOVOY) :-
    findall(
                PONTOS,
                (
                    xy(Id, X, Y),
                    append([Id], [X], LCORDX),
                    append(LCORDX, [Y], PONTOS)
                ),
                TODOS
            ),
    last(TODOS, Elem),
    nth0(0, Elem, K), % Id
    nth0(1, Elem, J), % X
    nth0(2, Elem, L), % Y
    remove(K, J, L),
    assertz(xy(Id, NOVOX, NOVOY)).

remove :-
    write('remove(Id,X,Y). -> Remove o deslocamento de <Id>'), nl,
    write('removeAll(Id).  -> Remove todos os pontos e deslocamentos de <Id>').

% Remove um deslocamento ou ponto
remove(Id,X,Y) :- retract(xy(Id,X,Y)).

% Remove todos os pontos e deslocamentos

removeAll(Id) :- retractall(xy(Id, _, _)), !.

% Remove ultima alteracao
undo :-
  log(E, P, K),
  retract(log(E, P, K)),
  remove(E, P, K), !.

% Grava os desenhos da memoria em arquivo
commit :-
    open('desenhos.pl', write, Stream),
    telling(Screen),
    tell(Stream),
    listing(xy),
    tell(Screen),
    close(Stream).

quadrado(Id, POSX, POSY, TAMANHO) :-
    NTAMANHO is TAMANHO*(-1),
    new(Id, POSX, POSY),
    new(Id, TAMANHO, 0),
    new(Id, 0, TAMANHO),
    new(Id, NTAMANHO, 0).
triangulo(Id, ALTURA, POSX, POSY) :-

    NPOSY is POSY*(-1),
    new(Id, POSY, POSX),
    new(Id, POSY, ALTURA), %Base Direita
    new(Id, NPOSY, 0).     %Base Esquerda

% Exibe menu principal
menu :-
    write('load.        -> Carrega todos os desenhos do banco de dados para a memoria'), nl,
    write('new(Id,X,Y). -> Insere um deslocamento no desenho com identificador <Id>'), nl,
    write('                (se primeira insercao, trata-se de um ponto inicial)'), nl,
    write('search.      -> Consulta pontos dos desenhos'), nl,
    write('change.      -> Modifica um deslocamento existente do desenho'), nl,
    write('remove.      -> Remove um determinado deslocamento existente do desenho'), nl,
    write('undo.        -> Remove o deslocamento inserido mais recentemente'), nl,
    write('commit.      -> Grava alteracoes de todos dos desenhos no banco de dados').
