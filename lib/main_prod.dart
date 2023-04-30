import 'package:lavenz/main.dart' as base;
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  FlavorConfig(
    name: 'prod',
    variables: {
      "counter": 0,
      "baseUrl": "https://www.example1.com",
    },
  );
  base.main();
}