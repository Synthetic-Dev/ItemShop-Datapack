part of custom_tool;

class Line extends Widget {
  
  Color color;
  String content;
  bool scroll;
 
  Line(this.content, {this.color = Color.Black, this.scroll = false});

  @override
  Widget generate(Context context) {
    if(color != null) {
      return For.of([
      
        Team.add(
          "objd_team_" + color.toString(),
	        color: color,
        ),
        //Fake player join team
        Team.join("objd_team_" + color.toString(), Entity.PlayerName(content)),
      ]);
    }
    return Team.join("objd_team_" + color.toString(), Entity.PlayerName(content));
  }
}

class Sidebar extends Widget {

  static int index = 0;

  bool active;
  String score;
  TextComponent title;
  List<Line> contentReverse;

  Sidebar(this.title, this.contentReverse, {this.score = "objd_sb_", this.active = true});

  @override
  Widget generate(Context context) {
    index++;

    var content = new List.from(contentReverse.reversed);

    return For.of([
      //Create Teams
      For(to: content.length - 1,
        create: (int i) {
          return Team.add("objd_sb_" + content[i].color.toString(), color: content[i].color);
        }
      ),

      //Create scoreboard
      Scoreboard(score + index.toString(), type: "dummy", display: title),

      //Get the content in
      For(
        to: content.length - 1,
        create: (int i) {
            For ret = For.of([
              Score(Entity.PlayerName(content[i].content), score + index.toString()).set(i),
              Team.join("objd_sb_" + content[i].color.toString(), Entity.PlayerName(content[i].content))
            ]);

            return ret;
        }
      ),

      //Display it
      Scoreboard.setdisplay(score + index.toString()),
      
    ]);
  }
}