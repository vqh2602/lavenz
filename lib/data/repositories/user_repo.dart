import 'dart:convert';
import 'dart:developer';

import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/data/repositories/repo.dart';
import 'package:lavenz/data/storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lavenz/widgets/build_toast.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

class UserRepo extends Repo {
  GetStorage box = GetStorage();

  // đăng nhập
  Future<User?> loginWithGoogle() async {
    User? user;
    String error = '';
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      //print(error);
      error = e.toString();
    }
    if (_googleSignIn.currentUser != null) {
      user = User(
          email: _googleSignIn.currentUser?.email,
          id: _googleSignIn.currentUser?.id,
          name: _googleSignIn.currentUser?.displayName);
      await box.write(Storages.dataUser, user.toJson());
      await box.write(Storages.dataLoginTime, DateTime.now().toString());
      buildToast(
          status: TypeToast.getSuccess,
          title: 'Đăng nhập thành công',
          message: 'Chào mừng ${user.name}');
    } else {
      buildToast(
          status: TypeToast.getError, title: 'có lỗi sảy ra', message: error);
    }
    log('Đăng nhập, user: ${_googleSignIn.currentUser}');
    return user;
  }

  Future<User?> loginWithApple() async {
    User? user;
    String error = '';
    AuthorizationCredentialAppleID? credential;
    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        //nonce: nonce,
        // webAuthenticationOptions: WebAuthenticationOptions(
        //   clientId: 'com.vqh2602.lavenz',
        //   redirectUri: Uri.parse('https://lavenz-d7f47.firebaseapp.com/__/auth/handler'),
        // ),
      );
    } catch (e) {
      error = e.toString();
    }
    //print('login apple: ${credential.toString()}');

    if (credential?.userIdentifier != null) {
      user = User(
          email: credential?.email,
          id: credential?.userIdentifier,
          name: credential?.givenName);
      await box.write(Storages.dataUser, user.toJson());
      await box.write(Storages.dataLoginTime, DateTime.now().toString());
      buildToast(
          status: TypeToast.getSuccess,
          title: 'Đăng nhập thành công',
          message: 'Chào mừng ${user.name}');
    } else {
      buildToast(
          status: TypeToast.getError, title: 'có lỗi sảy ra', message: error);
    }
    log('Đăng nhập, user: ${_googleSignIn.currentUser}');
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
      // buildToast(type: TypeToast.success, title: result['message']);
    } else {
      //   buildToast(type: TypeToast.failure, title: result["message"]);
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
      // buildToast(
      //   type: TypeToast.success,
      //   title: 'Cập nhật thành công',
      // );
    } else {
      // buildToast(
      //     type: TypeToast.failure, title: result["message"] ?? 'Có lỗi xảy ra');
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
      // buildToast(
      //   type: TypeToast.success,
      //   title: 'Cập nhật thành công',
      // );
    } else {
      // buildToast(
      //     type: TypeToast.failure, title: result["message"] ?? 'có lỗi sảy ra');
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
      // buildToast(
      //   type: TypeToast.success,
      //   title: 'thêm bài tập thành công',
      // );
    } else {
      // buildToast(
      //     type: TypeToast.failure, title: result["message"] ?? 'có lỗi sảy ra');
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
      // buildToast(
      //   type: TypeToast.success,
      //   title: 'Thêm bài tập training thành công',
      // );
    } else {
      // buildToast(
      //   type: TypeToast.failure,
      //   title: result["message"] ?? 'Có lỗi xảy ra',
      // );
    }
  }
}
