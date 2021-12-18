part of custom_tool;

class IsEquals extends Widget {
  static String prefix = "objd";
  static int index = 0;

  String namespace1, namespace2;
  dynamic target1, target2;
  String type1 = "entity", type2 = "entity";
  List<Widget> onTrue, onFalse;

  IsEquals(
    this.target1,
    this.namespace1,
    this.target2,
    this.namespace2, {
    this.onTrue = const [],
    this.onFalse = const [],
  }) {
    if (target1 is Entity || target1 is Location || target1 is String) {
      if (target1 is Location)
        type1 = "block";
      else if (target1 is String) {
        type1 = "storage";
      } else {
        Entity tmp = Entity.clone(target1 as Entity);
        tmp.setValues(limit: 1);
        target1 = Entity.clone(tmp);
      }
    } else
      print(
          "Error: IsEquals -> target1 -> Use Location, Entity or String datatype...");

    if (target2 is Entity || target2 is Location) {
      if (target2 is Location)
        type2 = "block";
      else {
        //Entity tmp = Entity.clone(target2 as Entity);
        //tmp.setValues(limit: 1);
        //target2 = Entity.clone(tmp);
      }
    } else
      print("Error: IsEquals -> target2 -> Use Location or Entity datatype...");
  }

  @override
  generate(Context context) {
    return For.of([
      Scoreboard(prefix + "IsEquals"),
      Command(
          "data modify storage ${prefix}isequals ${namespace1} set from ${type1} ${target1} ${namespace1}"),
      Command(
          "execute store success score %bool${index} ${prefix}IsEquals run data modify storage ${prefix}isequals ${namespace1} set from ${type2} ${target2} ${namespace2}"),
      If(
          Condition.score(Score(
            Entity.PlayerName("%bool${index++}"),
            "${prefix}IsEquals",
          ).matches(1)),
          then: onFalse,
          orElse: onTrue)
    ]);
  }
}
