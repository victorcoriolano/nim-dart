import 'dart:io';

import 'package:package/util/ascii.dart';
import 'package:package/util/tools.dart' as tools;
import 'package:package/util/strings.dart' as st;

Ascii ascii = Ascii(urlImage: 'lib/images/unnamed.gif');

class Humano {
  // Atributos
  String? nickname;
  int maxRetirar;

  Humano({required this.maxRetirar});

  // Métodos
  int jogar(int qtdPalitos) {
    while (true) {
      try {
        // Aparece sempre que for jogar
        tools.imprimirQuantidade(qtdPalitos);
        print('$nickname está jogando...');
        print('Escolha o número de palitos para retirar.');
        String? input = stdin.readLineSync() ?? '';

        // Verifica se o jogador quer parar o jogo ou sair do programa
        if (input == '#5') {
          ascii.asciiPararJogo();
          print(st.sairDoJogo);
          exit(0);
        } else if (input == '#3') {
          tools.menuInicial();
          return 0;
        }

        // Computa jogada se é válida
        int jogada = int.tryParse(input) ?? 0;
        if (jogada <= qtdPalitos && jogada <= maxRetirar && jogada > 0) {
          return jogada;
        } else {
          print(st.jogadaInvalida);
        }
      } catch (e) {
        print('Erro inesperado: $e');
        print(st.jogadaInvalida);
        return jogar(qtdPalitos);
      }
    }
  }
}
