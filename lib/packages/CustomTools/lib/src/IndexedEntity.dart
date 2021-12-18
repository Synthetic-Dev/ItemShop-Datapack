part of custom_tool;

class IndexedEntity extends Widget {
  /// startIndex = start + 1
  static int start = 0;
  static int step = 1;

  static Score getScore(String score) =>
      Score(Entity.PlayerName("#objdConstIndexed"), score);

  EntityType? type;
  String score;
  Map<String, dynamic>? nbt;
  Location loc;
  TextComponent? name;
  List<String>? tags;

  IndexedEntity(this.type,
      {this.score = "objd_index",
      this.loc = const Location.here(),
      this.name,
      this.nbt});

  IndexedEntity.armorstand(
      {this.score = "objd_index",
      this.loc = const Location.here(),
      this.name,
      this.nbt,
      this.tags}) {
    type = Entities.armor_stand;
  }

  IndexedEntity.marker(
      {this.score = "objd_index",
      this.loc = const Location.here(),
      this.name,
      this.nbt}) {
    type = Entities.armor_stand;
  }

  IndexedEntity.aec(
      {this.score = "objd_index",
      this.loc = const Location.here(),
      this.name,
      this.nbt}) {
    type = Entities.area_effect_cloud;
  }

  @override
  generate(Context context) {
    if (loc == null) loc = Location.glob();
    tags?.addAll(["objd_index", "objd_index_new"]);

    var index =
        Score(Entity.PlayerName("#objdConstIndexed"), score, addNew: false);

    if (type == Entities.armor_stand) {
      return For.of([
        Extend(
          "load",
          child: For.of([
            Scoreboard(score),
            Score(Entity.PlayerName("#objdConstIndexed"), score).set(start),
          ]),
        ),
        index.add(step),
        ArmorStand.staticMarker(
          loc,
          tags: tags,
          name: name,
          nbt: nbt,
        ),
        Score(
          Entity(
            tags: ["objd_index_new"],
          ),
          score,
        ).setEqual(index),
        Tag(
          "objd_index_new",
          value: false,
          entity: Entity(
            tags: ["objd_index_new"],
          ),
        ),
      ]);
    } else if (type == Entities.area_effect_cloud) {
      return For.of([
        Extend(
          "load",
          child: For.of([
            Scoreboard(score),
            Score(Entity.PlayerName("#objdConstIndexed"), score).set(start),
          ]),
        ),
        AreaEffectCloud.persistent(loc,
            tags: ["objd_index", "objd_index_new"], name: name),
        Score(
          Entity(
            tags: ["objd_index_new"],
          ),
          score,
        ).setEqual(index),
        index.add(step),
        Tag(
          "objd_index_new",
          value: false,
          entity: Entity(
            tags: ["objd_index_new"],
          ),
        ),
      ]);
    } else {
      return For.of([
        Extend(
          "load",
          child: For.of([
            Scoreboard(score),
            Score(Entity.PlayerName("#objdConstIndexed"), score).set(start),
          ]),
        ),
        Summon(type!,
            location: loc, tags: ["objd_index", "objd_index_new"], name: name),
        Score(
          Entity(
            tags: ["objd_index_new"],
          ),
          score,
        ).setEqual(index),
        index.add(step),
        Tag(
          "objd_index_new",
          value: false,
          entity: Entity(
            tags: ["objd_index_new"],
          ),
        ),
      ]);
    }
  }
}
