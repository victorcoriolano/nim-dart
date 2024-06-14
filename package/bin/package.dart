import 'dart:io';
import "package:package/util/ascii.dart";
import 'package:package/util/computador.dart';
import 'package:package/util/game.dart';
import 'package:package/util/humano.dart';
import 'package:package/util/strings.dart' as st;
import 'package:package/util/tools.dart' as tools;

bool exiting = false;
Ascii ascii = Ascii(urlImage: 'lib/images/unnamed.gif');
void main() {
  Game game = Game();
    do{
      ascii.printAscii();
      game.iniciar();
      print(st.menu);
      String? input = stdin.readLineSync();
      if(input == '#5'){
        ascii.asciiPararJogo();
        print(st.sairDoJogo);
        exit(0);
      } else{
        print('Redirecionando a conexão...\n\n\n');
        main();
      }
    } while(true);
}