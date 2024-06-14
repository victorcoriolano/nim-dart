import 'dart:io';
import 'package:package/util/ascii.dart';
import 'package:package/util/strings.dart' as st;
export 'package:package/util/tools.dart';
export 'package:package/util/strings.dart';
export 'package:enough_ascii_art/enough_ascii_art.dart';
Ascii ascii = Ascii(urlImage: 'lib/images/unnamed.gif');

void menuInicial(){
  ascii.printAscii();
  print(st.boasVindas);
  return;
}

int lerNumeroPalitos(int min, int max){
  while(true){
    try{
      String inputText = stdin.readLineSync() ?? '0';
      if(int.parse(inputText) < min || int.parse(inputText) > max && int.parse(inputText) != 0){
        print(st.minMaxInvalido);
        continue;
      }else if(int.parse(inputText) == 0){
        print(st.valorNulo);
        continue;
      }else{
        return int.parse(inputText);
      }
    }on FormatException{
      print(st.formatoInvalido);
      continue;
    }catch(e){
      print(st.valorNulo);
      continue;
    }
  }
}

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



