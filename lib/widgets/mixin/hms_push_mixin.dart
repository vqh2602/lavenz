import 'package:huawei_push/huawei_push.dart';

mixin HmsPushMixin {
  void getId() async {
    // String? result =
    await Push.getId();
    // print('push kit: $result');
  }

  void getAAID() async {
    // String? result =
    await Push.getAAID();
    // print('push kit aaid: $result');
  }

  void getCreationTime() async {
    // String result =
    await Push.getCreationTime();
  }

  void getOdid() async {
    // String? result =
    await Push.getOdid();
  }
}
