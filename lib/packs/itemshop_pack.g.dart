// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemshop_pack.dart';

// **************************************************************************
// WidgetGenerator
// **************************************************************************

class Loaded extends Widget {
  Loaded();

  @override
  Widget generate(Context context) => loaded(
        context,
      );
}

class DefaultPermissions extends Widget {
  DefaultPermissions();

  @override
  Widget generate(Context context) => defaultPermissions();
}

class TestCommand extends Widget {
  TestCommand();

  @override
  Widget generate(Context context) => testCommand();
}

// **************************************************************************
// FileGenerator
// **************************************************************************

final File LoadFile = File(
  '/load',
  child: For.of(load),
);

final File TickFile = File(
  '/tick',
  child: For.of(tick),
);

// **************************************************************************
// PackGenerator
// **************************************************************************

class ItemShopPack extends Widget {
  @override
  Widget generate(Context context) => Pack(
        name: 'itemshop',
        files: itemShop,
        main: File('tick', create: false),
        load: File('load', create: false),
      );
}
