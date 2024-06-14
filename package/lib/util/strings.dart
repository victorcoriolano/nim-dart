import 'dart:core';
import 'dart:io';

String boasVindas = ("\n\n=>Bem-vindo ao Jogo NIM. Prepare-se para uma jogatina estratégica.\n=>Neste jogo clássico de estratégia, dois jogadores se revezam para remover palitos de uma ou mais pilhas.\n=>O objetivo é não ser o jogador que remove o último palito. Mostre suas habilidades e vença o seu oponente!\n \n =>Como o jogo é feito via terminal, os seus controles de menu serão:\n >>>[ INICIAR: #1 ], [ PARAR O JOGO: #3 ] [ENCERRAR PROGRAMA: #5 ]<<<\n =>Isso significa que você pode escolher #1 para começar, #3 para encerrar o jogo e #5 para encerrar o programa a qualquer momento.\n =>(Use o jogo da velha). Boa sorte!<=");
String formatoInvalido =("O formato informado é inválido. Tente novamente.");
String opcaoInvalida = ("Opcão inválida. Tente novamente.");
String minMaxInvalido = ("O valor informado ultrapassa os limites válidos. Tente novamente. ");
String jogadaInvalida = ("Jogada inválida. Tente novamente. ");
String valorNulo = ("O valor informado é inválido. Tente novamente. ");
String quantidadeRodadas = ("Informe a quantidade de rodadas desejada(1 a 50): ");
String vitoriaCpu = ("Vitória do computador!");
String vitoriaJogador = ("Vitória do jogador!");
String jogadaMaxima = ("Digite uma quantidade de 3 a 5 palitos para retirar por vez da fileira:\n");
String quantidadePalito = ("Digite a quantidade de palitos  no jogo. Deverá variar entre 5 a 33 palitos: \n");
String modoDeJogo = ("Modos de jogo disponíveis:\n  Digite 1 - Humano vs Humano\n  Digite 2 - Humano vs Computador\n  Digite 3 - Computador vs Computador\n");
String? inputText = stdin.readLineSync();
String sairDoJogo = ("Opção #5 - ENCERRAR PROGRAMA pressionada.\n Obrigado por jogar! Encerrando...");
String iniciarJogo = ("Opção #1 - INICIAR JOGO pressionada.\n Inicializando um novo jogo...");
String pararJogo = ("Opção #3 - PARAR JOGO pressionada.\n Interrompendo jogatina atual...");
String menu = ("Opção #3 - VOLTAR AO MENU  || Opção #5 - ENCERRAR PROGRAMA \n");
String opcaoPersonalizada = ("Opção 2 - PERSONALIZADO\n Configurando o jogo...\n Configurando o jogo... \n Configurando o jogo...\n");
String tradOuSandbox = ("'Deseja jogar o jogo NIM padrão ou personalizado?'\n Digite 1 - Tradicional\n Digite 2 - Personalizado e Desorganizado\n");