part of custom_tool;

class Game1vs1 {
  static String name = "Game1vs1";
  static String fullName = "Game 1vs1";
  static Entity getPlayer() {
    return Entity(tags: ["1vs1StartGameUser"]);
  }

  static Entity getComponent() {
    return Entity(tags: ["1vs1Component", name], limit: 1);
  }

  static Widget gameStarting(List<Widget> children) {
    return For.of([
      If(
        Condition.score(
          Score(Game1vs1.getComponent(), "1vs1GameStarted").matches(2),
        ),
        then: children +
            [
              Tag(
                "1vs1InGame",
                entity: Game1vs1.getPlayer(),
              ),
              Tag(
                "1vs1StartGameUser",
                entity: Game1vs1.getPlayer(),
                value: false,
              ),
              GameStart.success(Game1vs1.name),
            ],
      ),
    ]);
  }
}
