import 'dart:io';
import 'package:package/util/computador.dart';
import 'package:package/util/humano.dart';
import 'tools.dart' as tools;
import 'strings.dart' as st;
import 'package:package/util/ascii.dart' as ascii;

ascii.Ascii asciiTool = ascii.Ascii(urlImage: 'lib/images/unnamed.gif');
//importada classe STRINGS para uso de strings pré-definidas. (st.exemploDeUso)
//importada classe TOOLS para uso de métodos reutilizáveis. (tools.exemploDeUso)

class Game{
  //atributos
  int qtdPalitos = 0;
  //metodos
  //Método para printar o tabuleiro
  void printRows(Map<int, List<String>> rowsGame){
    print(rowsGame[1]);
    print(rowsGame[2]);
    print(rowsGame[3]);
    print(rowsGame[4]);
    return;
  }
  //Método para tela inicial
  void iniciar(){
  while (true){
    tools.menuInicial();
    String? input = stdin.readLineSync() ?? '0';
    String entrada = input.toString();
    if(entrada == '#1'){
      novoJogo();
      break;
    } else if(entrada == '#3'){
      print(st.pararJogo);
      print('Você não está em um jogo. Recomeçando...\n\n');
      continue;
    } else if(entrada == '#5'){
      asciiTool.asciiPararJogo();
      print(st.sairDoJogo);
      exit(0);
    } else {
      print(st.opcaoInvalida);
      continue;
    }
  }
  }
  //Método para escolher o jogo que deseja
  void novoJogo(){
    asciiTool.asciiNovoJogo();
    print(st.iniciarJogo);
    print(st.modoDeJogo);
    String? input = stdin.readLineSync() ?? '0';
    if(int.tryParse(input) == 1){
      jogoHumanoVsHumano();
    } else if(int.tryParse(input) == 2){
      jogoHumanoVsCpu();
    } else if(int.tryParse(input) == 3){
      jogoCpuVsCpu();
    } else if(int.tryParse(input) == 0){
      print(st.opcaoInvalida);
      return;
    } else {
      print(st.opcaoInvalida);
      return;
    }
  }
  
  //jogo Humano vs Humano
  void jogoHumanoVsHumano(){
    //Try para reinicializar o menu em caso de erro inesperado ou caso o jogador escolheu parar.
    try{
      print(st.menu);
      //Pergunta se deseja o modo tradicional ou sandbox.
      print(st.tradOuSandbox);
      String? input = stdin.readLineSync() ?? '0';
      //Verifica se o jogador quer parar o jogo ou sair do programa.
      if(input == '#5'){
        asciiTool.asciiPararJogo();
        print(st.sairDoJogo);
        exit(0);
      } else if(input == '#3'){
        print(st.pararJogo);
        iniciar();
        return;
      }
      //Inicializa-se o modo de jogo escolhido.
      switch(int.tryParse(input) ?? 0){
        //Modo Tradicional
        case 1:
          Map<int, List<String>> rowsGame = {
            1: [' 📍\n'],
            2: ['📍','📍','📍\n'],
            3: ['📍','📍','📍','📍','📍\n'],
            4: ['📍','📍','📍','📍','📍','📍','📍\n']};
          print(st.iniciarJogo);
          asciiTool.asciiNovoJogo();
          Humano jogador2 = Humano(maxRetirar: 7);
          Humano jogador1 = Humano(maxRetirar: 7);
          qtdPalitos = 16;
          //Verifica o nome dos jogadores.
          while(true){
            print('Insira o nome do primeiro jogador, ou deixe em branco para usar "Jogador1".');
            String? line = stdin.readLineSync() ?? '';
            String? input = line.isEmpty ? 'Jogador1' : line;
            print('Insira o nome do segundo jogador, ou deixe em branco para usar "Jogador2".');
            String? line2 = stdin.readLineSync() ?? '';
            String? input2 = line2.isEmpty ? 'Jogador2' : line;
            if(input == input2){
              input += ' 1';
              input2 += ' 2';
            }
            jogador1.nickname = input;
            jogador2.nickname = input2;
            break;
          }
          tools.imprimirQuantidadePadrao(qtdPalitos);
          //Começa o jogo
          while(qtdPalitos > 0){
            //Escolhe-se a fileira a ser jogada
            print('${jogador1.nickname}, Qual fileira você quer jogar? (1, 2, 3 ou 4)');
            String? lerFileira = stdin.readLineSync() ?? 0.toString();
            int fileira = lerFileira.isEmpty ? 0 : int.parse(lerFileira);
            //Retorna se a fileira ou resposta for inválida
            if(fileira == 0 || fileira > 4){
              print(st.opcaoInvalida);
              continue;
            }
            //Escolhe-se os palitos a se retirar
            print('Quantos palitos deseja retirar? (1 a ${rowsGame[fileira]!.length})');
            String? lerRetirar = stdin.readLineSync() ?? 0.toString();
            int retirar = lerRetirar.isEmpty ? 0 : int.parse(lerRetirar);
            //Retorna se o palito ou resposta for inválida
            if(retirar == 0 || retirar > rowsGame[fileira]!.length || retirar > qtdPalitos){
              print(st.opcaoInvalida);
              continue;
            }
            //Retira os palitos da fileira e verifica se o jogo acabou
            qtdPalitos -= retirar;
            for(int i = 0; i < retirar; i++){
              rowsGame[fileira]!.removeAt(0);
            }
            if(qtdPalitos == 0){
              print(st.vitoriaJogador);
              print('${jogador2.nickname} venceu o jogo!');
              return;
            }
            printRows(rowsGame);
            //Loopa-se a rodada do segundo jogador para que não retorne à vez do primeiro com "continue;" em caso de erro.
            while(true){
              print('${jogador2.nickname}, Qual fileira você quer jogar? (1, 2, 3 ou 4)');
              String? lerFileira = stdin.readLineSync() ?? 0.toString();
              int fileira = lerFileira.isEmpty ? 0 : int.parse(lerFileira);
              if(fileira == 0 || fileira > 4){
                print(st.opcaoInvalida);
                continue;
              }
              print('Quantos palitos deseja retirar? (1 a ${rowsGame[fileira]!.length})');
              String? lerRetirar = stdin.readLineSync() ?? 0.toString();
              int retirar = lerRetirar.isEmpty ? 0 : int.parse(lerRetirar);
              if(retirar == 0 || retirar > rowsGame[fileira]!.length || retirar > qtdPalitos){
                print(st.opcaoInvalida);
                continue;
              }
              break;
            }
            //Retira os palitos da fileira e verifica se o jogo acabou
            qtdPalitos -= retirar;
            for(int i = 0; i < retirar; i++){
              rowsGame[fileira]!.removeAt(0);
            }
            if(qtdPalitos == 0){
              print(st.vitoriaJogador);
              print('${jogador1.nickname} venceu o jogo!');
              return;
            }// Se não, imprime o tabuleiro e retorna ao começo do loop.
            else{
              printRows(rowsGame);
              continue;
            }
          }
        break;
        //Modo Personalizado (seguindo ementa)
        case 2:
          asciiTool.asciiNovoJogo();
          print(st.opcaoPersonalizada);
          final int maxRetirar1;
          final int maxRetirar2;
          //Recolhe os dados dos jogadores
          print('Insira o nome do primeiro jogador, ou deixe em branco para usar "Jogador1".');
          String? inputName = stdin.readLineSync() ?? 'Jogador1';
          String j1nickname = inputName.isEmpty ? 'Jogador1' : inputName;
          print(st.jogadaMaxima);
          maxRetirar1 = tools.lerNumeroPalitos(1, 5);
          print('Insira o nome do segundo jogador, ou deixe em branco para usar "Jogador2".');
          String? inputName2 = stdin.readLineSync() ?? 'Jogador2';
          String j2nickname = inputName2.isEmpty ? 'Jogador2' : inputName2;
          print(st.jogadaMaxima);
          maxRetirar2 = tools.lerNumeroPalitos(1, 5);
          //Verifica paridade de nomes
          if(j1nickname == j2nickname){
            j1nickname += ' 1';
            j2nickname += ' 2';
          }
          //Cria os jogadores
          Humano jogador1 = Humano(maxRetirar: maxRetirar1);
          Humano jogador2 = Humano(maxRetirar: maxRetirar2);
          jogador1.nickname = j1nickname;
          jogador2.nickname = j2nickname;
          //Decide-se as quantidades de palitos do jogo
          print(st.quantidadePalito);
          print('Cheguem em um consenso...');
          qtdPalitos = tools.lerNumeroPalitos(5, 33);
          tools.imprimirQuantidade(qtdPalitos);
          //Inicia o jogo
          int player1desk = 0;
          int player2desk = 0;
          while(qtdPalitos > 0){
            //Jogada do jogador 1
            player1desk = jogador1.jogar(qtdPalitos);
            //verifica se o jogador quis parar o jogo atual.
            if(player1desk == 0){
              print(st.pararJogo);
              return iniciar();
            }
            qtdPalitos -= player1desk;
            if(qtdPalitos == 0){
              print(st.vitoriaJogador);
              print('${jogador2.nickname} venceu o jogo!');
              return;
            }
            tools.imprimirQuantidade(qtdPalitos);
            //Jogada do jogador 2
            player2desk = jogador2.jogar(qtdPalitos);
            //verifica se o jogador quis parar o jogo atual.
            if(player2desk == 0){
              print(st.pararJogo);
              return iniciar();
            }
            qtdPalitos -= player2desk;
            if(qtdPalitos == 0){
              print(st.vitoriaJogador);
              print('${jogador1.nickname} venceu o jogo!');
              return;
            } // Se ninguém ganhou, imprime o tabuleiro e retorna ao começo do loop.
            else{
              tools.imprimirQuantidade(qtdPalitos);
              continue;
            }
          }
          break;
        //Reinicia caso nenhum modo de jogo seja escolhido.
        case 0:
          print(st.opcaoInvalida);
          jogoHumanoVsHumano();
          break;
        default:
          print(st.opcaoInvalida);
          jogoHumanoVsHumano();
          break;
      }
    //Retorna ao Try.
    }catch(e){
      print(e);
      print('Erro inesperado. Recomeçando...');
      print('');
      jogoHumanoVsHumano();
    }
  }

  //Jogo Humano Vs CPU
  void jogoHumanoVsCpu(){
  try{
    //menu inicial do jogo
    print(st.menu);
    print(st.tradOuSandbox);
    String? input = stdin.readLineSync() ?? '0';
    //verifica se quer parar ou sair
    if(input == '#5'){
      asciiTool.asciiPararJogo();
      print(st.sairDoJogo);
      exit(0);
    } else if(input == '#3'){
      print(st.pararJogo);
      iniciar();
      return;
    }
    //inicializa o modo escolhido
    switch(int.tryParse(input) ?? 0){
      //Modo Tradicional
      case 1:
        Map<int, List<String>> rowsGame = {
          1: [' 📍\n'],
          2: ['📍','📍','📍\n'],
          3: ['📍','📍','📍','📍','📍\n'],
          4: ['📍','📍','📍','📍','📍','📍','📍\n']};
        //configura-se o jogo
        print(st.iniciarJogo);
        asciiTool.asciiNovoJogo();
        Humano jogador1 = Humano(maxRetirar: 7);
        Computador computador1 = Computador(maxRetirar: 7);
        qtdPalitos = 16;
        print('Insira o nome do jogador.');
        String? input = stdin.readLineSync() ?? '';
        String j1nickname = input.isEmpty ? 'Jogador1' : input;
        jogador1.nickname = j1nickname;
        tools.imprimirQuantidadePadrao(qtdPalitos);
        //começa-se o jogo
        while(qtdPalitos > 0){
          //escolhe-se primeiramente a fileira na vez do jogador
          print('${jogador1.nickname}, Qual fileira você quer jogar? (1, 2, 3 ou 4)');
          String? lerFileira = stdin.readLineSync() ?? '';
          int fileira = lerFileira.isEmpty ? 0 : int.parse(lerFileira);
          if(fileira == 0 || fileira > 4){
            print(st.opcaoInvalida);
            continue;
          }
          //escolhe-se quantos palitos o jogador quer retirar
          print('Quantos palitos deseja retirar? (1 a ${rowsGame[fileira]!.length})');
          String? lerRetirar = stdin.readLineSync() ?? '';
          int retirar = lerRetirar.isEmpty ? 0 : int.parse(lerRetirar);
          if(retirar == 0 || retirar > rowsGame[fileira]!.length || retirar > qtdPalitos){
            print(st.opcaoInvalida);
            continue;
          }
          //retira-se os palitos do jogo e se o jogo terminar, o vencedor e o computador
          qtdPalitos -= retirar;
          for(int i = 0; i < retirar; i++){
            rowsGame[fileira]!.removeAt(0);
          }
          if(qtdPalitos == 0){
            print(st.vitoriaCpu);
            print('Desculpe, mas o computador venceu o jogo!');
            return;
          }
          //senão, a vez é do computador
          printRows(rowsGame);
          print('Vez do computador.');
          print('O computador está pensando..');
          fileira = computador1.escolherFileira(rowsGame);
          retirar = computador1.jogarPorFileira(rowsGame, fileira);
          print('O computador retirou + $retirar');
          //retira-se os palitos do jogo e se o jogo terminar, o vencedor e o jogador
          qtdPalitos -= retirar;
          for(int i = 0; i < retirar; i++){
            rowsGame[fileira]!.removeAt(0);
          }
          if(qtdPalitos == 0){
            print(st.vitoriaJogador);
            print('${jogador1.nickname} venceu o jogo!');
            return;
          }//se não, o loop reinicia e as rodadas continuam
          printRows(rowsGame);
          continue;
        }
        break;
      //Modo personalizado
      case 2:
          asciiTool.asciiNovoJogo();
          print(st.opcaoPersonalizada);
          final int maxRetirar1;
          final int maxRetirar2;
          //Insere-se nome do jogador humano e quantidade de jogadas dos jogadores
          print('Insira o nome do jogador humano.');
          String? input = stdin.readLineSync() ?? '';
          String j1nickname = input.isEmpty ? 'Jogador1' : input;
          print('Insira a SUA jogada máxima.');
          print(st.jogadaMaxima);
          maxRetirar1 = tools.lerNumeroPalitos(1, 5);
          print('Insira a jogada máxima DO COMPUTADOR.');
          print(st.jogadaMaxima);
          maxRetirar2 = tools.lerNumeroPalitos(1, 5);
          //Instanciação
          Humano jogador1 = Humano(maxRetirar: maxRetirar1);
          Computador computador1 = Computador(maxRetirar: maxRetirar2);
          jogador1.nickname = j1nickname;
          //Escolhe-se a quantidade de palitos.
          print(st.quantidadePalito);
          qtdPalitos = tools.lerNumeroPalitos(5, 33);
          tools.imprimirQuantidade(qtdPalitos);
          int player1desk = 0;
          int player2desk = 0;
          //Começa o jogo.
          while(qtdPalitos > 0){
            //Jogada do jogador, caso seja o último palito, o computador vence o jogo.
            player1desk = jogador1.jogar(qtdPalitos);
            //verifica se o jogador quis parar o jogo
            if(player1desk == 0){
              print(st.pararJogo);
              return iniciar();
            }
            qtdPalitos -= player1desk;
            if(qtdPalitos == 0){
              print(st.vitoriaCpu);
              print('Desculpe, mas o computador venceu o jogo!');
              return;
            }
            //Senão, segue para a vez do computador. Se for o último palito, o humano vence o jogo.
            tools.imprimirQuantidade(qtdPalitos);
            print('Vez do computador.');
            print('O computador está pensando..');
            player2desk = computador1.jogar(qtdPalitos);
            print('O computador retirou + $player2desk');
            qtdPalitos -= player2desk;
            if(qtdPalitos == 0){
              print(st.vitoriaJogador);
              print('${jogador1.nickname} venceu o jogo!');
              return;
            }//Senão, o loop reinicia e as rodadas continuam.
            tools.imprimirQuantidade(qtdPalitos);
            continue;
          }
          break;
        //Volta para o menu inicial caso nenhum modo seja escolhido ou o jogador queira parar o jogo.
        case 0:
          print(st.opcaoInvalida);
          jogoHumanoVsCpu();
          break;
        default:
          print(st.opcaoInvalida);
          jogoHumanoVsCpu();
          break;
      }
    //Retorna ao Try
    }catch(e){
      print(e);
      print('Erro inesperado. Recomeçando...');
      print('');
      jogoHumanoVsCpu();
    }
  }

  //Modo CPU vs CPU
  void jogoCpuVsCpu(){
  try{
    //menu inicial do jogo
    print(st.menu);
    print(st.tradOuSandbox);
    String? input = stdin.readLineSync() ?? '0';
    //verifica se o jogador quer parar o jogo ou sair do programa.
    if(input == '#5'){
      asciiTool.asciiPararJogo();
      print(st.sairDoJogo);
      exit(0);
    } else if(input == '#3'){
      print(st.pararJogo);
      iniciar();
      return;
    }
    //Inicia-se o modo de jogo escolhido.
    switch(int.tryParse(input) ?? 0){
      //Modo Tradicional
      case 1:
        Map<int, List<String>> rowsGame = {
          1: [' 📍\n'],
          2: ['📍','📍','📍\n'],
          3: ['📍','📍','📍','📍','📍\n'],
          4: ['📍','📍','📍','📍','📍','📍','📍\n']};
        //Configura-se o jogo
        print(st.iniciarJogo);
        asciiTool.asciiNovoJogo();
        Computador computador1 = Computador(maxRetirar: 7);
        Computador computador2 = Computador(maxRetirar: 7);
        String cpu1nome = 'CPU1';
        String cpu2nome = 'CPU2';
        print('Cpu1 vs Cpu2');
        print('Deseja nomear as máquinas? Digite "S" ou "N"');
        //nomeaçao ou não das maquinas
        String? decisao = stdin.readLineSync() ?? 'N';
        if(decisao.toUpperCase() == 'S'){
          print('Insira o nome da CPU 1');
          cpu1nome = stdin.readLineSync() ?? 'CPU1';
          print('Insira o nome da CPU 2');
          cpu2nome = stdin.readLineSync() ?? 'CPU2';
          //verifica a paridade de nomes
          if(cpu1nome == cpu2nome){
            cpu1nome += ' 1';
            cpu2nome += ' 2';
          }
        //verifica se a opção S/N não foi inserida
        }else if(decisao.toUpperCase() != 'N' && decisao.toUpperCase() != 'S'){
          print(st.opcaoInvalida);
          print('');
          print('Recomeçando o jogo. \n\n');
          jogoCpuVsCpu();
          return;
        }
        qtdPalitos = 16;
        tools.imprimirQuantidadePadrao(qtdPalitos);
        //começa-se o jogo
        while(qtdPalitos > 0){
          //Vez do CPU1
          print('Vez do computador $cpu1nome.');
          print('O computador está pensando..');
          int fileira = computador1.escolherFileira(rowsGame);
          int retirar = computador1.jogarPorFileira(rowsGame, fileira);
          print('O computador $cpu1nome retirou - $retirar da fileira $fileira');
          //atualiza valores, retira palitos e verifica se o jogo acabou
          qtdPalitos -= retirar;
          for(int i = 0; i < retirar; i++){
            rowsGame[fileira]!.removeAt(0);
          }
          if(qtdPalitos == 0){
            print(st.vitoriaCpu);
            print('$cpu2nome venceu o jogo!');
            return;
          }
          //se não, vez do CPU2
          printRows(rowsGame);
          print('Vez do computador $cpu2nome.');
          print('O computador está pensando..');
          fileira = computador2.escolherFileira(rowsGame);
          retirar = computador2.jogarPorFileira(rowsGame, fileira);
          print('O computador $cpu2nome retirou - $retirar da fileira $fileira');
          //atualiza valores, retira palitos e verifica se o jogo acabou
          qtdPalitos -= retirar;
          for(int i = 0; i < retirar; i++){
            rowsGame[fileira]!.removeAt(0);
          }
          if(qtdPalitos == 0){
            print(st.vitoriaCpu);
            print('$cpu1nome venceu o jogo!');
            return;
          }
          //se não, imprime o tabuleiro e continua o jogo
          printRows(rowsGame);
          continue;
        }
        break;
      //Modo Personalizado
      case 2:
          //Início do jogo
          asciiTool.asciiNovoJogo();
          print(st.opcaoPersonalizada);
          final int maxRetirar1;
          final int maxRetirar2;
          //nomeaçao obrigatoria das maquinas
          print('Escolha o nome do computador1.');
          String? nomeCpu = stdin.readLineSync() ?? '';
          String nomeCpu1 = nomeCpu.isEmpty ? 'CPU1' : nomeCpu;
          print('Escolha o nome do computador2.');
          nomeCpu = stdin.readLineSync() ?? '';
          String nomeCpu2 = nomeCpu.isEmpty ? 'CPU2' : nomeCpu;
          print('Insira a jogada máxima do computador 1.');
          //Configuração da jogada máxima dos computadores.
          print(st.jogadaMaxima);
          maxRetirar1 = tools.lerNumeroPalitos(1, 5);
          print('Insira a jogada máxima do computador 2.');
          print(st.jogadaMaxima);
          maxRetirar2 = tools.lerNumeroPalitos(1, 5);
          //Instanciação
          Computador computador1 = Computador(maxRetirar: maxRetirar1);
          Computador computador2 = Computador(maxRetirar: maxRetirar2);
          //Lê-se a quantidade de palitos totais
          print(st.quantidadePalito);
          qtdPalitos = tools.lerNumeroPalitos(5, 33);
          tools.imprimirQuantidade(qtdPalitos);
          int player1desk = 0;
          int player2desk = 0;
          //começa-se o jogo
          while(qtdPalitos > 0){
            //Vez do CPU1. Se acabou os palitos, CPU2 ganha
            print('Vez do computador.');
            print('O computador está pensando..');
            player1desk = computador1.jogar(qtdPalitos);
            print('O computador 1 $nomeCpu1 retirou $player1desk palitos');
            qtdPalitos -= player1desk;
            if(qtdPalitos == 0){
              print(st.vitoriaCpu);
              print('CPU2 $nomeCpu2 venceu o jogo!');
              return;
            }
            //Vez do CPU2. Se acabou os palitos, CPU1 ganha
            tools.imprimirQuantidade(qtdPalitos);
            print('Vez do computador.');
            print('O computador está pensando..');
            player2desk = computador2.jogar(qtdPalitos);
            print('O computador 2 $nomeCpu2 retirou $player2desk palitos');
            qtdPalitos -= player2desk;
            if(qtdPalitos == 0){
              print(st.vitoriaCpu);
              print('CPU 1 $nomeCpu1 venceu o jogo!');
              return;
            }
            //Se não, imprime o tabuleiro e continua o jogo
            tools.imprimirQuantidade(qtdPalitos);
            continue;
          }
          break;
        //opção inválida retorna a inicialização do jogo
      case 0:
        print(st.opcaoInvalida);
        jogoCpuVsCpu();
        break;
      default:
        print(st.opcaoInvalida);
        jogoCpuVsCpu();
      break;
    }
    //Erro fatal reinicializa ao Try
    }catch(e){
      print(e);
      print('Erro inesperado. Recomeçando...');
      print('');
      jogoCpuVsCpu();
    }
  }
}
