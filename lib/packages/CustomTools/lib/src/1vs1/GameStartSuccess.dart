part of custom_tool;

class GameStart extends Widget {
  String name = "", _name = "";
  GameStart.success(this.name) {
    _name = name.replaceAll(" ", "");
  }

  @override
  generate(Context context) {
    return For.of([
      Score(Entity(tags: [_name, "1vs1Component"]), "1vs1GameStarted").set(1),
    ]);
  }
}
