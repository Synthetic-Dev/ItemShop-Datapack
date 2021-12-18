part of custom_tool;

class GameMode extends Widget {
  static String score = "objdGameMode";

  String type = "";
  Entity target = Entity();
  Gamemode gm = Gamemode.creative;

  GameMode.init(String _score) {
    score = _score;
  }
  GameMode.store(this.gm, this.target) {
    type = "store";
  }
  GameMode.restore(this.target) {
    type = "restore";
  }

  @override
  generate(Context context) {
    switch (type) {
      case "store":
        return For.of([
          Scoreboard(score),
          /*Predicate(
            "in_survival",
            contents: pred.Properties(
              gamemode: Gamemode.survival,
            ),
          ),
          Predicate(
            "in_creative",
            contents: pred.Properties(
              gamemode: Gamemode.creative,
            ),
          ),
          Predicate(
            "in_adventure",
            contents: pred.Properties(
              gamemode: Gamemode.adventure,
            ),
          ),
          Predicate(
            "in_spectator",
            contents: pred.Properties(
              gamemode: Gamemode.spectator,
            ),
          ),*/
          Command(
            "execute as ${target.toString()} if predicate ${context.packId}:in_survival run scoreboard players set ${target.toString()} ${score} 0",
          ),
          Command(
            "execute as ${target.toString()} if predicate ${context.packId}:in_creative run scoreboard players set ${target.toString()} ${score} 1",
          ),
          Command(
            "execute as ${target.toString()} if predicate ${context.packId}:in_adventure run scoreboard players set ${target.toString()} ${score} 2",
          ),
          Command(
            "execute as ${target.toString()} if predicate ${context.packId}:in_spectator run scoreboard players set ${target.toString()} ${score} 3",
          ),
          SetGamemode(gm, target: target),
        ]);
        break;
      case "restore":
        return For.of([
          If(
            Condition.score(
              Score(target, score).matches(0),
            ),
            then: [
              SetGamemode(Gamemode.survival, target: target),
            ],
          ),
          If(
            Condition.score(
              Score(target, score).matches(1),
            ),
            then: [
              SetGamemode(Gamemode.creative, target: target),
            ],
          ),
          If(
            Condition.score(
              Score(target, score).matches(2),
            ),
            then: [
              SetGamemode(Gamemode.adventure, target: target),
            ],
          ),
          If(
            Condition.score(
              Score(target, score).matches(3),
            ),
            then: [
              SetGamemode(Gamemode.spectator, target: target),
            ],
          ),
        ]);
        break;
      default:
    }
  }
}
