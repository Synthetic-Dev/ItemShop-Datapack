part of custom_tool;

class ForceLoad extends Widget {

  int x, y;

  ForceLoad({this.x = 0, this.y = 0});

  @override
  generate(Context context) {
    return Command("forceload add $x $y");
  }
}
