import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lavenz/config/config.dart';

mixin ADmodMixin {
  //-- khởi tạo quản cáo gốc
  NativeAd myNative = NativeAd(
      adUnitId: Platform.isAndroid
          ? Env.config.idADSNativeAndroid
          : Env.config.idADSNativeIos,
      factoryId: 'adFactoryExample',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {}
        // print('Ad loaded.')
        ,
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {}
        // print('Ad opened.')
        ,
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {}
        // print('Ad closed.')
        ,
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {}
        // print('Ad impression.')
        ,
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (Ad ad) {}
        //  print('Ad clicked.')
        ,
      ),
      // Styling
      nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
          templateType: TemplateType.medium,
          // Optional: Customize the ad's style.
          mainBackgroundColor: Colors.transparent,
          cornerRadius: 20.0,
          callToActionTextStyle: NativeTemplateTextStyle(
              textColor: Colors.cyan,
              backgroundColor: Colors.red,
              style: NativeTemplateFontStyle.monospace,
              size: 16.0),
          primaryTextStyle: NativeTemplateTextStyle(
              textColor: Colors.red,
              backgroundColor: Colors.cyan,
              style: NativeTemplateFontStyle.italic,
              size: 16.0),
          secondaryTextStyle: NativeTemplateTextStyle(
              textColor: Colors.green,
              backgroundColor: Colors.black,
              style: NativeTemplateFontStyle.bold,
              size: 16.0),
          tertiaryTextStyle: NativeTemplateTextStyle(
              textColor: Colors.brown,
              backgroundColor: Colors.amber,
              style: NativeTemplateFontStyle.normal,
              size: 16.0)))
    ..load();
  // void showNativeADS(){
  //   myNative.load();
  // }

  //== khởi tạo quảng cáo xen kẽ
  InterstitialAd? interstitialAd;
  createInitInterstitialAd() async {
    await InterstitialAd.load(
        adUnitId:Platform.isAndroid
          ? Env.config.idADSInterstitialAdAndroid
          : Env.config.idADSInterstitialAdIos,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
            interstitialAd?.fullScreenContentCallback =
                FullScreenContentCallback(
                    onAdShowedFullScreenContent: (InterstitialAd ad) {}
                    // print('%ad onAdShowedFullScreenContent.')
                    ,
                    onAdDismissedFullScreenContent: (InterstitialAd ad) {
                      // print('$ad onAdDismissedFullScreenContent.');
                      ad.dispose();
                    },
                    onAdFailedToShowFullScreenContent:
                        (InterstitialAd ad, AdError error) {
                      // print('$ad onAdFailedToShowFullScreenContent: $error');
                      ad.dispose();
                    },
                    onAdImpression: (InterstitialAd ad) {}
                    // print('$ad impression occurred.'),
                    );
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('InterstitialAd failed to load: $error');
          },
        ));
  }
}
