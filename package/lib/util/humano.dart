import 'dart:io';

import 'package:package/util/ascii.dart';

import 'package:package/util/tools.dart' as tools;

import 'package:package/util/strings.dart' as st;

Ascii ascii = Ascii(urlImage: 'lib/images/unnamed.gif');

class Humano {
    String? nickname;
    int maxRetirar;
    Humano({required this.maxRetirar});

  int jogar(int qtdPalitos) {
    while(true){
      try{
        tools.imprimirQuantidade(qtdPalitos);
        print('$nickname está jogando...');
        print('Escolha o número de palitos para retirar.');
        String? input = stdin.readLineSync();
        if(input == '#5'){
          ascii.asciiPararJogo();
          print(st.sairDoJogo);
          exit(0);
        }else if(input == '#3'){
          tools.menuInicial();
          return 0;
        }
        int jogada = int.parse(input!);
        if(jogada <= qtdPalitos && jogada <= maxRetirar && jogada > 0){
          return jogada;
        } else{
          print(st.jogadaInvalida);
        }
      }on FormatException{
        print(st.formatoInvalido);
      }catch(e){
        print('Erro: $e');
        print(st.jogadaInvalida);
      }
    }
  }
}