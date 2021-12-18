part of custom_tool;

class DropGui extends Module {
  static int index = 0;

  String prefix;
  List<Page> pages;

  DropGui(this.pages, {this.prefix = "objd"});

  @override
  generate(Context context) {
    return For.of([
      Scoreboard(prefix + "Page"),
    ]);
  }

  // Register a new file for every page
  @override
  List<File> registerFiles() {
    List<File> files = [];

    for (var p in pages) {
      files.add(
        File(
          "dropgui/page${index}",
          child: _genPage(p),
        ),
      );
    }

    return files;
  }

  _genPage(Page page) {
    return page;
  }
}

class GuiItem {
  Item item;
  Widget widget;

  GuiItem(this.item, this.widget);
}

// A page can hold up to 9 items with each a widget
class Page extends Widget {
  List<GuiItem> hotbar = [];

  Page({
    GuiItem? h0 = null,
    GuiItem? h1 = null,
    GuiItem? h2 = null,
    GuiItem? h3 = null,
    GuiItem? h4 = null,
    GuiItem? h5 = null,
    GuiItem? h6 = null,
    GuiItem? h7 = null,
    GuiItem? h8 = null,
  }) {
    if (h0 != null) hotbar.add(h0);
    if (h1 != null) hotbar.add(h1);
    if (h2 != null) hotbar.add(h2);
    if (h3 != null) hotbar.add(h3);
    if (h4 != null) hotbar.add(h4);
    if (h5 != null) hotbar.add(h5);
    if (h6 != null) hotbar.add(h6);
    if (h7 != null) hotbar.add(h7);
    if (h8 != null) hotbar.add(h8);
  }

  // generate a page with its contents to generate the gui
  @override
  generate(Context context) {
    List<Widget> widgets = [];
    for (var i = 0; i < hotbar.length; i++) {
      widgets.add(hotbar[i].widget);
    }
    return widgets;
  }
}
