import 'dart:async';
import 'package:get/get.dart';
import 'package:web_scraper/web_scraper.dart';

class HoroscopeController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  final webScraper = WebScraper('https://nypost.com');
  List<Map<String, dynamic>> title = [];
  List<Map<String, dynamic>> subTitle = [];
  List<Map<String, dynamic>> elements = [];
  @override
  Future<void> onInit() async {
    changeUI();
    Future.delayed(const Duration(milliseconds: 1000), () {
      initData();
    });
    super.onInit();
  }

  Future<void> initData() async {
    loadingUI();

    if (await webScraper.loadWebPage('/horoscopes')) {
      title = webScraper.getElement('h3.horoscope__heading > a', ['']);
    }
    if (await webScraper.loadWebPage('/horoscopes')) {
      subTitle = webScraper.getElement('span.horoscope__date', ['']);
    }
    if (await webScraper.loadWebPage('/horoscopes')) {
      elements = webScraper.getElement('div.horoscope__description > p', ['']);
      // print(jsonEncode(elements));
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

  String getZodiacImage(String name) {
    if (name.toLowerCase().contains('aries')) {
      return 'assets/background/aries.svg';
    }
    if (name.toLowerCase().contains('taurus')) {
      return 'assets/background/taurus.svg';
    }
    if (name.toLowerCase().contains('gemini')) {
      return 'assets/background/gemini.svg';
    }
    if (name.toLowerCase().contains('cancer')) {
      return 'assets/background/cancer.svg';
    }
    if (name.toLowerCase().contains('leo')) {
      return 'assets/background/leo.svg';
    }
    if (name.toLowerCase().contains('virgo')) {
      return 'assets/background/virgo.svg';
    }
    if (name.toLowerCase().contains('libra')) {
      return 'assets/background/libra.svg';
    }
    if (name.toLowerCase().contains('scorpio')) {
      return 'assets/background/scorpio.svg';
    }
    if (name.toLowerCase().contains('sagittarius')) {
      return 'assets/background/sagittarius.svg';
    }
    if (name.toLowerCase().contains('capricorn')) {
      return 'assets/background/capricorn.svg';
    }
    if (name.toLowerCase().contains('aquarius')) {
      return 'assets/background/aquarius.svg';
    }
    if (name.toLowerCase().contains('pisces')) {
      return 'assets/background/pisces.svg';
    }
    return 'assets/background/logo.svg';
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
