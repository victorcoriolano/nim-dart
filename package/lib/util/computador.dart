import 'dart:math';

class Computador {
  // Atributos
  String? nickname;
  int maxRetirar;

  // Construtor
  Computador({required this.maxRetirar});

  // Métodos
  int jogar(int qtdPalitos) {
    int jogadaAleatoria = Random().nextInt(maxRetirar) + 1; // random entre 1 e o atributo máximo dado na construção

    // Evita o computador de perder o jogo personalizado e se possível ganhar
    if (qtdPalitos - jogadaAleatoria == 0 && qtdPalitos > 1 && jogadaAleatoria > 1) {
      return jogadaAleatoria - 1;
    }

    // Se não é o caso da condição acima, o computador pode jogar normalmente
    if (jogadaAleatoria > 0 && jogadaAleatoria <= qtdPalitos) {
      return jogadaAleatoria;
    } else {
      // Retorna a tentar de qualquer forma
      return jogar(qtdPalitos);
    }
  }

  int escolherFileira(Map<int, List<String>> rowsGame) {
    int jogadaAleatoria = Random().nextInt(4) + 1; // entre 1 e 4
    if (rowsGame[jogadaAleatoria]!.isNotEmpty && rowsGame[jogadaAleatoria] != null) {
      if (rowsGame[jogadaAleatoria] == [' 📍\n']) {
        // Tenta escolher outra fileira se a escolhida só tiver um palito sobrando
        try {
          escolherFileira(rowsGame);
        } catch (e) {
          // Se as outras forem inválidas, retorna a jogada aleatória
          return jogadaAleatoria;
        }
      }
      return jogadaAleatoria;
    }
    return escolherFileira(rowsGame);
  }

  int jogarPorFileira(Map<int, List<String>> rowsGame, int fileira) {
    int jogadaAleatoria = Random().nextInt(rowsGame[fileira]!.length) + 1; // entre 1 e o número de disponíveis

    if (jogadaAleatoria > 0 && jogadaAleatoria <= rowsGame[fileira]!.length && jogadaAleatoria <= maxRetirar) {
      return jogadaAleatoria;
    } else {
      // Se não é um valor válido refaz a análise
      return jogarPorFileira(rowsGame, fileira);
    }
  }
}
