part of custom_tool;

enum Type {
  BALL,
  BALL_LARGE,
  STAR,
  CREEPER,
  BURST,
}

class Explosion {
  Type shape;
  bool flicker, trail;

  List<Color> explosionColor, fadeColor;

  Explosion(this.shape, this.explosionColor, {this.flicker = false, this.trail = false, this.fadeColor = const []});

  String toString() {
    var str = new StringBuffer();

    str.write('{Type:' + shape.index.toString() + ',Flicker:');

    if (flicker) {
      str.write('1,Trail:');
    } else {
      str.write('0,Trail:');
    }

    if (trail) {
      str.write('1,Colors:[I;');
    } else {
      str.write('0,Colors:[I;');
    }

    for (var i = 0; i < explosionColor.length; i++) {
      str.write(colorToDec(explosionColor[i]).toString());
      if (i + 1 < explosionColor.length) str.write(',');
    }

    if (fadeColor.length > 0) {
      str.write(',FadeColors:[I;');
      for (var i = 0; i < fadeColor.length; i++) {
        str.write(colorToDec(fadeColor[i]).toString());
        if (i + 1 < fadeColor.length) str.write(',');
      }
      str.write("]}");
    } else
      str.write(']}');

    return str.toString();
  }
}
