import 'dart:io';
import 'package:package/util/ascii.dart';
import 'package:package/util/strings.dart' as st;
export 'package:package/util/tools.dart';
export 'package:package/util/strings.dart';
export 'package:enough_ascii_art/enough_ascii_art.dart';
Ascii ascii = Ascii(urlImage: 'lib/images/unnamed.gif');
//arquivo util para uso de métodos reutilizáveis ou então escrever menos código.

//método que imprime o menu inicial.
void menuInicial(){
  ascii.printAscii();
  print(st.boasVindas);
  return;
}

//método que le o valor digitado pelo usuário.
int lerNumeroPalitos(int min, int max){
  while(true){
    try{
      //tratamento do input
      String? inputText = stdin.readLineSync() ?? '';
      int playerInput = int.tryParse(inputText) ?? 0;
      //tratamento de erros
      if(playerInput < min || playerInput > max){
        print(st.minMaxInvalido);
        continue;
      }else if(playerInput == 0){
        print(st.valorNulo);
        continue;
      }else{
        //retorna a jogada se válida
        return playerInput;
      }
    }on FormatException{
      //retorna a tentar se for inválido
      print(st.formatoInvalido);
      continue;
    }catch(e){
      //retorna a tentar de qualquer forma
      print(st.valorNulo);
      continue;
    }
  }
}

//método para imprimir a quantidade de palitos visualmente.
void imprimirQuantidade(int quantidadeAtual){
  print('');
  print("''''''''''''''''''''''''''''''''''''");
  print("''''Quantidade Atual de Palitos:''''");
  print("''''''''''''''''''''''''''''''''''''");
  if(quantidadeAtual > 16){
    if(quantidadeAtual%2 == 0){
    print('📍 ' * (quantidadeAtual~/2));
    print('📍 ' * (quantidadeAtual~/2));
  print("''''''''''''''''''''''''''''''''''''");
    return;
    }else{
      print('📍 ' * ((quantidadeAtual-1)~/2));
      print('📍 ' * ((quantidadeAtual+1)~/2));
  print("''''''''''''''''''''''''''''''''''''");
      return;
    }
  }
  stdout.writeln('📍 ' * (quantidadeAtual));
  print("''''''''''''''''''''''''''''''''''''");
}

void imprimirQuantidadePadrao(int qtdPadrao){
  print('');
  print("''''''''''''''''''''''''''''''''''''");
  print("''''Quantidade Inicial de Palitos:''''");
  print("''''''''''''''''''''''''''''''''''''");
  for(int i = 0; i<=7; i++){
    if(!i.isEven){
      print('📍 ' * i );
    }
  }
  print("''''''''''''''''''''''''''''''''''''");
}
