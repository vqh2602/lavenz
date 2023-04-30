import 'package:lavenz/main.dart' as base;
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  FlavorConfig(
    name: 'dev',
    variables: {
      "urlDataDown":"",
      "urlImages": "",
      "urlSvgIcons":"",
      "urlSounds": "https://www.example1.com",
      "urlMusics":""
    },
  );
  base.main();
}