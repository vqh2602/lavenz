import 'package:lavenz/modules/tools/breath/breath_screen.dart';
import 'package:lavenz/modules/tools/tools_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({Key? key}) : super(key: key);
  static const String routeName = '/tools';

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  ToolsController toolsController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return toolsController.obx((state) => Stack(
          children: <Widget>[
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background/bg3.jpeg'),
                      fit: BoxFit.fill)),
            ),
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background/bg.png'),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
                height: Get.height,
                width: Get.width,
                child: ListView.builder(
                    itemBuilder: (context, i) => InkWell(
                          onTap: () {
                            Get.toNamed(BreathScreen.routeName);
                          },
                          child: Hero(
                            tag: 'tools$i',
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              width: Get.width,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/background/t1.jpeg'),
                                      fit: BoxFit.cover)),
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/background/bg.png'),
                                            fit: BoxFit.fill)),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          textTitleLarge(
                                              text: 'Breath',
                                              color: Colors.white),
                                          cHeight(8),
                                          textBodySmall(
                                              text: 'điểu chỉnh nhịp thở',
                                              color: Colors.white60)
                                        ]),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: alignment_20_8(),
                                      child: textBodySmall(
                                          text: 'Preium', color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    'assets/background/logo.png',
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                )),
          ],
        ));
  }
}
