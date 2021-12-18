part of custom_tool;

class Install extends Widget {
  int version;
  Item menuItem;
  Install(this.version, this.menuItem);

  @override
  generate(Context context) {
    String cmd = "1vs1Inst" + Game1vs1.name;
    if (cmd.length > 16) cmd = cmd.substring(0, 16);

    return For.of([
      CustomCommand(cmd, "build", children: [
        Component(Game1vs1.fullName, version, menuItem: menuItem),
        Tellraw(
          Entity.Self(),
          show: [
            TextComponent("${Game1vs1.fullName} installed successfully",
                color: Color.Green),
            TextComponent(
              "Use /trigger 1vs1Reload to activate the component",
              color: Color.Aqua,
            ),
          ],
        ),
      ]),
    ]);
  }
}
