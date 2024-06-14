import 'dart:io';
import 'package:package/util/computador.dart';
import 'package:package/util/humano.dart';
import 'tools.dart' as tools;
import 'strings.dart' as st;
import 'package:package/util/ascii.dart' as ascii;


void main() {
  Game game = Game();
  game.iniciar();
}

ascii.Ascii asciiTool = ascii.Ascii(urlImage: 'lib/images/unnamed.gif');

class Game{

  int qtdPalitos = 0;
  int qtdRodadas = 0;
  int qtdJogadas = 0;

  void printRows(Map<int, List<String>> rowsGame){
    print(rowsGame[1]);
    print(rowsGame[2]);
    print(rowsGame[3]);
    print(rowsGame[4]);
    return;
  }

 Future iniciar()async{
  while  (true){
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
  

  void jogoHumanoVsHumano(){
    try{
      print(st.menu);
      print(st.tradOuSandbox);
      String? input = stdin.readLineSync() ?? '0';
      if(input == '#5'){
        asciiTool.asciiPararJogo();
        print(st.sairDoJogo);
        exit(0);
      } else if(input == '#3'){
        print(st.pararJogo);
        iniciar();
        return;
      }
      switch(int.tryParse(input) ?? 0){
        case 1:
          Map<int, List<String>> rowsGame = {1: [' 📍\n'],
                                            2: ['📍','📍','📍\n'],
                                            3: ['📍','📍','📍','📍','📍\n'],
                                            4: ['📍','📍','📍','📍','📍','📍','📍\n']};
          print(st.iniciarJogo);
          asciiTool.asciiNovoJogo();
          Humano jogador2 = Humano(maxRetirar: 7);
          Humano jogador1 = Humano(maxRetirar: 7);
          qtdPalitos = 16;
          print('Insira o nome do primeiro jogador.');
          String? input = stdin.readLineSync() ?? '0';
          jogador1.nickname = input;
          print('Insira o nome do segundo jogador.');
          String? input2 = stdin.readLineSync() ?? '0';
          jogador2.nickname = input2;      
          tools.imprimirQuantidadePadrao(qtdPalitos);
          while(qtdPalitos > 0){
            print('${jogador1.nickname}, Qual fileira você quer jogar? (1, 2, 3 ou 4)');
            int fileira = int.parse(stdin.readLineSync()!) ?? 0;
            if(fileira == 0 || fileira > 4){
              print(st.opcaoInvalida);
              continue;
            }
            print('Quantos palitos deseja retirar? (1 a ${rowsGame[fileira]!.length})');
            int retirar = int.parse(stdin.readLineSync()!) ?? 0;
            if(retirar == 0 || retirar > rowsGame[fileira]!.length || retirar > qtdPalitos){
              print(st.opcaoInvalida);
              continue;
            }
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
            print('${jogador2.nickname}, Qual fileira você quer jogar? (1, 2, 3 ou 4)');
            fileira = int.parse(stdin.readLineSync()!) ?? 0;
            if(fileira == 0 || fileira > 4){
              print(st.opcaoInvalida);
              continue;
            }
            print('Quantos palitos deseja retirar? (1 a ${rowsGame[fileira]!.length})');
            retirar = int.parse(stdin.readLineSync()!) ?? 0;
            if(retirar == 0 || retirar > rowsGame[fileira]!.length || retirar > qtdPalitos){
              print(st.opcaoInvalida);
              continue;
            }
            qtdPalitos -= retirar;
            for(int i = 0; i < retirar; i++){
              rowsGame[fileira]!.removeAt(0);
            }
            if(qtdPalitos == 0){
              print(st.vitoriaJogador);
              print('${jogador1.nickname} venceu o jogo!');
              return;
            }else{
              printRows(rowsGame);
              continue;
            }
          }
          break;
        case 2:
          asciiTool.asciiNovoJogo();
          print(st.opcaoPersonalizada);
          final int maxRetirar1;
          final int maxRetirar2;
          print('Insira o nome do primeiro jogador.');
          String? input = stdin.readLineSync() ?? '0';
          print(st.jogadaMaxima);
          maxRetirar1 = tools.lerNumeroPalitos(1, 5);
          print('Insira o nome do segundo jogador.');
          String? input2 = stdin.readLineSync() ?? '0';
          print(st.jogadaMaxima);
          maxRetirar2 = tools.lerNumeroPalitos(1, 5);
          Humano jogador1 = Humano(maxRetirar: maxRetirar1);
          Humano jogador2 = Humano(maxRetirar: maxRetirar2);
          jogador1.nickname = input;
          jogador2.nickname = input2;
          print(st.quantidadePalito);
          print('Cheguem em um consenso...');
          qtdPalitos = tools.lerNumeroPalitos(1, 33);
          tools.imprimirQuantidade(qtdPalitos);
          int player1desk = 0;
          int player2desk = 0;
          while(qtdPalitos > 0){
            player1desk = jogador1.jogar(qtdPalitos);
            qtdPalitos -= player1desk;
            if(qtdPalitos == 0){
              print(st.vitoriaJogador);
              print('${jogador2.nickname} venceu o jogo!');
              return;
            }
            tools.imprimirQuantidade(qtdPalitos);
            player2desk = jogador2.jogar(qtdPalitos);
            qtdPalitos -= player2desk;
            if(qtdPalitos == 0){
              print(st.vitoriaJogador);
              print('${jogador1.nickname} venceu o jogo!');
              return;
            }else{
              tools.imprimirQuantidade(qtdPalitos);
              continue;
            }
          }
          break;
        case 0:
          print(st.opcaoInvalida);
          jogoHumanoVsHumano();
          break;
        default:
          print(st.opcaoInvalida);
          jogoHumanoVsHumano();
          break;
      }
    }catch(e){
      print(e);
      print('Erro inesperado. Recomeçando...');
      print('');
      jogoHumanoVsHumano();
    }
  }

  void jogoHumanoVsCpu(){
  try{
    print(st.menu);
    print(st.tradOuSandbox);
    String? input = stdin.readLineSync() ?? '0';
    if(input == '#5'){
      asciiTool.asciiPararJogo();
      print(st.sairDoJogo);
      exit(0);
    } else if(input == '#3'){
      print(st.pararJogo);
      iniciar();
      return;
    }
    switch(int.tryParse(input) ?? 0){
      case 1:
        Map<int, List<String>> rowsGame = {1: [' 📍\n'],
                                          2: ['📍','📍','📍\n'],
                                          3: ['📍','📍','📍','📍','📍\n'],
                                          4: ['📍','📍','📍','📍','📍','📍','📍\n']};
        //setup-se o jogo
        print(st.iniciarJogo);
        asciiTool.asciiNovoJogo();
        Humano jogador1 = Humano(maxRetirar: 7);
        Computador computador1 = Computador(maxRetirar: 7);
        qtdPalitos = 16;
        print('Insira o nome do jogador.');
        String? input = stdin.readLineSync() ?? '0';
        jogador1.nickname = input;
        tools.imprimirQuantidadePadrao(qtdPalitos);
        //começa-se o jogo
        while(qtdPalitos > 0){
          print('${jogador1.nickname}, Qual fileira você quer jogar? (1, 2, 3 ou 4)');
          int fileira = int.parse(stdin.readLineSync()!) ?? 0;
          if(fileira == 0 || fileira > 4){
            print(st.opcaoInvalida);
            continue;
          }
          print('Quantos palitos deseja retirar? (1 a ${rowsGame[fileira]!.length})');
          int retirar = int.parse(stdin.readLineSync()!) ?? 0;
          if(retirar == 0 || retirar > rowsGame[fileira]!.length || retirar > qtdPalitos){
            print(st.opcaoInvalida);
            continue;
          }
          qtdPalitos -= retirar;
          for(int i = 0; i < retirar; i++){
            rowsGame[fileira]!.removeAt(0);
          }
          if(qtdPalitos == 0){
            print(st.vitoriaCpu);
            print('Desculpe, mas o computador venceu o jogo!');
            return;
          }
          printRows(rowsGame);
          print('Vez do computador.');
          print('O computador está pensando..');
          fileira = computador1.escolherFileira(rowsGame);
          retirar = computador1.jogarPorFileira(rowsGame, fileira);
          if(retirar == 0 || retirar > rowsGame[fileira]!.length || retirar > qtdPalitos){
            print('O computador está pensando..');
            retirar = computador1.jogarPorFileira(rowsGame, fileira);
          }
          print('O computador retirou + $retirar');
          qtdPalitos -= retirar;
          for(int i = 0; i < retirar; i++){
            rowsGame[fileira]!.removeAt(0);
          }
          if(qtdPalitos == 0){
            print(st.vitoriaJogador);
            print('${jogador1.nickname} venceu o jogo!');
            return;
          }else{
            printRows(rowsGame);
            continue;
          }
        }
        break;
      case 2:
          asciiTool.asciiNovoJogo();
          print(st.opcaoPersonalizada);
          final int maxRetirar1;
          final int maxRetirar2;
          print('Insira o nome do primeiro jogador.');
          String? input = stdin.readLineSync() ?? '0';
          print(st.jogadaMaxima);
          maxRetirar1 = tools.lerNumeroPalitos(1, 5);
          print('Insira a jogada máxima do computador.');
          print(st.jogadaMaxima);
          maxRetirar2 = tools.lerNumeroPalitos(1, 5);
          Humano jogador1 = Humano(maxRetirar: maxRetirar1);
          Computador computador1 = Computador(maxRetirar: maxRetirar2);
          jogador1.nickname = input;
          print(st.quantidadePalito);
          qtdPalitos = tools.lerNumeroPalitos(1, 33);
          tools.imprimirQuantidade(qtdPalitos);
          int player1desk = 0;
          int player2desk = 0;
          while(qtdPalitos > 0){
            player1desk = jogador1.jogar(qtdPalitos);
            qtdPalitos -= player1desk;
            if(qtdPalitos == 0){
              print(st.vitoriaCpu);
              print('Desculpe, mas o computador venceu o jogo!');
              return;
            }
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
            }else{
              tools.imprimirQuantidade(qtdPalitos);
              continue;
            }
          }
          break;
        case 0:
          print(st.opcaoInvalida);
          jogoHumanoVsCpu();
          break;
        default:
          print(st.opcaoInvalida);
          jogoHumanoVsCpu();
          break;
      }
    }catch(e){
      print(e);
      print('Erro inesperado. Recomeçando...');
      print('');
      jogoHumanoVsCpu();
    }
  }

  void jogoCpuVsCpu(){
  try{
    print(st.menu);
    print(st.tradOuSandbox);
    String? input = stdin.readLineSync() ?? '0';
    if(input == '#5'){
      asciiTool.asciiPararJogo();
      print(st.sairDoJogo);
      exit(0);
    } else if(input == '#3'){
      print(st.pararJogo);
      iniciar();
      return;
    }
    switch(int.tryParse(input) ?? 0){
      case 1:
        Map<int, List<String>> rowsGame = {1: [' 📍\n'],
                                          2: ['📍','📍','📍\n'],
                                          3: ['📍','📍','📍','📍','📍\n'],
                                          4: ['📍','📍','📍','📍','📍','📍','📍\n']};
        //setup-se o jogo
        print(st.iniciarJogo);
        asciiTool.asciiNovoJogo();
        Computador computador1 = Computador(maxRetirar: 7);
        Computador computador2 = Computador(maxRetirar: 7);
        String cpu1nome = 'CPU1';
        String cpu2nome = 'CPU2';
        print('Cpu1 vs Cpu2');
        print('Deseja nomear as máquinas? Digite "S" ou "N"');
        String? decisao = stdin.readLineSync() ?? '0';
        if(decisao == 'S'){
          print('Insira o nome da CPU 1');
          cpu1nome = stdin.readLineSync() ?? 'CPU1';
          print('Insira o nome da CPU 2');
          cpu2nome = stdin.readLineSync() ?? 'CPU2';
        }else if(decisao != 'N' && decisao != 'S'){
          print(st.opcaoInvalida);
          print('Recomeçando o jogo. \n\n');
          jogoCpuVsCpu();
          return;
        }
        qtdPalitos = 16;
        tools.imprimirQuantidadePadrao(qtdPalitos);
        //começa-se o jogo
        while(qtdPalitos > 0){
          print('Vez do computador $cpu1nome.');
          print('O computador está pensando..');
          int fileira = computador1.escolherFileira(rowsGame);
          if(fileira == 0 || fileira > 4){
            print(st.opcaoInvalida);
            continue;
          }
          int retirar = computador1.jogarPorFileira(rowsGame, fileira);
          if(retirar == 0 || retirar > rowsGame[fileira]!.length || retirar > qtdPalitos){
            print(st.opcaoInvalida);
            continue;
          }
          print('O computador $cpu1nome retirou + $retirar da fileira $fileira');
          qtdPalitos -= retirar;
          for(int i = 0; i < retirar; i++){
            rowsGame[fileira]!.removeAt(0);
          }
          if(qtdPalitos == 0){
            print(st.vitoriaCpu);
            print('$cpu2nome venceu o jogo!');
            return;
          }
          printRows(rowsGame);
          print('Vez do computador $cpu2nome.');
          print('O computador está pensando..');
          fileira = computador2.escolherFileira(rowsGame);
          retirar = computador2.jogarPorFileira(rowsGame, fileira);
          if(retirar == 0 || retirar > rowsGame[fileira]!.length || retirar > qtdPalitos){
            print('O computador está pensando..');
            retirar = computador2.jogarPorFileira(rowsGame, fileira);
          }
          print('O computador $cpu2nome retirou + $retirar da fileira $fileira');
          qtdPalitos -= retirar;
          for(int i = 0; i < retirar; i++){
            rowsGame[fileira]!.removeAt(0);
          }
          if(qtdPalitos == 0){
            print(st.vitoriaCpu);
            print('$cpu1nome venceu o jogo!');
            return;
          }else{
            printRows(rowsGame);
            continue;
          }
        }
        break;
      case 2:
          asciiTool.asciiNovoJogo();
          print(st.opcaoPersonalizada);
          final int maxRetirar1;
          final int maxRetirar2;
          print('Escolha o nome do computador1.');
          String? nomeCpu1 = stdin.readLineSync() ?? 'CPU1';
          print('Escolha o nome do computador2.');
          String? nomeCpu2 = stdin.readLineSync() ?? 'CPU2';
          print('Insira a jogada máxima do computador 1.');
          print(st.jogadaMaxima);
          maxRetirar1 = tools.lerNumeroPalitos(1, 5);
          print('Insira a jogada máxima do computador 2.');
          print(st.jogadaMaxima);
          maxRetirar2 = tools.lerNumeroPalitos(1, 5);
          Computador computador1 = Computador(maxRetirar: maxRetirar1);
          Computador computador2 = Computador(maxRetirar: maxRetirar2);
          print(st.quantidadePalito);
          qtdPalitos = tools.lerNumeroPalitos(1, 33);
          tools.imprimirQuantidade(qtdPalitos);
          int player1desk = 0;
          int player2desk = 0;
          while(qtdPalitos > 0){
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
            }else{
              tools.imprimirQuantidade(qtdPalitos);
              continue;
            }
          }
          break;
        case 0:
          print(st.opcaoInvalida);
          jogoCpuVsCpu();
          break;
        default:
          print(st.opcaoInvalida);
          jogoCpuVsCpu();
          break;
      }
    }catch(e){
      print(e);
      print('Erro inesperado. Recomeçando...');
      print('');
      jogoCpuVsCpu();
    }
  }
}
