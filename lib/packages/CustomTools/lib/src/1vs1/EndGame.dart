part of custom_tool;

class EndGame extends Widget {
  String tag;
  EndGame(this.tag);

  @override
  generate(Context context) {
    return For.of([
      Execute.as(
        Entity.All(tags: [tag]),
        children: [
          Group(
            groupMin: 0,
            children: [
              Tag("1vs1SearchLobby"),
              Execute(
                as: Entity(tags: ["1vs1Lobby"]),
                If: Condition.score(
                  Score.fromSelected("1vs1LobbyID").isEqual(
                    Score(
                      Entity.All(tags: ["1vs1SearchLobby"], limit: 1),
                      "1vs1LobbyID",
                    ),
                  ),
                ),
                children: [
                  Teleport.entity(Entity.All(tags: ["1vs1SearchLobby"]),
                      to: Entity.Self()),
                  Tag(
                    "1vs1InLobby",
                    entity: Entity.All(tags: ["1vs1SearchLobby"]),
                  ),
                  Tag(
                    "1vs1InGame",
                    entity: Entity.All(tags: ["1vs1SearchLobby"]),
                    value: false,
                  ),
                  Entity.All(tags: ["1vs1SearchLobby"]).removeTag(tag),
                  SetGamemode(Gamemode.adventure, target: Entity.All(tags: ["1vs1SearchLobby"]),),
                ],
              ),
              Tag("1vs1SearchLobby", value: false),
            ],
          ),
        ],
      ),
    ]);
  }
}
