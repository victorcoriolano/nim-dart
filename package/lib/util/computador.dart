import 'dart:math';

class Computador {
  int maxRetirar;
  Computador({required this.maxRetirar});

  int jogar(int qtdPalitos) {
    int jogadaAleatoria = Random().nextInt(maxRetirar) + 1;
    if(qtdPalitos - jogadaAleatoria == 0 && qtdPalitos > 0 && jogadaAleatoria > 1) {
      return jogadaAleatoria - 1;
    }
    if(jogadaAleatoria > 0 && jogadaAleatoria <= qtdPalitos) {
      return jogadaAleatoria;
    }else {
      return jogar(qtdPalitos);
    }
  }

  int escolherFileira(Map<int, List<String>> rowsGame) {
    int jogadaAleatoria = Random().nextInt(4) + 1;
    if(jogadaAleatoria > 0 && jogadaAleatoria <= 4 && rowsGame[jogadaAleatoria]!.isNotEmpty) {
      return jogadaAleatoria;
    } 
    else {
      return escolherFileira(rowsGame);
    }
  }

  int jogarPorFileira(Map<int, List<String>> rowsGame, int fileira) {
    //////////////////////////
    //Lógica abandonada:
    // List<int> soma;
    // List<String> rowsClone = List.from(rowsGame[fileira]!);
    //substitui os palitos por 1 e depois soma-os
    // rowsClone[fileira].replaceRange(0, rowsClone[fileira].length-1, '1');
    // soma = List.generate(rowsClone[fileira].length, (index) => (int.parse(rowsClone[fileira])));
    //verifica se a próxima jogada é perdedora, se sim refaz o processo, se não retorna a jogada      
    // if (soma.reduce((value, element) => value + element) - jogadaAleatoria == 0) {return jogar()}
    //////////////////////////
    ///Lógica abandonada temporariamente
        // if(rowsGame[fileira]![0] == '📍\n'){
        //   try{
        //     return jogarPorFileira(rowsGame, escolherFileira(rowsGame));
        //   }
        //   catch(e){
        //     return jogadaAleatoria;
        //   }
        // } else if(rowsGame[fileira]![1] == '📍\n'){
        //   return 1;
        // }
      //////////////////////////
    int jogadaAleatoria = Random().nextInt(rowsGame[fileira]!.length) + 1;
      if(jogadaAleatoria > 0 && jogadaAleatoria <= rowsGame[fileira]!.length && jogadaAleatoria <= maxRetirar) {
        return jogadaAleatoria;
      //se não é um valor válido refaz a análise
      }else{
        return jogarPorFileira(rowsGame, fileira);
      }
  }
}