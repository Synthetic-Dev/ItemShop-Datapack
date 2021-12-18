part of custom_tool;

class JoinEvent extends Widget {
  String score;
  int from;
  List<Widget> content;

  JoinEvent(this.score, {required this.content, this.from = 1});

  @override
  generate(Context context) {
    return For.of([
      //SCORE
      Scoreboard(
        score,
        type: "minecraft.custom:minecraft.leave_game",
      ),

      Execute(
        as: Entity.All(),
        unless: Condition.score(Score(Entity.Self(), score).matches(2)),
        children: [Score(Entity.Self(), score).set(1)],
      ),

      //MAIN
      Execute(
        as: Entity.All(
          scores: [
            Score(
              Entity.Self(),
              score,
            ).matches(1),
          ],
        ),
        at: Entity.Self(),
        children: content,
      ),

       Score(
        Entity.All(
          scores: [
            Score(
              Entity.Self(),
              score,
            ).matches(1),
          ],
        ),
        score,
      ).set(2),

      //////////////////////////////////////////////////////////////////////////////////////////////

      Execute(
        as: Entity.All(
          scores: [
            Score(
              Entity.Self(),
              score,
            ).matchesRange(
              Range.from(from + 2),
            ),
          ],
        ),
        at: Entity.Self(),
        children: content,
      ),

      Score(
        Entity.All(
          scores: [
            Score(
              Entity.Self(),
              score,
            ).matchesRange(
              Range.from(from + 2),
            ),
          ],
        ),
        score,
      ).set(2),
    ]);
  }
}
