part of custom_tool;

class CopyAllItems extends Widget {

  Entity copyTo = Entity(), copyFrom = Entity();
  Location copyToLoc = Location.glob(), copyFromLoc = Location.glob();

  CopyAllItems.block(this.copyToLoc, this.copyFromLoc);
  CopyAllItems.entity(this.copyTo, this.copyFrom);

  @override
  generate(Context context) {
    List<Command> wl = [];
    for (var i = 0; i < 27; i++) {
      if(copyTo != null)
        wl.add(new Command("item entity " + copyTo.toString() + " container.$i copy entity " + copyFrom.toString() + " container.$i"));
      else
        wl.add(new Command("item block " + copyToLoc.toString() + " container.$i copy block " + copyFromLoc.toString() + " container.$i"));
    }
    return new CommandList(wl);
  }
}