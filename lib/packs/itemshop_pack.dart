import "package:objd/core.dart";
import "../packages/CustomTools/lib/core.dart";

// import "../files/load.dart";
// import "../files/tick.dart";

part "itemshop_pack.g.dart";

@Pck(name: "itemshop", load: "load", main: "tick")
final itemShop = [LoadFile, TickFile];

@Wdg
Widget loaded(Context context) => For.of([Log(context.packId + " loaded.")]);

@Wdg
Widget defaultPermissions() => For.of([
  Tag.add("OP", entity: Entity.All()),
  PlayerJoin(then: Tag.add("OP", entity: Entity.Self()))
]);

@Wdg
Widget testCommand() =>
    CustomCommand("test_command", "OP", children: [Log("test")]);

@Func()
final load = [
  DefaultPermissions(),
  TestCommand(),
  // testing sign events
  SetBlock(Blocks.oak_sign, location: Location("0 64 0"), nbt: {
    "Text2": TextComponent("test",
        clickEvent: TextClickEvent.run_command(Command("/say test")))
  }),
  Loaded()
];

@Func()
final tick = <Widget>[];
