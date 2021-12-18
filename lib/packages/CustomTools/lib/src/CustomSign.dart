part of custom_tool;

class CustomSign extends Module {
  static String prefix = "objd";

  static int index = 0;

  String firstLine;
  int to = 0;
  bool createOnlyOneStorage = true;
  Entity target;
  Text text;
  List<Widget> beforeText;
  List<Widget> afterText;

  String _type = "string";

  ///
  ///
  /// Text() use Entity(tags: ["EditSignFirstTime"]) for all Entity.Self()
  /// tags
  ///
  CustomSign.string(
    this.firstLine,
    this.target, {
    required this.beforeText,
    required this.text,
    required this.afterText,
  });

  @override
  generate(Context context) {
    switch (_type) {
      case "string":
        return For.of([
          //Detect new Signs
          if (index < 1) MCFunction("signs/oak"),
          if (index < 1) MCFunction("signs/dark_oak"),
          if (index < 1) MCFunction("signs/oak_wall"),
          if (index < 1) MCFunction("signs/dark_oak_wall"),
          if (index < 1) MCFunction("signs/birch"),
          if (index < 1) MCFunction("signs/birch_wall"),
          if (index < 1) MCFunction("signs/spruce"),
          if (index < 1) MCFunction("signs/spruce_wall"),
          if (index < 1) MCFunction("signs/jungle"),
          if (index < 1) MCFunction("signs/jungle_wall"),
          if (index < 1) MCFunction("signs/acacia"),
          if (index < 1) MCFunction("signs/acacia_wall"),
          if (index < 1) MCFunction("signs/crimson"),
          if (index < 1) MCFunction("signs/crimson_wall"),
          if (index < 1) MCFunction("signs/warped"),
          if (index < 1) MCFunction("signs/warped_wall"),

          //Execute as brand new sign => check if header is there
          Command(
            "execute as @e[tag=${prefix}BrandNewSign] at @s if data block ~ ~ ~ {Text1:'{\"text\":\"${firstLine}\"}'} run tag @s add ${prefix}newSign${index}",
          ),
          Execute.asat(
            Entity(tags: ["${prefix}newSign${index}"]),
            children: [
              MCFunction("signs/new_sign${index}"),
            ],
          ),
          Entity(
            tags: ["${prefix}newSign${index}"],
          ).removeTags([
            "${prefix}BrandNewSign",
            "${prefix}newSign${index}",
          ]),
        ]);
        index++;
        break;
      default:
        return Say("Error: CustomSign.dart");
    }
  }

  @override
  List<File> registerFiles() {
    beforeText.add(text);
    beforeText.addAll(afterText);
    return [
      File(
        "signs/oak",
        child: DetectBlock(Blocks.oak_sign, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/oak_wall",
        child: DetectBlock(Blocks.oak_sign,
            isWallBlock: true, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/dark_oak",
        child: DetectBlock(Blocks.dark_oak_sign, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/dark_oak_wall",
        child: DetectBlock(Blocks.dark_oak_sign,
            isWallBlock: true, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/spruce",
        child: DetectBlock(Blocks.spruce_sign, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/spruce_wall",
        child: DetectBlock(Blocks.spruce_sign,
            isWallBlock: true, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/birch",
        child: DetectBlock(Blocks.birch_sign, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/birch_wall",
        child: DetectBlock(Blocks.birch_sign,
            isWallBlock: true, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/jungle",
        child: DetectBlock(Blocks.jungle_sign, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/jungle_wall",
        child: DetectBlock(Blocks.jungle_sign,
            isWallBlock: true, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/acacia",
        child: DetectBlock(Blocks.acacia_sign, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/acacia_wall",
        child: DetectBlock(Blocks.acacia_sign,
            isWallBlock: true, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/crimson",
        child: DetectBlock(Blocks.crimson_sign, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/crimson_wall",
        child: DetectBlock(Blocks.crimson_sign,
            isWallBlock: true, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/warped",
        child: DetectBlock(Blocks.warped_sign, tag: "${prefix}BrandNewSign"),
      ),
      File(
        "signs/warped_wall",
        child: DetectBlock(Blocks.warped_sign,
            isWallBlock: true, tag: "${prefix}BrandNewSign"),
      ),
      // NEW SIGN
      File(
        "signs/new_sign${index}",
        child: NewSign(this.target, prefix, index),
      ),
      //set Text1 to Text4
      File(
        "signs/first_set_sign${index++}",
        child: For.of(beforeText),
      ),
    ];
  }
}

class Text extends Widget {
  List<TextComponent> line1, line2, line3, line4;
  String l1 = '{"extra":[',
      l2 = '{"extra":[',
      l3 = '{"extra":[',
      l4 = '{"extra":[';

  Text({
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
  }) {

    for (var i = 0; i < line1.length; i++) {
      l1 += line1[i].toJson()!;
      if (i != line1.length - 1)
        l1 += ",";
      else
        l1 += '],"text":""}';
    }
    for (var i = 0; i < line2.length; i++) {
      l2 += line2[i].toJson()!;
      if (i != line2.length - 1)
        l2 += ",";
      else
        l2 += '],"text":""}';
    }
    for (var i = 0; i < line3.length; i++) {
      l3 += line3[i].toJson()!;
      if (i != line3.length - 1)
        l3 += ",";
      else
        l3 += '],"text":""}';
    }
    for (var i = 0; i < line4.length; i++) {
      l4 += line4[i].toJson()!;
      if (i != line4.length - 1)
        l4 += ",";
      else
        l4 += '],"text":""}';
    }
  }

  @override
  generate(Context context) {
    return For.of([
      Data.modify(
        Location.here(),
        path: "Text1",
        modify: DataModify.set('\'${l1}\''),
      ),
      Data.modify(
        Location.here(),
        path: "Text2",
        modify: DataModify.set('\'${l2}\''),
      ),
      Data.modify(
        Location.here(),
        path: "Text3",
        modify: DataModify.set('\'${l3}\''),
      ),
      Data.modify(
        Location.here(),
        path: "Text4",
        modify: DataModify.set('\'${l4}\''),
      ),
    ]);
  }
}

class NewSign extends Widget {
  Entity e;
  String prefix;
  int index;
  NewSign(this.e, this.prefix, this.index);

  @override
  generate(Context context) {
    // Test if the Text2 equals any AS name
    return For.of([
      Execute(
        as: e,
        at: Entity(tags: ["${prefix}newSign${index}"]),
        children: [
          Tag("${prefix}editNewSign${index}", value: true),
          IsEquals(
            Location.here(),
            "Text2",
            Entity.Self(),
            "CustomName",
            onTrue: [
              Execute.asat(
                  Entity(
                    tags: ["${prefix}newSign${index}"],
                  ),
                  children: [
                    Tag("EditSignFirtsTime"),
                    MCFunction("signs/first_set_sign${index}"),
                    Tag("EditSignFirtsTime", value: false),
                  ]),
            ],
          ),
          Tag("${prefix}editNewSign${index}", value: false),
          Tag(
            "${prefix}newSign${index}",
            value: false,
            entity: Entity(
              tags: ["${prefix}newSign${index}"],
            ),
          ),
        ],
      ),
      Entity(
        tags: ["${prefix}newSign${index}"],
      ).removeTag(
        "${prefix}newSign${index}",
      ),
    ]);
  }
}
