import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:lavenz/data/storage.dart';
import 'package:lavenz/firebase_analytics_service/firebase_analytics_service.dart';
import 'package:lavenz/modules/auth/login/login_screen.dart';
import 'package:lavenz/modules/home/home_screen.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  VideoPlayerController? videoPlayerController;
  FirebaseAnalyticsService firebaseAnalyticsService =
      FirebaseAnalyticsService();

  @override
  Future<void> onInit() async {
    super.onInit();

    videoPlayerController =
        VideoPlayerController.asset('assets/background/vd3.mp4')
          ..initialize().then((_) {
            videoPlayerController?.play();
            videoPlayerController?.setLooping(true);
            videoPlayerController?.setVolume(0);
          });
    firebaseAnalyticsService.evenFistOpen();
    changeUI();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
  }

  Future<void> checkLogin() async {
    var dataUser = await box.read(Storages.dataUser);
    //kiểm tra dữ liệu user và thời gian đăng nhập
    // Future.delayed(const Duration(seconds: 5), () {
    //   Get.offAndToNamed(HomeScreen.routeName);
    // });
    try {
      await checkHMS();
    } on Exception catch (_) {}
    if (dataUser != null && await checkLoginTimeOut()) {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAndToNamed(HomeScreen.routeName);
      });
    } else {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAndToNamed(LoginScreen.routeName);
      });
    }
  }

  Future<bool> checkLoginTimeOut() async {
    var dataTimeOut = await box.read(Storages.dataLoginTime);
    if (dataTimeOut != null) {
      // Kiểm tra một thời điểm có nằm trong một khoảng thời gian hay không
      try {
        DateTime dateTime = DateTime.now();
        DateTime startDate = DateTime.parse(dataTimeOut);
        DateTime endDate =
            startDate.add(const Duration(hours: Config.dataLoginTimeOut));
        if (dateTime.isAfter(startDate) && dateTime.isBefore(endDate)) {
          return true;
        } else {}
      } on Exception catch (_) {
        return false;
      }
    }
    return false;
  }

  Future<void> checkHMS() async {
    HmsApiAvailability client = HmsApiAvailability();
    // 0: HMS Core (APK) is available.
// 1: No HMS Core (APK) is found on device.
// 2: HMS Core (APK) installed is out of date.
// 3: HMS Core (APK) installed on the device is unavailable.
// 9: HMS Core (APK) installed on the device is not the official version.
// 21: The device is too old to support HMS Core (APK).
    int status = await client.isHMSAvailable();
    //print('trang thai hms: $status');
    if (status != 0) {
      // Set a listener to track events
      client.setResultListener = ((AvailabilityResultListener listener) {})
          as AvailabilityResultListener;
      client.getErrorDialog(status, 1000, true);
    }

// Specify the status code you get, a request code and decide if
// you want to listen dialog cancellations.
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
