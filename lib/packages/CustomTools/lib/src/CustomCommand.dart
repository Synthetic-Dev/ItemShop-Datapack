part of custom_tool;

class CustomCommand extends Widget {
  //Command with permission
  //statics
  static String permission = "perms";
  static String shortPermission = "perms";
  static String starPermission = "OP";

  static String prefix = "";

  static int index = 0;

  //variables
  String command;
  List<String> permissions = [];
  List<Widget> children = [];
  bool addToLoad = true;
  int from = 1, to = 0;
  bool addPrefix;

  List<Entity> entityScore = [];
  List<Entity> entity = [];

  CustomCommand(this.command, dynamic perm,
      {this.children = const [],
      this.addToLoad = true,
      this.from = 1,
      this.to = 0,
      this.addPrefix = true}) {
    //Create permissions
    permissions = [];
    if (permission != null) permissions.add(permission + "." + starPermission);
    if (shortPermission != null)
      permissions.add(shortPermission + "." + starPermission);
    permissions.add(starPermission);

    if (perm is List) {
      for (var s in perm as List<String>) {
        permissions.addAll(_getPermissions(s));
      }
    } else
      permissions.addAll(_getPermissions(perm));

    if (prefix != null && addPrefix) command = prefix + command;

    for (var i = 0; i < permissions.length; i++) {
      entityScore.add(
        Entity.All(
          tags: [permissions[i]],
          scores: [
            Score(Entity.Self(), command).matchesRange(
              Range.from(from),
            ),
          ],
        ),
      );
    }
    for (var i = 0; i < permissions.length; i++) {
      entity.add(
        Entity.All(
          tags: [permissions[i]],
        ),
      );
    }
  }
  CustomCommand.Self(this.command,
      {required this.children,
      this.addToLoad = true,
      this.from = 1,
      this.addPrefix = true}) {
    if (prefix != null && addPrefix) command = prefix + command;

    entityScore.add(
      Entity.Self(
        scores: [
          Score(Entity.Self(), command).matchesRange(
            Range.from(from),
          ),
        ],
      ),
    );
    entity.add(
      Entity.Self(),
    );
  }
  CustomCommand.All(this.command,
      {required this.children,
      this.addToLoad = true,
      this.from = 1,
      this.addPrefix = true}) {
    if (prefix != null && addPrefix) command = prefix + command;

    entityScore.add(
      Entity.All(
        scores: [
          Score(Entity.Self(), command).matchesRange(
            Range.from(from),
          ),
        ],
      ),
    );
    entity.add(
      Entity.All(),
    );
  }

  @override
  Widget generate(Context context) {
    children.add(Score(Entity.Self(), command).set(to));

    List<Widget> checkedChildren = [
      If(
        Tag(command + "Done", entity: Entity.Self()),
        assignTag: Entity.Self(),
        then: children,
        orElse: [
          Score(Entity.Self(), command).set(to),
          Entity.Self().addTag(command + "Done"),
        ],
      ),
    ];

    index++;

    return For.of([
      if (addToLoad) Scoreboard(command, addIntoLoad: true, type: "trigger"),
      if (addToLoad)
        Extend('load', child: Score(Entity.All(), command).set(to)),

      if (true)
        IndexedFile("customcmd", path: "customcmd", child: For.of(children)),
      if (false)
        IndexedFile("customcmd",
            path: "customcmd", child: For.of(checkedChildren)),

      For(
        to: entity.length - 1,
        create: (int i) {
          return For.of([
            Comment.Separate(),
            Execute.asat(entityScore[i],
                children: [MCFunction("customcmd/customcmd$index")]),
          ]);
        },
      ),
      Comment.Separate(),
      //No permission msg
      Execute.asat(
        Entity.All(
          scores: [
            Score(Entity.Self(), command).matchesRange(
              Range.from(from),
            ),
          ],
        ),
        children: [
          Tellraw(
            Entity.Self(),
            show: [
              TextComponent(
                "Sorry, you don't have enough permissions.",
                color: Color.Red,
              ),
            ],
          ),
          Score(Entity.Self(), command).set(to),
        ],
      ),
      Comment.Separate(),
      //Enable
      Execute.as(
        Entity.All(),
        children: [
          Command('/scoreboard players enable ' +
              Entity.Self().toString() +
              ' ' +
              command),
        ],
      ),
    ]);
  }

  static List<String> _getPermissions(String _perm) {
    List<String> perm = [];

    if (permission != null) perm.add(permission + "." + _perm);
    if (shortPermission != null) perm.add(shortPermission + "." + _perm);

    List<String> a = _perm.split(".");

    StringBuffer stringBuffer = new StringBuffer();

    for (var i = 1; i < a.length; i++) {
      for (var j = 0; j < i; j++) {
        stringBuffer.write(a[j] + ".");
      }
      if (permission != null)
        perm.add(permission + "." + stringBuffer.toString() + starPermission);
      if (shortPermission != null)
        perm.add(
            shortPermission + "." + stringBuffer.toString() + starPermission);
      stringBuffer.clear();
    }

    return perm;
  }
}
