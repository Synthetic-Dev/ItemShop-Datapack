part of custom_tool;

class LoadDataPack extends Widget {
  String name;
  String prefix;
  List<String> authors;
  List<String> dependencies;
  List<String> softDependencies;

  bool missingDependency = false;

  LoadDataPack(this.name, this.authors,
      {this.dependencies = const [], this.softDependencies = const [], this.prefix = "objd"}) {
    if (prefix.length > 4) prefix = prefix.substring(0, 3);
  }

  @override
  generate(Context context) {
    name = name.toLowerCase();

    return For.of([
      ForceLoad(),

      //Create dependency aec
      Kill(Entity(tags: [name, prefix])),
      AreaEffectCloud.persistent(Location.glob(), tags: [name, prefix]),

      // enable dp
      Tellraw(Entity.All(), show: [
        TextComponent(
            ")====================================================(\n",
            color: Color.Yellow),
        TextComponent("Load " + name + "..."),
      ]),

      //Scoreboard for checks
      Scoreboard("${prefix}Depend"),
      Scoreboard("${prefix}DependLoaded"),
      Scoreboard(prefix + "Loaded"),

      Score(Entity.PlayerName("#" + name + "_depend"), "${prefix}Depend")
          .set(dependencies.length),
      Score(Entity.PlayerName("#" + name + "_depend"), "${prefix}DependLoaded")
          .set(0),

      // Check for errors
      For(
        to: dependencies.length - 1,
        create: (int i) {
          return If.not(Condition.entity(Entity(tags: [dependencies[i]])),
              useTag: "${prefix}_depend",
              then: [
                Tellraw(Entity.All(), show: [
                  TextComponent(
                      "Failed to load " +
                          name +
                          ": Missing dependency -> " +
                          dependencies[i] +
                          "\nWithout this dependency this datapack does not work!",
                      color: Color.Red),
                ]),
              ],
              orElse: [
                Tellraw(Entity.All(), show: [
                  TextComponent("Loaded dependency " + dependencies[i],
                      color: Color.Green),
                ]),
                Score(Entity.PlayerName("#" + name + "_depend"),
                        "objdDependLoaded")
                    .add(1)
              ]);
        },
      ),

      For(
        to: softDependencies.length - 1,
        create: (int i) {
          return If.not(Condition.entity(Entity(tags: [softDependencies[i]])),
              useTag: "${prefix}_depend",
              then: [
                Tellraw(Entity.All(), show: [
                  TextComponent(
                      "WARNING " +
                          name +
                          ": Missing dependency -> " +
                          softDependencies[i] +
                          "\nWithout this dependency this datapack might not work correctly!",
                      color: Color("#ffae00")),
                ]),
              ],
              orElse: [
                Tellraw(Entity.All(), show: [
                  TextComponent("Loaded dependency " + softDependencies[i],
                      color: Color.Green),
                ]),
              ]);
        },
      ),

      If(
        Condition.score(
            Score(Entity.PlayerName("#" + name + "_depend"), "${prefix}Depend")
                .isEqual(Score(Entity.PlayerName("#" + name + "_depend"),
                    "${prefix}DependLoaded"))),
        then: [
          Tellraw(Entity.All(), show: [
            TextComponent("Loaded " + name + "\n", color: Color.Aqua),
            TextComponent(
                ")====================================================(",
                color: Color.Yellow),
          ]),
          Score(Entity.PlayerName("#" + name + "_depend"), prefix + "Loaded")
              .set(1),
        ],
        orElse: [
          Tellraw(Entity.All(), show: [
            TextComponent("Couldn't load " + name + "\nDisabeling...\n",
                color: Color.DarkRed),
            TextComponent(
                ")====================================================(",
                color: Color.Yellow),
          ]),
        ],
      ),
    ]);
  }
}
