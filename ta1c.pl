fase(ine5402, 1).
fase(mtm5161, 1).
fase(ine5403, 1).
fase(ine5401, 1).
fase(eel5105, 1).
fase(ine5404, 2).
fase(mtm7174, 2).
fase(ine5405, 2).
fase(mtm5512, 2).
fase(ine5406, 2).
fase(ine5407, 2).
fase(ine5408, 3).
fase(ine5410, 3).
fase(ine5409, 3).
fase(mtm5245, 3).
fase(ine5411, 3).
fase(ine5417, 4).
fase(ine5413, 4).
fase(ine5415, 4).
fase(ine5416, 4).
fase(ine5412, 4).
fase(ine5414, 4).
fase(ine5419, 5).
fase(ine5423, 5).
fase(ine5420, 5).
fase(ine5421, 5).
fase(ine5418, 5).
fase(ine5422, 5).
fase(ine5427, 6).
fase(ine5453, 6).
fase(ine5425, 6).
fase(ine5430, 6).
fase(ine5426, 6).
fase(ine5424, 6).
fase(ine5433, 7).
fase(ine5432, 7).
fase(ine5429, 7).
fase(ine5431, 7).
fase(ine5428, 7).
fase(ine5434, 8).
fase(xxxxxxx, 8).

disc(ine5402, poo_I).
disc(mtm5161, calculo_A).
disc(ine5403, f_m_discreta).
disc(ine5401, introd_comp).
disc(eel5105, circuitos).
disc(ine5404, poo_II).
disc(mtm7174, calculo_B).
disc(ine5405, prob_e_estat).
disc(mtm5512, ga).
disc(ine5406, sist_digitais).
disc(ine5407, cts).
disc(ine5408, ed).
disc(ine5410, prog_conc).
disc(ine5409, calc_num).
disc(mtm5245, algebra).
disc(ine5411, org_comp).
disc(ine5417, es_I).
disc(ine5413, grafos).
disc(ine5415, teoria_da_comp).
disc(ine5416, paradigmas).
disc(ine5412, so_I).
disc(ine5414, redes_I).
disc(ine5419, es_II).
disc(ine5423, bd_I).
disc(ine5420, comp_graf).
disc(ine5421, formais).
disc(ine5418, comp_dist).
disc(ine5422, redes_II).
disc(ine5427, p_e_gp).
disc(ine5453, intro_TCC).
disc(ine5425, mod_e_sim).
disc(ine5430, ia).
disc(ine5426, const_comp).
disc(ine5424, so_II).
disc(ine5433, tcc_I).
disc(ine5432, bd_II).
disc(ine5429, seg_comp).
disc(ine5431, sist_mult).
disc(ine5428, info_e_soc).
disc(ine5434, tcc_II).
disc(xxxxxxx, optativas).

prereq(ine5404, ine5402).
prereq(mtm7174, mtm5161).
prereq(ine5405, mtm5161).
prereq(ine5406, eel5105).
prereq(ine5408, ine5404).
prereq(ine5410, ine5404).
prereq(ine5409, mtm7174).
prereq(ine5409, mtm5512).
prereq(mtm5245, mtm5512).
prereq(ine5411, ine5406).
prereq(ine5417, ine5408).
prereq(ine5413, ine5408).
prereq(ine5413, ine5403).
prereq(ine5415, ine5408).
prereq(ine5415, ine5403).
prereq(ine5416, ine5408).
prereq(ine5412, ine5411).
prereq(ine5412, ine5410).
prereq(ine5414, ine5404).
prereq(ine5419, ine5417).
prereq(ine5423, ine5408).
prereq(ine5420, ine5408).
prereq(ine5420, mtm7174).
prereq(ine5420, mtm5245).
prereq(ine5421, ine5413).
prereq(ine5418, ine5412).
prereq(ine5418, ine5414).
prereq(ine5422, ine5414).
prereq(ine5427, ine5417).
prereq(ine5453, ine5417).
prereq(ine5425, ine5405).
prereq(ine5430, ine5405).
prereq(ine5430, ine5416).
prereq(ine5430, ine5413).
prereq(ine5426, ine5421).
prereq(ine5424, ine5412).
prereq(ine5433, ine5427).
prereq(ine5433, ine5453).
prereq(ine5432, ine5423).
prereq(ine5429, ine5403).
prereq(ine5429, ine5414).
prereq(ine5431, ine5414).
prereq(ine5428, ine5407).
prereq(ine5434, ine5433).

np(ine5402).
np(mtm5161).
np(ine5403).
np(ine5401).
np(eel5105).
np(ine5407).
np(mtm5512).
np(xxxxxxx).

disc(X, Y, Z) :- disc(X, Y), fase(X, Z).
prereq(X, Y, Z) :- prereq(X, Y), disc(Y, Z).
%Disciplinas que são pré-requisitos de pré-requisitos de uma disciplina
prepre(X, Y) :- prereq(X, Z), prereq(Z, Y).

%Árvore pré-requisitos de uma disciplina
todos_prereq(X, Z) :- prereq(X, Z).
todos_prereq(X, Z) :- prereq(X, Y), 
	todos_prereq(Y, Z).

%Duas Disciplinas que possuem pre-requisito comum
pre_comum(DISC_1, DISC_2) :-
	prereq(DISC_1, PRE),
	prereq(DISC_2, PRE).

%Duas disciplinas que possuem pre-requisito comum e são da mesma fase
pre_comum(DISC_1, DISC_2, FASE) :-
	fase(DISC_1, FASE),
	fase(DISC_2, FASE),	
	prereq(DISC_1, PRE),
	prereq(DISC_2, PRE),
	DISC_1 \= DISC_2.

%Duas disciplinas que possuem pre-requisito comum e são da mesma fase
pre_comum(DISC_1, DISC_2, PRE, FASE) :-
	fase(DISC_1, FASE),
	fase(DISC_2, FASE),	
	prereq(DISC_1, PRE),
	prereq(DISC_2, PRE),
	DISC_1 \= DISC_2.


%Facilitador de compreensão, se uma disciplina é pre requisito de outra, outra é "pós" requisito de uma
posreq(X, Y) :- prereq(Y, X).

%Disciplinas de uma determinada fase que tem pré-requisitos
fase_tp(FASE, DISC, PRE) :- 
	fase(DISC, FASE), 
	prereq(DISC, PRE).

%Disciplinas de uma determinada fase sem informar pré-requisito
fase_teste(FASE, DISC) :- 
	fase(DISC, FASE), 
	prereq(DISC, _).

%Disciplinas de uma determinada fase que tem pós-requisitos
fase_sp(FASE, PRE, DISC) :- 
	fase(PRE, FASE), 
	posreq(PRE, DISC).
%Disciplinas de uma determinada fase sem informar pós-requisitos
fase_spt(FASE, DISC) :- 
	fase(DISC, FASE), 
	posreq(DISC, _).
%Disciplinas de uma determinada fase que tem pré-requisitos em comum e são pré-requisitos de outras disciplinas
fase_pc(FASE, DISC_1, DISC_2, PRE_COMUM, POS_DISC_1, POS_DISC_2) :- 
	fase(DISC_1, FASE), 
	prereq(DISC_1, PRE_COMUM), 
	prereq(DISC_2, PRE_COMUM), 
	posreq(DISC_1, POS_DISC_1), 
	posreq(DISC_2, POS_DISC_2), 
	DISC_1 \= DISC_2.

%Funcoes Pré-Definidas
%Retorna o tamanho da lista

lenacc([ ], A, A).
lenacc([H|T], A, N) :- A1 is A + 1, lenacc(T, A1, N).
listlen(L, N) :- lenacc(L, 0, N).

%Concatena lista T com lista L2 e retorna Lista R
append([ ], L, L).
append([H|T], L2, [H|R]) :- append(T, L2, R).

%Retorna o maior valor
max([R], R).
max([X|Xs], R):-
    max(Xs, T),
    (X > T -> R = X ; R = T).

%Fim


%Encontra todas as disciplinas de uma determinada fase
disciplinas_de_uma_fase(FASE, L) :- findall(X, fase(X, FASE), L).

%Retorna a quantidade de disciplinas de uma determinada fase
quantidade_de_disciplinas(FASE, N) :- disciplinas_de_uma_fase(FASE,L), listlen(L, N).

%Retorna o valor de todas as disciplinas do curso, desde a fase 1 até a fase 8
disciplinas_no_curso(N) :- quantidade_de_disciplinas(_, N).

%Encontra todas as disciplinas que possuem pré-requisitos
disciplinas_com_prereq(L) :-  setof(X, FASE ^ fase_teste(FASE,X), L).

%Encontra todas as disciplinas são pós
disciplinas_tem_posreq(L) :-  setof(X, FASE ^ fase_spt(FASE,X), L).

%Retorna a quantia de disciplinas que possuem pré-requisitos
quantidade_tem_prereq(N) :- disciplinas_com_prereq(R), listlen(R, N).

%Retorna a quantia de disciplinas que são pré-requisitos
quantidade_sao_posreq(N) :- disciplinas_tem_posreq(R), listlen(R, N).

%Retorna as disciplinas que são pré-requisitos de uma determinada disciplina
disciplinas_sao_prereq(L,DISC):-setof(X, todos_prereq(DISC, X), L).

%Retorna a quantia de pré-requisitos de uma determinada disciplina
quantidade_de_prereq(DISC,QUANTIA) :- disciplinas_sao_prereq(L,DISC),listlen(L, QUANTIA).

%Retorna a Disciplina que tem a maior quantia de pre-requisitos.
maiorprereq(N) :- findall(Z, quantidade_de_prereq(_, Z), QtdPre),
    max(QtdPre, K), quantidade_de_prereq(N, K).

%Gera Lista com Pós-requisitos de uma disciplinas.
pos_req_de_uma_disciplina(L, DISC) :-
    setof(X, todos_prereq(X, DISC), L).

%Retorna quantia de matérias que são pós requisitos.
quantidade_de_posreq(DISC, QUANTIA) :-
    pos_req_de_uma_disciplina(L, DISC),
    listlen(L, QUANTIA).
%Retorna a Disciplina que é pre-requisito para a maior quantia de disciplinas .
maiorposreq(N) :- findall(Z, quantidade_de_posreq(_, Z), QtdPre),
    max(QtdPre, K), quantidade_de_posreq(N, K).
