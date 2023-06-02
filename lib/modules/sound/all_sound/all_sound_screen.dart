import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/modules/sound/all_sound/all_sound_controller.dart';
import 'package:lavenz/modules/sound/sound_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AllSoundScreen extends StatefulWidget {
  const AllSoundScreen({Key? key}) : super(key: key);
  static const String routeName = '/all_sound';

  @override
  State<AllSoundScreen> createState() => _AllSoundScreenState();
}

class _AllSoundScreenState extends State<AllSoundScreen>
    with TickerProviderStateMixin {
  AllSoundController allSoundController = Get.put(AllSoundController());
  SoundController soundController = Get.find();

  num musicType = Get.arguments['musicType'];

  @override
  void initState() {
    super.initState();
    allSoundController.musicType = musicType;
    allSoundController.getDataAllSound(musicType);
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/background/bg1.jpeg"), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            LucideIcons.x,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/bg1.jpeg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/bg.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SafeArea(
          child: buildListSound(),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(child: searchBox()),
        )
      ],
    );
  }

  Widget searchBox() {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Container(
        margin: alignment_20_0(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4, bottom: 4),
              child: searchBar(
                width: 0.75,
                controller: allSoundController.searchTE,
                onChange: (value) {
                  allSoundController.searchListMusic(search: value);
                },
              ),
            ),
            // filterButton(context),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                color: colorF3.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  LucideIcons.filter,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListSound() {
    return allSoundController.obx(
      (state) => Container(
        margin: const EdgeInsets.only(top: 4 * 15),
        child: ListView.builder(
          itemCount: allSoundController.listAllMusicResult.length,
          shrinkWrap: false,
          primary: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {
            return allSoundController.obx(
              (state) => InkWell(
                onTap: () {
                  soundController.onPlayMusic(
                    allSoundController.listAllMusicResult[i].sound ?? '',
                    allSoundController.listAllMusicResult[i],
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4 * 6,
                    vertical: 4 * 2,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.file(
                          File(
                              '${soundController.downloadAssetsController.assetsDir}/images/${allSoundController.listAllMusicResult[i].image}'),
                          errorBuilder: (context, object, stackTrace) {
                            return SizedBox(
                              height: double.infinity,
                              child: Image.asset(
                                'assets/images/image_notfound.jpg',
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                          height: 75.0,
                          width: 75.0,
                        ),
                      ),
                      cWidth(4 * 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textTitleSmall(
                                text: allSoundController
                                        .listAllMusicResult[i].name ??
                                    '',
                                color: Colors.white),
                            textBodySmall(
                              text: allSoundController
                                      .listAllMusicResult[i].describe ??
                                  '',
                              color: Colors.white,
                              maxLines: 3,
                              fontWeight: FontWeight.w100,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
