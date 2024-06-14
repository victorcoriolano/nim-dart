import 'dart:core';
import 'dart:io';
import 'package:enough_ascii_art/enough_ascii_art.dart'as art;
import 'package:image/image.dart'as img;

class Ascii {

  String urlImage;
  
  Ascii({
    required this.urlImage
  });

   printAscii() async{
    final bytes = await File(urlImage).readAsBytes();
    final image = img.decodeImage(bytes)!;
    var asciiImage = art.convertImage(image, maxWidth: 120, invert: true);
    print('');
    print(asciiImage);
  }

  emoticonAscii() {
    var emoji = '📍';
    var asciiEmoticon = art.convertEmoticons(emoji, art.EmoticonStyle.western);
    print(asciiEmoticon);
    print('');
  }

  asciiNovoJogo() async{
    var fontText =  await File('lib/3D-ASCII.flf').readAsString();
    var figure = art.renderFiglet('NOVO JOGO', art.Font.text(fontText));
    print('');
    print(figure);
    print('');
  }

    asciiPararJogo() async{
    var fontText =  await File('lib/3D-ASCII.flf').readAsString();
    var figure = art.renderFiglet('FIM DE JOGO', art.Font.text(fontText));
    print('');
    print(figure);
    print('');
  }
}