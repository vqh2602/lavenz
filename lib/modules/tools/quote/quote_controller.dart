import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lavenz/data/repositories/quote_repo.dart';
import 'package:lavenz/data/storage.dart';

class QuoteController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  QuoteRepo quoteRepo = QuoteRepo();
  Map<String, dynamic> dataQuote = {};
  @override
  Future<void> onInit() async {
    initData();
    super.onInit();
  }

  Future<void> initData() async {
    loadingUI();
    Map<String, dynamic>? dataBox;

    try {
      dataBox = jsonDecode(await box.read(Storages.dataQuote));
    } on Exception catch (_) {}

    if (dataBox != null &&
        int.parse(dataBox["days"].toString()) == DateTime.now().day) {
      dataQuote = dataBox;
    } else {
      dataQuote = await quoteRepo.getQuote();
      await box.write(
          Storages.dataQuote,
          jsonEncode({
            "days": DateTime.now().day,
            "author": dataQuote["author"],
            "content": dataQuote["content"]
          }));
    }
    // parser = await Chaleno().load('https://www.deccanchronicle.com/daily-astroguide');
    //  print(parser!.title());
    //  List<Result> results = parser!.getElementsByClassName('astroDates');
    //  print(results.length);
    //  for(var item in results){
    //   print(item.text);
    //   break;
    //  }
    // results.map((item) => print(item.text));
    changeUI();
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
