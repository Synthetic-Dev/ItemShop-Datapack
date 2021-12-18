part of custom_tool;

class FireWork extends Widget {
  int flight;
  int lifeTime;
  Location? loc;
  List<Explosion> explosion;
  Entity? entity;

  FireWork(this.explosion, {this.loc = const Location.here(), this.flight = 2, this.lifeTime = 20});
  FireWork.summon(this.explosion, {this.loc = const Location.here(), this.flight = 2, this.lifeTime = 20});
  FireWork.give(
      this.entity, this.explosion, {this.flight = 2, this.lifeTime = 20});

  Widget generate(Context context) {
    var commandStr = new StringBuffer();
    if (entity != null) {
      commandStr.write('/give ' +
          entity.toString() +
          ' firework_rocket{LifeTime:' +
          lifeTime.toString() +
          ',FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Flight:' +
          flight.toString() +
          ',Explosions:[');
      for (var i = 0; i < explosion.length; i++) {
        commandStr.write(explosion[i].toString());
        if (i + 1 < explosion.length) commandStr.write(',');
      }
      commandStr.write("]}}}} 1");
      return Command(commandStr.toString());
    }
    commandStr.write('/summon firework_rocket ' +
        loc.toString() +
        ' {LifeTime:' +
        lifeTime.toString() +
        ',FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Flight:' +
        flight.toString() +
        ',Explosions:[');
    for (var i = 0; i < explosion.length; i++) {
      commandStr.write(explosion[i].toString());
      if (i + 1 < explosion.length) commandStr.write(',');
    }
    commandStr.write("]}}}}");
    return Command(commandStr.toString());
  }
}
