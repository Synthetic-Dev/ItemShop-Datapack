part of custom_tool;

class DetectBlock extends Widget {
  Block _block;
  String wallBlock = "";
  String block = "";
  String tag;
  bool isWallBlock;

  static int index = 0;

  DetectBlock(this._block,
      {this.tag = "objd_detect", this.isWallBlock = false}) {
    block = _block.toString().substring(10);

    if (isWallBlock) {
      var temp1 = block.substring(0, block.lastIndexOf("_") + 1);
      var temp2 = block.substring(block.lastIndexOf("_") + 1);

      wallBlock = temp1 + "wall_" + temp2;
    }
  }

  @override
  generate(Context context) {
    String scoreBoard = "";
    if (isWallBlock) scoreBoard = "pWall" + block;
    if (!isWallBlock) scoreBoard = "placed" + block;

    if (scoreBoard.length > 16) scoreBoard = scoreBoard.substring(0, 16);

    return For.of([
      //Base Stuff
      Scoreboard("Detect$index"),

      //Block
      Scoreboard(
        scoreBoard,
        type: "minecraft.used:minecraft." + block,
      ),

      //MAIN
      Comment("Summon all ARC to detect where the block is"),
      Execute(
        at: Entity.All(
          scores: [
            Score(
              Entity.Self(),
              "Detect$index",
            ).matches(1),
          ],
        ),
        children: [
          For(
            from: -6,
            to: 6,
            create: (int i) {
              return For.of([
                For(
                  from: -6,
                  to: 6,
                  create: (int j) {
                    return For.of([
                      Command(
                          "summon minecraft:area_effect_cloud ~$i ~-6 ~$j {Tags:[\"Detect$index\"],Age:-2147483648,Duration:-1,WaitTime:-2147483648}"),
                    ]);
                  },
                ),
              ]);
            },
          ),
        ],
      ),
      Score(
        Entity.All(
          scores: [
            Score(
              Entity.Self(),
              "Detect$index",
            ).matchesRange(
              Range.from(1),
            ),
          ],
        ),
        "Detect$index",
      ).add(1),

      Comment("Place the ARC with a custom tag on the selected block"),
      Execute(
        as: Entity(
          tags: ["Detect$index"],
        ),
        at: Entity.Self(),
        align: "xyz",
        children: [
          Tp(
            Entity.Self(),
            to: Location.rel(y: 1),
          ),
          If(
            Condition.and([
              if (!isWallBlock) Condition.block(Location.here(), block: _block),
              if (isWallBlock)
                Condition.block(Location.here(), block: Block(wallBlock)),
            ]),
            then: [
              ArmorStand.staticMarker(
                Location.rel(x: 0.5, z: 0.5),
                tags: [block + "Tmp"],
                small: true,
              ),
            ],
          ),
          Execute(
            at: Entity(
              tags: [block + "Tmp"],
            ),
            unless: Condition.entity(
              Entity(
                tags: [
                  block,
                ],
                distance: Range.to(1),
              ),
            ),
            children: [
              AreaEffectCloud.persistent(
                Location.here(),
                tags: [
                  block,
                  tag,
                ],
              ),
            ],
          ),
          Execute.as(
            Entity(
              tags: [block + "Tmp"],
            ),
            children: [
              Kill(),
            ],
          ),
        ],
      ),
      Execute.as(
        Entity(
          scores: [
            Score(Entity.Self(), "Detect$index").matchesRange(
              Range.from(18),
            ),
          ],
        ),
        children: [
          Kill(
            Entity(
              tags: ["Detect$index"],
            ),
          ),
          Score(Entity.Self(), "Detect$index").set(0),
        ],
      ),

      Comment("Detect " + block),
      Score(
        Entity.All(
          scores: [
            Score(Entity.Self(), scoreBoard).matchesRange(
              Range.from(1),
            ),
          ],
        ),
        "Detect${index++}",
      ).add(1),
      Score(Entity.All(), scoreBoard).set(0),
      Execute(
        as: Entity(
          tags: [
            block,
          ],
        ),
        at: Entity.Self(),
        If: Condition.block(Location.here(), block: Blocks.air),
        children: [
          Kill(Entity.Self()),
        ],
      ),
    ]);
  }
}
