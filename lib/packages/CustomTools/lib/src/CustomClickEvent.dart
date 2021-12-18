part of custom_tool;

/// The ClickEvent Module uses the trigger of a carrot on a stick to register right clicks with a scoreboard and execute a [onClick] Widget.
class CustomClickEvent extends Module {
  String path;
  String name;
  Widget onLeftClick, onRightClick;
  Item selectedItem = Item(Items.netherite_ingot);
  int selItemSlot = 0;
  String score;
  Score _scorer = Score.fromSelected(""), _scorel = Score.fromSelected("");

  String type = "item";

  /// The ClickEvent Module uses the trigger of a carrot on a stick to register right clicks with a scoreboard and execute a [onClick] Widget.
  ///
  /// This module has to be executed every tick to work!
  ///
  /// | constructor |  |
  /// |--|--|
  /// |name|used to identify different click Events|
  /// |onClick| Widget that is executed if the Villager is clicked |
  /// |selectedItem| just triggers the click if this Item is selected |
  /// |path| path to create the click handler function(default = `events/`) |

  CustomClickEvent(
    dynamic selectedItem, {
    this.name = "RC_Name",
    required this.onLeftClick,
    required this.onRightClick,
    this.path = 'events/',
    this.score = "rc_name",
  }) {
    _scorer = Score.fromSelected(score + "r");
    _scorel = Score.fromSelected(score + "l");
    if (selectedItem is Item)
      this.selectedItem = selectedItem;
    else if (selectedItem is int) {
      this.selItemSlot = selectedItem;
      type = "slot";
    } else
      print("Error: CustomClickEvent -> selectedItem must be int or Item");
  }

  @override
  Widget generate(Context context) {
    String selItemTag = '"';

    if (selectedItem.tag.toString().length > 16) {
      String woWhiteSpace = selectedItem.tag.toString().replaceAll(" ", "");
      String tmp1 = woWhiteSpace.substring(0, 15);
      String tmp2 = woWhiteSpace.substring(16, woWhiteSpace.length - 3);

      selItemTag = '",tag:' + tmp1 + "'{" + tmp2 + "}'}}";
    }

    if (type == "item") {
      return For.of([
        Scoreboard(
          score + "r",
          type: 'minecraft.custom:minecraft.talked_to_villager',
          addIntoLoad: true,
        ),
        Scoreboard(
          score + "l",
          type: 'minecraft.custom:minecraft.damage_dealt',
          addIntoLoad: true,
        ),
        Team.add("noColission"),
        Team.modify("noColission", collision: ModifyTeam.never),
        Tag(name + "Holding2", entity: Entity.All(tags: [name + "Holding"])),
        selectedItem.tag != null
            ? Entity.All(
                strNbt: '{SelectedItem:{id:"' +
                    selectedItem.type.toString() +
                    selItemTag +
                    '}}',
              ).addTag(name + "Holding")
            : Entity.All(
                strNbt: '{SelectedItem:{id:"' +
                    selectedItem.type.toString() +
                    '"}}',
              ).addTag(name + "Holding"),
        selectedItem.tag != null
            ? Entity.All(
                strNbt: '!{SelectedItem:{id:"' +
                    selectedItem.type.toString() +
                    selItemTag +
                    '}}',
              ).removeTag(name + "Holding")
            : Entity.All(
                strNbt: '!{SelectedItem:{id:"' +
                    selectedItem.type.toString() +
                    '"}}',
              ).removeTag(name + "Holding"),
        Execute.asat(
          Entity.All(tags: ["!" + name + "Holding2", name + "Holding"]),
          children: [
            Command(
                '/summon minecraft:armor_stand ^ ^ ^-0.5 {Invisible:1b,Invulnerable:1b,Marker:1b,NoGravity:1b,Passengers:[{id:"minecraft:villager",ActiveEffects:[{Id:10b,Amplifier:255b,Duration:19999980,ShowParticles:0b},{Id:14b,Amplifier:255b,Duration:19999980,ShowParticles:0b}],Invulnerable:1b,NoAI:1b,NoGravity:1b,Silent:1b,Tags:[' +
                    name +
                    ', ' +
                    name +
                    'Vill]}],Silent:1b,Tags:[' +
                    name +
                    ', ' +
                    name +
                    'Stand]}'),
            Team.join(
              "noColission",
              Entity(
                tags: [name + "Vill"],
              ),
            ),
          ],
        ),
        Execute.asat(
          Entity.All(tags: [name + "Holding2", "!" + name + "Holding"]),
          children: [
            Command('/tp @e[tag=' +
                name +
                ',distance=..3,sort=nearest,limit=2] ~ -200 ~'),
            Command(
                '/kill @e[tag=' + name + ',distance=..3,sort=nearest,limit=2]'),
          ],
        ),
        Entity.All(tags: [name + "Holding2"]).removeTag(name + "Holding2"),
        Execute(
          as: Entity(tags: [name]),
          at: Entity.Self(),
          If: Condition.not(
              Condition.entity(Entity.Player(distance: Range.to(3)))),
          location: Location.rel(y: -1),
          children: [
            Command('/tp @s ~ -500 ~'),
            Command('/kill @s'),
          ],
        ),
        Execute(
          as: Entity(tags: [name + "Holding"]),
          at: Entity.Self(),
          location: Location.rel(y: 1.5),
          children: [
            Command('/tp @e[tag=' +
                name +
                'Stand, distance=..3,sort=nearest,limit=1] ^ ^ ^'),
          ],
        ),
        Execute.asat(
          Entity.All(
              scores: [
                _scorel.matchesRange(
                  Range.from(1),
                ),
              ],
              strNbt: selectedItem != null
                  ? '{SelectedItem:{id:"' +
                      selectedItem.type.toString() +
                      selItemTag +
                      '}}'
                  : '{SelectedItem:{id:"' +
                      selectedItem.type.toString() +
                      '"}}'),
          children: [
            File.execute(path + score + "l", create: false),
          ],
        ),
        Execute.asat(
          Entity.All(
              scores: [
                _scorer.matchesRange(
                  Range.from(1),
                ),
              ],
              strNbt: selectedItem != null
                  ? '{SelectedItem:{id:"' +
                      selectedItem.type.toString() +
                      selItemTag +
                      '}}'
                  : '{SelectedItem:{id:"' +
                      selectedItem.type.toString() +
                      '"}}'),
          children: [
            File.execute(path + score + "r", create: false),
          ],
        ),
      ]);
    } else if (type == "slot") {
      return For.of([
        Scoreboard(
          score + "r",
          type: 'minecraft.custom:minecraft.talked_to_villager',
          addIntoLoad: true,
        ),
        Scoreboard(
          score + "l",
          type: 'minecraft.custom:minecraft.damage_dealt',
          addIntoLoad: true,
        ),
        Scoreboard(score + "Slot"),
        Team.add("noColission"),
        Team.modify("noColission", collision: ModifyTeam.never),
        Tag(name + "Holding2", entity: Entity.All(tags: [name + "Holding"])),
        Command(
          "execute as @a[tag=1vs1InLobby] store result score @s ${score}Slot run data get entity @s SelectedItemSlot",
        ),
        selectedItem.tag != null
            ? Entity.All(
                strNbt: '{SelectedItem:{id:"' +
                    selectedItem.type.toString() +
                    selItemTag +
                    '}}',
              ).addTag(name + "Holding")
            : Entity.All(
                strNbt: '{SelectedItem:{id:"' +
                    selectedItem.type.toString() +
                    '"}}',
              ).addTag(name + "Holding"),
        selectedItem.tag != null
            ? Entity.All(
                strNbt: '!{SelectedItem:{id:"' +
                    selectedItem.type.toString() +
                    selItemTag +
                    '}}',
              ).removeTag(name + "Holding")
            : Entity.All(
                strNbt: '!{SelectedItem:{id:"' +
                    selectedItem.type.toString() +
                    '"}}',
              ).removeTag(name + "Holding"),
        Execute.asat(
          Entity.All(tags: ["!" + name + "Holding2", name + "Holding"]),
          children: [
            Command(
                '/summon minecraft:armor_stand ^ ^ ^-0.5 {Invisible:1b,Invulnerable:1b,Marker:1b,NoGravity:1b,Passengers:[{id:"minecraft:villager",ActiveEffects:[{Id:10b,Amplifier:255b,Duration:19999980,ShowParticles:0b},{Id:14b,Amplifier:255b,Duration:19999980,ShowParticles:0b}],Invulnerable:1b,NoAI:1b,NoGravity:1b,Silent:1b,Tags:[' +
                    name +
                    ', ' +
                    name +
                    'Vill]}],Silent:1b,Tags:[' +
                    name +
                    ', ' +
                    name +
                    'Stand]}'),
            Team.join(
              "noColission",
              Entity(
                tags: [name + "Vill"],
              ),
            ),
          ],
        ),
        Execute.asat(
          Entity.All(tags: [name + "Holding2", "!" + name + "Holding"]),
          children: [
            Command('/tp @e[tag=' +
                name +
                ',distance=..3,sort=nearest,limit=2] ~ -200 ~'),
            Command(
                '/kill @e[tag=' + name + ',distance=..3,sort=nearest,limit=2]'),
          ],
        ),
        Entity.All(tags: [name + "Holding2"]).removeTag(name + "Holding2"),
        Execute(
          as: Entity(tags: [name]),
          at: Entity.Self(),
          If: Condition.not(
              Condition.entity(Entity.Player(distance: Range.to(3)))),
          location: Location.rel(y: -1),
          children: [
            Command('/tp @s ~ -500 ~'),
            Command('/kill @s'),
          ],
        ),
        Execute(
          as: Entity(tags: [name + "Holding"]),
          at: Entity.Self(),
          location: Location.rel(y: 1.5),
          children: [
            Command('/tp @e[tag=' +
                name +
                'Stand, distance=..3,sort=nearest,limit=1] ^ ^ ^'),
          ],
        ),
        Execute.asat(
          Entity.All(
              scores: [
                _scorel.matchesRange(
                  Range.from(1),
                ),
              ],
              strNbt: selectedItem != null
                  ? '{SelectedItem:{id:"' +
                      selectedItem.type.toString() +
                      selItemTag +
                      '}}'
                  : '{SelectedItem:{id:"' +
                      selectedItem.type.toString() +
                      '"}}'),
          children: [
            File.execute(path + score + "l", create: false),
          ],
        ),
        Execute.asat(
          Entity.All(
              scores: [
                _scorer.matchesRange(
                  Range.from(1),
                ),
              ],
              strNbt: selectedItem != null
                  ? '{SelectedItem:{id:"' +
                      selectedItem.type.toString() +
                      selItemTag +
                      '}}'
                  : '{SelectedItem:{id:"' +
                      selectedItem.type.toString() +
                      '"}}'),
          children: [
            File.execute(path + score + "r", create: false),
          ],
        ),
      ]);
    }

    return Tellraw(Entity.All(), show: [TextComponent("Error: CustomClickEvent.dart#generate(Context)", color: Color.DarkRed)]);
  }

  @override
  List<File> registerFiles() => <File>[
        File(
          path + score + "l",
          child: For.of([
            onLeftClick,
            _scorel.set(0),
          ]),
        ),
        File(
          path + score + "r",
          child: For.of([
            onRightClick,
            _scorer.set(0),
          ]),
        ),
      ];
}
