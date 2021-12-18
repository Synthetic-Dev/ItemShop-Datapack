part of custom_tool;

class Uninstall extends Widget {
  String entityTag;

  Uninstall([this.entityTag = ""]);

  @override
  generate(Context context) {
    List<Command> commands = [];

    commands.add(Command("kill @e[tag=${entityTag}]"));

    return commands;
  }
}
