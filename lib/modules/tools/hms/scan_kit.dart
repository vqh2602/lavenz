import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:huawei_scan/huawei_scan.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanKitWithHMS extends StatefulWidget {
  const ScanKitWithHMS({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // throw UnimplementedError();
    return _MyScanKitWithHMS();
  }
}

class _MyScanKitWithHMS extends State<ScanKitWithHMS> {
  Future<void> startScan() async {
    if (!await Permission.camera.status.isDenied) {
      DefaultViewRequest request =
          DefaultViewRequest(scanType: HmsScanTypes.AllScanType);
      //Calling defaultView API with the request object.
      //Calling defaultView API with the request object.
      // await HmsScanUtils.startDefaultView(request);
      //Obtain the result.
      ScanResponse response = await HmsScanUtils.startDefaultView(request);
//Print the result.
      // print('scan kit: ${response.showResult.toString()}');
      // ignore: use_build_context_synchronously
      Alert(
        context: context,
        image: SizedBox(
          height: 100,
            child: Lottie.network(
                'https://assets1.lottiefiles.com/private_files/lf30_s326pb1s.json',fit: BoxFit.cover)),
        content: SizedBox(
          height: Get.height * 0.5,
          width: Get.width * 0.7,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Contents of Qr code, barcode',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                (() {
                  if (hasValidUrl(response.showResult!)) {
                    return Linkify(
                      onOpen: (link) async {
                        if (await canLaunchUrl(Uri.parse(link.url))) {
                          await launchUrl(Uri.parse(link.url));
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      text: response.showResult!,
                      style: const TextStyle(color: Colors.black),
                      linkStyle: const TextStyle(color: Colors.blueAccent),
                    );
                  } else {
                    return SelectableLinkify(
                      text: response.showResult!,
                    );
                  }
                }()),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
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
    } else {
      await Permission.location.request();
      openAppSettings();
    }

    // await HmsScanUtils.disableLogger();
  }

  @override
  void initState() {
    super.initState();

    //Constructing request object.
    //createQR();

//Call requestCameraAndStoragePermission API.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'tools4',
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/t5.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: BlurryContainer(
              padding: const EdgeInsets.all(20),
              width: Get.width * 0.5,
              height: Get.height * 0.4,
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  textTitleMedium(
                      text: 'Scan QR',
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                  InkWell(
                    onTap: () async {
                      await startScan();
                    },
                    child: Lottie.network(
                        'https://assets5.lottiefiles.com/temp/lf20_PFb8HA.json'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool hasValidUrl(String value) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
