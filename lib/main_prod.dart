import 'main.dart' as base;
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.prod;
  base.main();
}
