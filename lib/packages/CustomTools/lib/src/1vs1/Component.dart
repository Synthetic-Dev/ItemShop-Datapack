part of custom_tool;

class Component extends Widget {
  String name = "", _name = "";
  int version = 0;
  Item menuItem;
  String downloadLink;

  Component(
    this.name,
    this.version, {
    this.menuItem = Items.stone,
    this.downloadLink = "",
  }) {
    _name = name.replaceAll(" ", "");
    Game1vs1.name = _name;
  }

  @override
  generate(Context context) {
    return For.of([
      Scoreboard("1vs1ComponentV"),
      Execute.as(
        Entity(tags: ["1vs1", "1vs1Component", _name]),
        children: [
          Tag(
            "1vs1ComponentFound",
            entity: Entity.Player(),
          ),
        ],
      ),
      If.not(
        Condition.tag(
          Tag(
            "1vs1ComponentFound",
            entity: Entity.Player(),
          ),
        ),
        then: [
          ArmorStand.staticMarker(
            Location.glob(y: 400),
            name: TextComponent(name, italic: false),
            tags: ["1vs1", "1vs1Component", _name],
            gravity: false,
            small: true,
          ),
          Score(
            Entity(tags: ["1vs1Component", _name]),
            "1vs1ComponentV",
          ).set(version),
          Score(
            Entity(tags: ["1vs1Component", _name]),
            "1vs1GamesPlayed",
          ).set(0),
          ReplaceItem(
            Entity(
              tags: ["1vs1Component", _name],
            ),
            slot: Slot.MainHand,
            item: menuItem,
          ),
          Tag(
            "1vs1ComponentFound",
            value: false,
            entity: Entity.Player(),
          ),
        ],
      ),
      Tag(
        "1vs1ComponentFound",
        entity: Entity.Player(),
        value: false,
      ),
    ]);
  }
}
