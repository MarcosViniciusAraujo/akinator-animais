/*
	Grupo constituído por:

		- Felipe F Gonzalez = 1910438
		- Fernando Lobo = 1712090
		- Gabriel MacGregor =  
		- Marcos Vinicius Araujo Almeida = 1910869

*/



:- dynamic resposta_sim_no_interno/2.
	resposta_sim_no_interno("Eh um mamifero?", "Tem listras?").
	resposta_sim_no_interno("Eh uma ave?", "Ele voa?").



:- dynamic resposta_nao_no_interno/2.
	resposta_nao_no_interno("Eh um mamifero?", "Eh uma ave?").



:- dynamic resposta_sim_no_folha/2.
	resposta_sim_no_folha("Tem listras?", "zebra").
	resposta_sim_no_folha("Ele voa?", "aguia").



:- dynamic resposta_nao_no_folha/2.
	resposta_nao_no_folha("Eh uma ave?", "lagarto").
	resposta_nao_no_folha("Tem listras?", "leao").
	resposta_nao_no_folha("Ele voa?", "pinguin").
	resposta_nao_no_folha("Eh um passaro?", "lagarto").






pergunta(Perg, Resposta) :-
    write(">>> "), write(Perg), nl,
	
    read(Input), nl,
    (
		(Input=n -> (resposta_nao_no_interno(Perg, NovaPerg) -> pergunta(NovaPerg, Resposta);
		resposta_nao_no_folha(Perg, Resposta)) ;
		(Input=s -> (resposta_sim_no_interno(Perg, NovaPerg)-> pergunta(NovaPerg, Resposta);
		resposta_sim_no_folha(Perg, Resposta))))
    ).


comecar_jogo_agora :-
	write("Responda (s.) para 'sim' ou (n.) para 'nao'."),nl,nl,
    pergunta("Eh um mamifero?", RespostaObtida),
	write("Seu animal eh "), write(RespostaObtida), nl,
    read(Acertei), nl,
    (
        (Acertei=s, write("Encontrei a resposta!"), nl, nl);
        (Acertei=n, write("Putz! Não tenho ideia de quem seria..."), nl, write("Qual era o seu animal?"), nl,
			read(NovoAnimal),
			write('Me tira uma duvida...'),nl,
			write("Como diferenciar '"), write(RespostaObtida), write("' de '"), write(NovoAnimal), write("'? (Digite uma pergunta entre aspas)"), nl, read(NovaPergunta),
			write("Qual a resposta de '"), write(NovaPergunta), write("' para '"), write(NovoAnimal), nl, read(NovaResposta),
			(

			(
				resposta_sim_no_folha(PerguntaAnterior, RespostaObtida), 			
				retract(resposta_sim_no_folha(PerguntaAnterior, RespostaObtida)), /*Remove elemento da tabela*/  
				assertz(resposta_sim_no_interno(PerguntaAnterior, NovaPergunta))  
			);                                                  

			(
				resposta_nao_no_folha(PerguntaAnterior, RespostaObtida),                 
				retract(resposta_nao_no_folha(PerguntaAnterior, RespostaObtida)), /*Remove elemento da tabela*/      
				assertz(resposta_nao_no_interno(PerguntaAnterior, NovaPergunta))     
			)
			),
			(
			(
				NovaResposta=n,                              
				assertz(resposta_nao_no_folha(NovaPergunta, NovoAnimal)),  
				assertz(resposta_sim_no_folha(NovaPergunta, RespostaObtida))         
			);
			(
				NovaResposta=s,                               
				assertz(resposta_sim_no_folha(NovaPergunta, NovoAnimal)),   
				assertz(resposta_nao_no_folha(NovaPergunta, RespostaObtida))       
			)                                               
				
			)
		)
    ),
    write("Vai querer jogar novamente?"), nl,
    read(PlayAgain),
    (   
		(PlayAgain=n, nl, !, fail);
        (PlayAgain=s, nl, comecar_jogo_agora, !, fail)
        
    ).