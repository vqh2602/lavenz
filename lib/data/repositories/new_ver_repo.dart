import 'dart:convert';
import 'package:lavenz/data/repositories/repo.dart';
import 'package:get_storage/get_storage.dart';

class NewVersionRepo extends Repo {
  GetStorage box = GetStorage();

  // lấy thông tin phiên bản mới
  Future<Map<String,dynamic>> getNewVersion() async {
    var res = await dioRepo.get('/public/down_data.json');
    Map<String, dynamic> result = jsonDecode(res.toString());
    //print('data new json ${result}');
    return result;
  }
}
