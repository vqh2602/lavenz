import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class QuoteRepo {
  GetStorage box = GetStorage();

  final dioRepo = Dio(BaseOptions(
    baseUrl: 'https://api.quotable.io',
    //baseUrl:'http://127.0.0.1:8080',
    // baseUrl: 'http://192.168.0.196:8080',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    receiveDataWhenStatusError: true,
    // 5s
    headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
    contentType: Headers.jsonContentType,
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: ResponseType.plain,
    validateStatus: (statusCode) {
      if (statusCode == null) {
        return false;
      }
      if (statusCode == 422 || statusCode == 400) {
        // your http status code
        return true;
      }
      if (statusCode >= 200 && statusCode < 300) {
        return true;
      } else {
        // buildToast(
        //     type: TypeToast.failure,
        //     title: 'Không thể kết nối đến máy chủ',
        //     message:
        //         'Vui lòng kiểm tra lại kết nối mạng hoặc liên hệ hỗ trợ báo cáo sự cố');
        return false;
      }
    },
  ));
  // lấy thông tin phiên bản mới
  Future<Map<String, dynamic>> getQuote() async {
    var res = await dioRepo.get('/random');
    //log('gift: $');
    Map<String, dynamic> result = jsonDecode(res.toString());
    //print('data new json ${result}');
    return result;
  }
}
