part of custom_tool;

class MCFunction extends Widget {
  //function command

  //variables
  String path;

  MCFunction(this.path);

  @override
  Widget generate(Context context) {
    return For.of([
      Command('/function ' + context.packId + ":" + path),
    ]);
  }
}
