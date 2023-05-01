import 'package:lavenz/config/config.dart';
import 'package:lavenz/config/config_dev.dart' as dev;
import 'package:lavenz/config/config_prod.dart' as prod;
import 'package:lavenz/flavors.dart';

ModuleConfig getConfig() {
  switch (F.name.toLowerCase()) {
    case "dev":
      return dev.Environment();
    case "prod":
      return prod.Environment();
    default:
      return dev.Environment();
  }
}