import 'dart:async';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:huawei_awareness/huawei_awareness.dart';
import 'package:huawei_location/huawei_location.dart';
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/widgets/mixin/admod_mixin.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class DashBroadController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin, ADmodMixin {
  VideoPlayerController? videoPlayerController;
  User? user;
  NativeAd? myNative;
  bool isAdLoad = false;
  FusedLocationProviderClient locationService = FusedLocationProviderClient();
  WeatherResponse? weatherResponse;
  
  @override
  Future<void> onInit() async {
    initData();
    checkLocationAndGetWeather();
    super.onInit();
  }

  initVideoBackground() {
    videoPlayerController =
        VideoPlayerController.asset('assets/background/vd3.mp4')
          ..initialize().then((_) {
            videoPlayerController?.play();
            videoPlayerController?.setLooping(true);
            videoPlayerController?.setVolume(0);
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
    myNative?.dispose();
  }

  initData() async {
    loadingUI();
    user = getUserInBox();
    myNative = await createADNative(onLoad: () {
      isAdLoad = true;
      updateUI();
    }, onFaile: () {
      isAdLoad = false;
      updateUI();
    });

    changeUI();
  }
  //**Lấy vị trí và thông tin thời tiết */
  Future<void> checkLocationAndGetWeather() async {
    loadingUI();
    var status = await Permission.location.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await Permission.location.request();
      openAppSettings();
      return;
    }
// vị trí
    LocationRequest locationRequest = LocationRequest();
    LocationSettingsRequest locationSettingsRequest1 = LocationSettingsRequest(
      requests: <LocationRequest>[locationRequest],
      needBle: true,
      alwaysShow: true,
    );

    try {
      // LocationSettingsStates states =
      await locationService.checkLocationSettings(locationSettingsRequest1);
    } catch (e) {
      // print(e.toString());
    }
    try {
      Location location = await locationService.getLastLocation();
      await getWeather(location);
    } catch (e) {
      // print(e.toString());
    }
    changeUI();
  }

  Future<WeatherResponse?> getWeather(Location location) async {
    //print('thoitiet1: ');
    weatherResponse = await AwarenessCaptureClient.getWeatherByDevice();
    //  print('thoitiet: ${response.toString()}');
    updateUI();
    return weatherResponse;
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
