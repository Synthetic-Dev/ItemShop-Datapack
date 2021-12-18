library custom_tool;

import 'package:objd/core.dart';
import 'dart:io' as io;

// import 'package:objd/predicates.dart' as pred;

part 'src/ColoredArmor.dart';
part 'src/CustomClickEvent.dart';
part 'src/CustomCommand.dart';
part 'src/MCFunction.dart';
part 'src/FireWork.dart';
part 'src/Sidebar.dart';
part 'src/Explosion.dart';
part 'src/DetectBlock.dart';
part 'src/LeftEvent.dart';
part 'src/CopyAllItems.dart';
part 'src/LoadASimuNewsDP.dart';
part 'src/ForceLoad.dart';
part 'src/IndexedEntity.dart';
part 'src/Uninstall.dart';
part 'src/AnimatedTitle.dart';
part 'src/CustomSign.dart';
part 'src/IsEquals.dart';
part 'src/Gamemode.dart';
part 'src/AddObjdConsts.dart';

//Gui
part 'src/gui/Gui.dart';

//drop gui
part 'src/dropGui/DropGui.dart';

//1vs1
part 'src/1vs1/Component.dart';
part 'src/1vs1/GameStartSuccess.dart';
part 'src/1vs1/1vs1.dart';
part 'src/1vs1/EndGame.dart';
part 'src/1vs1/Install.dart';

bool equalsIgnoreCase(String string1, String string2) {
  return string1.toLowerCase() == string2.toLowerCase();
}

List<String> readFileByLines(String path) {
  io.File file = new io.File(path);

  // sync
  List<String> lines = file.readAsLinesSync();

  return lines;
}

String readFile(String path) {
  io.File file = new io.File(path);

  // sync
  return file.readAsStringSync();
}

String getPrefix(String path) {
  List<String> pre = readFileByLines(path);
  for (var i = 0; i < pre.length; i++) {
    if (pre[i].contains("prefix: '")) {
      return strToText(pre[i].substring(9, pre[i].length - 1));
    }
  }
  return strToText('&aPrefix &8>>');
}

String strToText(String str) {
  var tcStr = new StringBuffer();
  List<TextComponent> tc = [];
  Color color = Color.White;
  bool bold = false,
      underlined = false,
      strikethrough = false,
      obfuscated = false,
      italic = false;
  var i = 0;

  for (i; i < str.length; i++) {
    if (str[i] == '&') {
      i++;
      switch (str[i]) {
        case '0':
          color = Color.Black;
          break;
        case '1':
          color = Color.DarkBlue;
          break;
        case '2':
          color = Color.DarkGreen;
          break;
        case '3':
          color = Color.DarkAqua;
          break;
        case '4':
          color = Color.DarkRed;
          break;
        case '5':
          color = Color.DarkPurple;
          break;
        case '6':
          color = Color.Gold;
          break;
        case '7':
          color = Color.Gray;
          break;
        case '8':
          color = Color.DarkGray;
          break;
        case '9':
          color = Color.Blue;
          break;
        case 'a':
          color = Color.Green;
          break;
        case 'b':
          color = Color.Aqua;
          break;
        case 'c':
          color = Color.Red;
          break;
        case 'd':
          color = Color.LightPurple;
          break;
        case 'e':
          color = Color.Yellow;
          break;
        case 'f':
          color = Color.White;
          break;
        case 'r':
          color = Color.White;
          bold = false;
          underlined = false;
          obfuscated = false;
          strikethrough = false;
          italic = false;
          break;
        case 'l':
          bold = true;
          break;
        case 'o':
          italic = true;
          break;
        case 'n':
          underlined = true;
          break;
        case 'm':
          strikethrough = true;
          break;
        case 'k':
          obfuscated = true;
          break;
        default:
      }
      continue;
    }

    for (var j = i; j < str.length; j++) {
      if (str[j] == '&') {
        i--;
        break;
      }
      i++;
      tcStr.write(str[j]);
    }

    tc.add(
      TextComponent(
        tcStr.toString(),
        bold: bold,
        color: color,
        italic: italic,
        underlined: underlined,
        obfuscated: obfuscated,
        strikethrough: strikethrough,
      ),
    );
    tcStr.clear();
  }

  var buffer = new StringBuffer();

  for (i = 0; i < tc.length; i++) {
    buffer.write(tc[i].toJson().toString());
    if (i + 1 < tc.length) buffer.write(',');
  }

  return '["",' + buffer.toString() + ']';
}

List<TextComponent> strToTextComponent(String str) {
  var tcStr = new StringBuffer();
  List<TextComponent> tc = [];
  Color? color;
  bool? bold = null,
      underlined = null,
      strikethrough = null,
      obfuscated = null,
      italic = null;
  var i = 0;

  for (i; i < str.length; i++) {
    if (str[i] == '&') {
      i++;
      switch (str[i]) {
        case '0':
          color = Color.Black;
          break;
        case '1':
          color = Color.DarkBlue;
          break;
        case '2':
          color = Color.DarkGreen;
          break;
        case '3':
          color = Color.DarkAqua;
          break;
        case '4':
          color = Color.DarkRed;
          break;
        case '5':
          color = Color.DarkPurple;
          break;
        case '6':
          color = Color.Gold;
          break;
        case '7':
          color = Color.Gray;
          break;
        case '8':
          color = Color.DarkGray;
          break;
        case '9':
          color = Color.Blue;
          break;
        case 'a':
          color = Color.Green;
          break;
        case 'b':
          color = Color.Aqua;
          break;
        case 'c':
          color = Color.Red;
          break;
        case 'd':
          color = Color.LightPurple;
          break;
        case 'e':
          color = Color.Yellow;
          break;
        case 'f':
          color = Color.White;
          break;
        case 'r':
          color = Color.White;
          bold = false;
          underlined = false;
          obfuscated = false;
          strikethrough = false;
          italic = false;
          break;
        case 'l':
          bold = true;
          break;
        case 'o':
          italic = true;
          break;
        case 'n':
          underlined = true;
          break;
        case 'm':
          strikethrough = true;
          break;
        case 'k':
          obfuscated = true;
          break;
        default:
      }
      continue;
    }

    for (var j = i; j < str.length; j++) {
      if (str[j] == '&') {
        i--;
        break;
      }
      i++;
      tcStr.write(str[j]);
    }

    //REGEX
    if (tcStr.toString().contains("<player>")) {
      int indexOf = tcStr.toString().indexOf("<player>");
      if (indexOf != 0) {
        tc.add(
          TextComponent(
            tcStr.toString().substring(0, indexOf - 1),
            bold: bold,
            color: color,
            italic: italic,
            underlined: underlined,
            obfuscated: obfuscated,
            strikethrough: strikethrough,
          ),
        );
      }
      tc.add(
        TextComponent.selector(
          Entity.Self(),
          bold: bold,
          color: color,
          italic: italic,
          underlined: underlined,
          obfuscated: obfuscated,
          strikethrough: strikethrough,
        ),
      );
      if (indexOf + 8 < tcStr.toString().length) {
        tc.add(
          TextComponent(
            tcStr.toString().substring(indexOf + 8),
            bold: bold,
            color: color,
            italic: italic,
            underlined: underlined,
            obfuscated: obfuscated,
            strikethrough: strikethrough,
          ),
        );
      }
    } else if (tcStr.toString().contains("<prefix>")) {
      int indexOf = tcStr.toString().indexOf("<prefix>");
      if (indexOf != 0) {
        tc.add(
          TextComponent(
            tcStr.toString().substring(0, indexOf - 1),
            bold: bold,
            color: color,
            italic: italic,
            underlined: underlined,
            obfuscated: obfuscated,
            strikethrough: strikethrough,
          ),
        );
      }
      tc.add(
        TextComponent.selector(
          Entity(tags: ["ls", "lsPrefixHolder"]),
        ),
      );
      if (indexOf + 8 < tcStr.toString().length) {
        tc.add(
          TextComponent(
            tcStr.toString().substring(indexOf + 8),
            bold: bold,
            color: color,
            italic: italic,
            underlined: underlined,
            obfuscated: obfuscated,
            strikethrough: strikethrough,
          ),
        );
      }
    } else {
      tc.add(
        TextComponent(
          tcStr.toString(),
          bold: bold,
          color: color,
          italic: italic,
          underlined: underlined,
          obfuscated: obfuscated,
          strikethrough: strikethrough,
        ),
      );
    }
    tcStr.clear();
  }
  return tc;
}

int colorToDec(Color _color) {
  switch (_color) {
    case Color.Aqua:
      return 2651799;
      break;
    case Color.Black:
      return 1973019;
      break;
    case Color.Blue:
      return 6719955;
      break;
    case Color.DarkBlue:
      return 2437522;
      break;
    case Color.DarkGray:
      return 4408131;
      break;
    case Color.DarkGreen:
      return 3887386;
      break;
    case Color.DarkPurple:
      return 8073150;
      break;
    case Color.Gold:
      return 15435844;
      break;
    case Color.Gray:
      return 11250603;
      break;
    case Color.Green:
      return 4312372;
      break;
    case Color.LightPurple:
      return 12801229;
      break;
    case Color.Red:
      return 11743532;
      break;
    case Color.White:
      return 15790320;
      break;
    case Color.Yellow:
      return 14602026;
      break;
    default:
      var r = int.parse(_color.toString().substring(1, 2), radix: 16);
      var g = int.parse(_color.toString().substring(3, 4), radix: 16);
      var b = int.parse(_color.toString().substring(5, 6), radix: 16);

      return 65536 * r + 256 * g + b;
  }
}

main(List<String> args) {
  print("Custom tools by SimuNews Softwares");
}
