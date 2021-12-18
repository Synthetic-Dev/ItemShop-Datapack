part of custom_tool;

class AddObjdConsts extends Widget {
  int to;
  AddObjdConsts([this.to = 20]);

  @override
  generate(Context context) {
    return For.of([
      Scoreboard("objd_consts"),
      For(
        to: this.to,
        create: (int i) {
          return Score(
            Entity.PlayerName("#$i"),
            "objd_consts",
          ).set(i);
        },
      ),
    ]);
  }
}
