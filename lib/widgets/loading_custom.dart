
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingCustom extends StatelessWidget {
  const LoadingCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      color: Get.theme.colorScheme.background,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background/bg.png'),
                      fit: BoxFit.fill)),
            ),
            Center(
              child: Lottie.asset('assets/background/loadding.json',
                  width: Get.width,
                  fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
