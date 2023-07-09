import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:huawei_safetydetect/huawei_safetydetect.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SafeKitHMS extends StatefulWidget {
  const SafeKitHMS({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyMLKitHMS();
  }
}

class _MyMLKitHMS extends State<SafeKitHMS> {
  DateTime? selectedDate = DateTime.now();
  String? appId;
  TextEditingController textEditingControllerUrl = TextEditingController();
  String urlcheck =
      'https://assets7.lottiefiles.com/packages/lf20_kgbbisxb.json';
  String urlRessul = 'Meow Meow . . .';

  // getAppId() async {
  //   String appID = await SafetyDetect.getAppID;
  //   setState(() {
  //     appId = appID;
  //   });
  // }
  //
  // checkSysIntegrity() async {
  //   Random secureRandom = Random.secure();
  //   List<int> randomIntegers = [];
  //   for (var i = 0; i < 24; i++) {
  //     randomIntegers.add(secureRandom.nextInt(255));
  //   }
  //   Uint8List nonce = Uint8List.fromList(randomIntegers);
  //   try {
  //     String result = await SafetyDetect.sysIntegrity(nonce, appId!);
  //     List<String> jwsSplit = result.split(".");
  //     String decodedText = utf8.decode(base64Url.decode(jwsSplit[1]));
  //     //showToast("SysIntegrityCheck result is: $decodedText");
  //   } on PlatformException catch (e) {
  //     //showToast("Error occured while getting SysIntegrityResult. Error is : $e");
  //   }
  // }

  // void urlCheck1() async {
  //   List<UrlThreatType> threatTypes = [
  //     UrlThreatType.malware,
  //     UrlThreatType.phishing
  //   ];
  //
  //   List<UrlCheckThreat> urlCheckResults =
  //   await SafetyDetect.urlCheck(
  //       'http://ctms.fithou.net.vn/', await SafetyDetect.getAppID, threatTypes);
  //  // print('ket qua: '+ await urlCheckResults[0].getUrlThreatType.toString());
  //
  //   if (await urlCheckResults.length == 0) {
  //     //showToast("No threat is detected for the URL");
  //   } else {
  //     urlCheckResults.forEach((element) {
  //       print("${element.getUrlThreatType} is detected on the URL");
  //     });
  //   }
  // }

  void urlCheck(String url) async {
    if (hasValidUrl(url)) {
      String concernedUrl = url;
      List<UrlThreatType> threatTypes = [
        UrlThreatType.malware,
        UrlThreatType.phishing
      ];
      List<UrlCheckThreat> urlCheckResults = await SafetyDetect.urlCheck(
          concernedUrl, await SafetyDetect.getAppID, threatTypes);
      if (urlCheckResults.isEmpty) {
        // print('an toan');
        setState(() {
          urlcheck =
              'https://assets7.lottiefiles.com/packages/lf20_yyylny0i.json';
          urlRessul = 'Website: $url seems safe';
        });
      } else {
        // ignore: unused_local_variable
        for (var element in urlCheckResults) {
          // print('nguy hiem');
          setState(() {
            urlcheck =
                'https://assets7.lottiefiles.com/packages/lf20_jvki4wd1.json';
            urlRessul = 'Website: $url is malware or phishing';
          });
        }
      }
      // print(urlCheckRes);
    } else {
      // print('sai url');
      setState(() {
        urlcheck =
            'https://assets7.lottiefiles.com/packages/lf20_kgbbisxb.json';
        urlRessul = 'Meow Meow . . .';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //getAppId();
    setState(() {
      textEditingControllerUrl.text = 'http://';
    });
    //Constructing request object.

//Call requestCameraAndStoragePermission API.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
      tag: 'tools5',
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/t6.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: BlurryContainer(
            //color: Colors.white30,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: InkWell(
                              onTap: () {
                                alertInfo();
                              },
                              child: Icon(
                                Icons.info_outline,
                                color: colorF3,
                                size: 35,
                              )),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: textEditingControllerUrl,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'do not leave blank';
                        } else if (!hasValidUrl(value)) {
                          return 'enter the correct format http://url.xyz/';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          LucideIcons.sparkles,
                          color: Colors.white,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorF3, width: 2.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: colorF3)),
                        labelStyle: const TextStyle(color: Colors.white),
                        labelText: 'enter url starting with http://',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        urlCheck(textEditingControllerUrl.text);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: colorF3,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          'Check url',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Inter',
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Lottie.network(urlcheck,
                              width: double.infinity * 0.7, fit: BoxFit.fill),
                        ),
                        SelectableLinkify(
                          text: urlRessul,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void alertInfo() {
    Alert(
      context: context,
      title: 'thông báo'.tr,
      // image: Lottie.asset('acssets/iconAnimation/search.json'),
      content: const Column(
        children: [
          Text(
            'Safety Detect Url Website',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'The Safety Detect Url checks for malicious URLs and provides you with security services which are easy-to-use, operations-free, and trustworthy, making implementing secure browsing services cheaper.',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          ),
          Text(
            'How does it work?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'first enter or paste the website link you want to check, then click the check button to check and the system will return the results',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          )
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  bool hasValidUrl(String value) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
