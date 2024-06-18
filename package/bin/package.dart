import 'dart:io';
import "package:package/util/ascii.dart";
import 'package:package/util/game.dart';
import 'package:package/util/strings.dart' as st;


bool exiting = false;
Ascii ascii = Ascii(urlImage: 'lib/images/unnamed.gif');
//método inicializador do pacote.
void main() {
  Game game = Game();
  do{
    ascii.printAscii();
    //inicia o jogo
    game.iniciar();
    //caso retorne, mostra o menu e lê a opção informada pelo usuário
    print(st.menu);
    String? input = stdin.readLineSync();
    //se quiser encerrar o programa, encerra-se. Se digitar qualquer outro valor, recomeça este o método principal.
    if(input == '#5'){
      ascii.asciiPararJogo();
      print(st.sairDoJogo);
      exit(0);
    } else {
      print('Redirecionando a conexão...\n\n\n');
      main();
    }
    //O jogo é reiniciado infinitamente ate que o usuário digite #5 para encerrar o programa.
  } while(true);
}