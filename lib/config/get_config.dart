import 'dart:developer';

import 'package:lavenz/config/config.dart';
import 'package:lavenz/config/config_dev.dart' as dev;
import 'package:lavenz/config/config_prod.dart' as prod;
import 'package:lavenz/flavors.dart';

Future<ModuleConfig> getConfigBase() async {
  log('moi truong: ${F.name}');
  switch (F.appFlavor) {
    case Flavor.dev:
      return dev.Environment();
    case Flavor.prod:
      return prod.Environment();
    default:
      return dev.Environment();
  }
}
