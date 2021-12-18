part of custom_tool;

class AnimatedTitle extends Widget {
  static int index = 0;

  Entity target;
  List<Frame> frames = [], title_frames = [], subtitle_frames = [], actionbar_frames = [];
  String type = "";
  int ticks = 0;
  String tag = "atShow";

  AnimatedTitle(this.target, this.frames, {this.ticks = 1, this.tag = "atShow"}) {
    type = "title";
  }
  AnimatedTitle.subtitle(this.target, this.frames, {this.ticks = 1}) {
    type = "subtitle";
  }
  AnimatedTitle.actionbar(this.target, this.frames, {this.ticks = 1}) {
    type = "actionbar";
  }
  AnimatedTitle.title_subtitle(
      this.target, this.title_frames, this.subtitle_frames,
      {this.ticks = 1}) {
    type = "title_subtitle";
  }
  AnimatedTitle.all(
    this.target,
    this.title_frames,
    this.subtitle_frames,
    this.actionbar_frames, {
    this.ticks = 1,
  }) {
    type = "all";
  }

  @override
  generate(Context context) {
    int tick = ticks;
    List<Widget> commands = [Title.times(target, fadein: 0)]; //STOP FLICKERING
    commands.add(target.addTag(tag));
    target = Entity.All(tags: [tag]);


    List<TextComponent> show = [];
    for (var frame in frames) {
      for (var t in frame.text) {
        show.add(t);
      }

      switch (type) {
        case "title":
          commands.add(
            Timeout(
              "at$index",
              children: [Title(target, show: show)],
              ticks: tick,
              path: "animtitle",
            ),
          );
          break;
        case "subtitle":
          commands.add(
            Timeout(
              "at$index",
              children: [Title.subtitle(target, show: show)],
              ticks: tick,
              path: "animtitle",
            ),
          );
          break;
        case "actionbar":
          commands.add(
            Timeout(
              "at$index",
              children: [Title.actionbar(target, show: show)],
              ticks: tick,
              path: "animtitle",
            ),
          );
          break;
        default:
      }

      index++;
      tick += ticks;
      show.clear();
    }

    commands.add(
      Timeout(
        "at$index",
        children: [
          Title.resetTimes(target),
          Tag(tag, entity: Entity.All()).removeIfExists(),
        ],
        ticks: tick + 80,
        path: "animtitle",
      ),
    );
    return commands;
  }
}

class Frame {
  List<TextComponent> text = [];

  Frame(this.text);
  Frame.string(String str) {
    this.text = strToTextComponent(str);
  }
}
