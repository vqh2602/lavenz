import 'dart:convert';
import 'dart:developer';

import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/data/repositories/repo.dart';
import 'package:lavenz/data/storage.dart';
import 'package:lavenz/widgets/share_function/share_funciton.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/types/auth_messages_ios.dart';
class UserRepo extends Repo {
  GetStorage box = GetStorage();
  final LocalAuthentication auth = LocalAuthentication();
  // lấy thông tin ng dùng
  Future<User?> getUserByID(
      {required String userID, bool isCached = false}) async {
    User? user;
    if (isCached) {
      user = User.fromJson(jsonDecode(box.read(Storages.dataUser)));
    } else {
      var res = await dioRepo.get('/api/v1/users/$userID');
      var result = jsonDecode(res.toString());
      if (result["success"]) {
        user = User.fromJson(result['data']);
        await box.write(Storages.dataUser, jsonEncode(result['data']));
      } else {
        buildToast(type: TypeToast.failure, title: result["message"]);
      }
    }
    return user;
  }

  // đăng nhập
  Future<User?> loginWithEmail({
    required String email,
    required String passW,
  }) async {
    User? user;
    var res = await dioRepo
        .post('/api/login', data: {"email": email, "password": passW});
    var result = jsonDecode(res.toString());
    if (result["success"] ?? false) {
      user = User.fromJson(result['data']);
      await box.write(Storages.dataUser, jsonEncode(result['data']));
      await box.write(Storages.dataEmail, email);
      await box.write(Storages.dataPassWord, passW);
      await box.write(Storages.dataLoginTime, DateTime.now().toString());
      if (await box.read(Storages.historyDataEmail) != null &&
          await box.read(Storages.historyDataEmail) == email) {
      } else {
        await box.write(Storages.dataUrlAvatarUser, null);
      }
      // buildToast(
      //     type: TypeToast.success,
      //     title: 'Đăng nhập thành công',
      //     message: 'Chào mừng ${splitNameUser(name: user.name ?? '',isLastName: true)}');
    } else {
      buildToast(
          type: TypeToast.failure, title: result["message"] ?? 'có lỗi sảy ra');
    }
    log('Đăng nhập, user: ${user?.toJson().toString()}');
    return user;
  }

  // đăng nhập sinh trắc học
  Future<User?> loginWithBiometric() async {
    User? user;
    bool didAuthenticate = false;
    if (box.read(Storages.dataBiometric) ?? false) {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (canAuthenticate && availableBiometrics.isNotEmpty) {
        didAuthenticate = await auth.authenticate(
            localizedReason: 'Vui lòng xác thực',
            options: const AuthenticationOptions(
              stickyAuth: true,
            ),
            authMessages: <AuthMessages>[
              const AndroidAuthMessages(
                  signInTitle: 'Xác thực',
                  biometricHint: 'xác thực để tiếp tục',
                  cancelButton: 'Hủy',
                  biometricSuccess: 'Thành công!',
                  biometricRequiredTitle:
                      'Chưa thiết lập phương thức bảo mật nào',
                  biometricNotRecognized: 'Xác thực không thành công!',
                  goToSettingsButton: 'Cài đặt',
                  goToSettingsDescription: 'Chuyển đến cài đặt'),
              const IOSAuthMessages(
                cancelButton: 'Hủy',
              ),
            ]);
      }
    }
    if (didAuthenticate) {
      user = await loginWithEmail(
          email: box.read(Storages.dataEmail),
          passW: box.read(Storages.dataPassWord));
    } else {

      // Get.dialog(CupertinoAlertDialog(
      //   title: textBodyMedium(text: 'chưa bật đăng nhập bằng sinh trắc học'),
      // ));
    }
    log('Đăng nhập sinh trắc học, user: ${user?.toJson().toString()}');
    return user;
  }

  // đăng ký
  Future<void> signupWithEmail({
    required String name,
    required String email,
    required String passW,
    required String birth,
    required bool sex,
    required double height,
    required double weight,
    required String address,
    required String avatar,
  }) async {
    var res = await dioRepo.post('/api/register', data: {
      "name": name,
      "email": email,
      "birthday": birth,
      "gender": sex,
      "password": passW,
      "address": address,
      "weight": weight,
      "height": height,
      "avatar": avatar,
    });

    var result = jsonDecode(res.toString());
    if (result["success"]) {
      buildToast(type: TypeToast.success, title: result['message']);
    } else {
      buildToast(type: TypeToast.failure, title: result["message"]);
    }
  }

  Future<void> updateHeightWeight({
    required String userID,
    required double height,
    required double weight,
  }) async {
    var res = await dioRepo.patch('/api/v1/users/$userID', data: {
      "weight": height,
      "height": weight,
    });
    var result = jsonDecode(res.toString());
    if (result["success"] ?? false) {
      await box.write(Storages.dataUser, jsonEncode(result['data']));
      buildToast(
        type: TypeToast.success,
        title: 'Cập nhật thành công',
      );
    } else {
      buildToast(
          type: TypeToast.failure, title: result["message"] ?? 'Có lỗi xảy ra');
    }
  }

  // sửa
  Future<void> updateUser(
      {required String userID,
      required String name,
      String? avatar,
      String? address,
      required String birthday,
      required num sex,
      required double h,
      required double w}) async {
    var res = await dioRepo.put('/api/v1/users/$userID', data: {
      "name": name,
      "avatar": avatar ?? ' ',
      "address": address ?? ' ',
      "gender": sex,
      "weight": w,
      "height": h,
      "birthday": birthday,
      "updated_at": DateTime.now().toString(),
    });
    var result = jsonDecode(res.toString());
    if (result["success"] ?? false) {
      buildToast(
        type: TypeToast.success,
        title: 'Cập nhật thành công',
      );
    } else {
      buildToast(
          type: TypeToast.failure, title: result["message"] ?? 'có lỗi sảy ra');
    }
  }

  Future<void> addUserWorkOut(
      {required String userId,
      required String workoutId,
      required int min,
      required int calo}) async {
    var res = await dioRepo.post('/api/v1/users/$userId/workouts/$workoutId',
        data: {"workout_realtime": min, "calo_real": calo});
    var result = jsonDecode(res.toString());
    if (result["success"] ?? false) {
      buildToast(
        type: TypeToast.success,
        title: 'thêm bài tập thành công',
      );
    } else {
      buildToast(
          type: TypeToast.failure, title: result["message"] ?? 'có lỗi sảy ra');
    }
  }

  Future<void> updateStatusTraining({
    required String trainingId,
    required num status,
  }) async {
    var res = await dioRepo.patch(
      '/api/v1/trainings/$trainingId',
      data: {"status": status},
    );
    var result = jsonDecode(res.toString());
    if (result["success"] ?? false) {
      buildToast(
        type: TypeToast.success,
        title: 'Thêm bài tập training thành công',
      );
    } else {
      buildToast(
        type: TypeToast.failure,
        title: result["message"] ?? 'Có lỗi xảy ra',
      );
    }
  }


}
