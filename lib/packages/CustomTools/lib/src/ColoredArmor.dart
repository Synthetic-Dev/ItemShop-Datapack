part of custom_tool;

int hexToInt(String color){
  return int.parse(color.replaceFirst("#", ""), radix: 16);
}

class ColoredArmor extends Widget {
  String color;
  int armor = 0;
  Item leather_armor = Item(Items.leather_chestplate);
  Entity target = new Entity.All();

  ColoredArmor.helmet(this.color) {
    armor = 1;
  }
  ColoredArmor.chestplate(this.color) {
    armor = 2;
  }
  ColoredArmor.leggins(this.color) {
    armor = 3;
  }
  ColoredArmor.boots(this.color) {
    armor = 4;
  }
  ColoredArmor.horseArmor(this.color) {
    armor = 5;
  }


  @override
  generate(Context context) {
    switch (armor) {
      case 1:
          return Command('give ' + target.toString() + ' minecraft:leather_helmet{display:{"color":' + hexToInt(color).toString() + '}}');
        break;
      case 2:
          return Command('give ' + target.toString() + ' minecraft:leather_chestplate{display:{"color":' + hexToInt(color).toString() + '}}');
        break;
      case 3:
          return Command('give ' + target.toString() + ' minecraft:leather_leggings{display:{"color":' + hexToInt(color).toString() + '}}');
        break;
      case 4:
          return Command('give ' + target.toString() + ' minecraft:leather_boots{display:{"color":' + hexToInt(color).toString() + '}}');
        break;
      case 5:
          return Command('give ' + target.toString() + ' minecraft:leather_horse_armor{display:{"color":' + hexToInt(color).toString() + '}}');
        break;
      default:
        return Command('give ' + target.toString() + ' minecraft:leather_helmet{display:{"color":' + hexToInt(color).toString() + '}}');
    }
    
  }
}
