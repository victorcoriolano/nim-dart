import 'dart:math';

class Computador {
  //atributos
  String? nickname;
  int maxRetirar;
  //construtor
  Computador({required this.maxRetirar});
  //metodos
  int jogar(int qtdPalitos) {
    int jogadaAleatoria = Random().nextInt(maxRetirar) + 1; // random entre 1 e o atributo máximo dado na construção
    //evita o computador de perder o jogo personalizado e se possível ganhar
    if(qtdPalitos - jogadaAleatoria == 0 && qtdPalitos > 1 && jogadaAleatoria > 1) {
      return jogadaAleatoria - 1;
    }
    //se não é o caso da condição acima, o computador pode jogar normalmente
    if(jogadaAleatoria > 0 && jogadaAleatoria <= qtdPalitos) {
      return jogadaAleatoria;
    } //retorna a tentar de qualquer forma
    else {
      return jogar(qtdPalitos);
    }
  }

  int escolherFileira(Map<int, List<String>> rowsGame) {
    int jogadaAleatoria = Random().nextInt(4) + 1; //entre 1 e 4
    if(rowsGame[jogadaAleatoria]!.isNotEmpty && rowsGame[jogadaAleatoria]!=null) {
      if(rowsGame[jogadaAleatoria] == [' 📍\n']) {
        //tenta escolher outra fileira se a escolhida só tiver um palito sobrando
        try{
        escolherFileira(rowsGame);
        } catch(e) {
          // se as outras forem inválidas, retorna a jogada aleatória
          return jogadaAleatoria;
        }
      }
      return jogadaAleatoria;
    }
    return escolherFileira(rowsGame);
  }

  int jogarPorFileira(Map<int, List<String>> rowsGame, int fileira) {
    int jogadaAleatoria = Random().nextInt(rowsGame[fileira]!.length) + 1; //entre 1 e o numero de disponiveis
      if(jogadaAleatoria > 0 && jogadaAleatoria <= rowsGame[fileira]!.length && jogadaAleatoria <= maxRetirar) {
        return jogadaAleatoria;
      //se não é um valor válido refaz a análise
      }else{
        return jogarPorFileira(rowsGame, fileira);
      }
  }
}
