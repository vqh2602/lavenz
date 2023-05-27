import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/widgets/build_toast.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rive/rive.dart';

class VipController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin {
  List<StoreProduct> listProduct = [];
  StoreProduct? storeProductSelect;
  Offerings? offerings;
  CustomerInfo? customerInfo;
  List<String> vipOffer = [];
  late RiveAnimationController controller;
  User? user;

  @override
  Future<void> onInit() async {
    loadingUI();
    await initData();
    changeUI();
    super.onInit();
  }

  initData() async {
    user = getUserInBox();
    await initPlatformState();
    addStringDes();

    controller = OneShotAnimation(
      'shooting_star',
      autoplay: true,
      onStop: () => controller.isActive = true,
      onStart: () => controller.isActive = true,
    );
  }

  Future<void> initPlatformState() async {
    //   await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration? configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration('goog_skgtRCKuykcTkqnpcpFetUmKCWP');
      // if (buildingForAmazon) {
      //   // use your preferred way to determine if this build is for Amazon store
      //   // checkout our MagicWeather sample for a suggestion
      //   configuration = AmazonConfiguration(<public_amazon_api_key>);
      // }
    } else if (Platform.isIOS) {
      configuration =
          PurchasesConfiguration('appl_bSesihJPJGrdXlJWWcNAbpPtslR');
    }
    // if (configuration != null) {
    await Purchases.configure(configuration!);
    // Configure Purchases on app launch
    //LogInResult result =
    await Purchases.logIn(user?.id ?? 'user_loi_id');
    //print('đăng nhập user: ${result.customerInfo.toString()}');

    await Purchases.enableAdServicesAttributionTokenCollection();

    customerInfo = await Purchases.getCustomerInfo();
    //print('customerInfo : $customerInfo ');
    // Purchases.addReadyForPromotedProductPurchaseListener(
    //     (productID, startPurchase) async {
    //   print('Received readyForPromotedProductPurchase event for '
    //       'productID: $productID');

    //   try {
    //     final purchaseResult = await startPurchase.call();
    //     print('Promoted purchase for productID '
    //         '${purchaseResult.productIdentifier} completed, or product was'
    //         'already purchased. customerInfo returned is:'
    //         ' ${purchaseResult.customerInfo}');
    //   } on PlatformException catch (e) {
    //     print('Error purchasing promoted product: ${e.message}');
    //   }
    // });

// Accessing the monthly product// Displaying the monthly product

    try {
      listProduct = await Purchases.getProducts(['1_month', '1_year']);
      //print('ds san pham: ${listProduct.toString()}');
      offerings = await Purchases.getOfferings();
      //print('ds san pham off: ${offerings.toString()}');
      storeProductSelect = listProduct.isNotEmpty ? listProduct[0] : null;

      if (offerings?.current != null && offerings?.current!.monthly != null) {
        //StoreProduct? product = 
       // offerings?.current?.monthly?.storeProduct;
        //print('product ưu đãi: ${product}');
      }
    } catch (e) {
      // optional error handling
    }
  }

  Future<void> setConfigUserkey() async {
    await Purchases.configure(PurchasesConfiguration('dsafhjjk'));
  }

  Future<void> buyApp() async {
    loadingUI();

    customerInfo = await Purchases.purchasePackage(
        storeProductSelect?.identifier == '1_month'
            ? offerings!.current!.monthly!
            : offerings!.current!.annual!);

    if (customerInfo?.entitlements.all["premium"]?.isActive ?? false) {
      // Unlock that great "pro" content
      user = user?.copyWith(
          latestPurchaseDate: DateTime.parse(
              customerInfo!.entitlements.all["premium"]!.latestPurchaseDate),
          identifier:
              customerInfo!.entitlements.all["premium"]?.productIdentifier);
      await saveUserInBox(user: user!);
      buildToast(
          message: 'Mua hàng thành công'.tr, status: TypeToast.toastSuccess);
      clearAndResetApp();
    }
    // } on PlatformException catch (e) {
    //   var errorCode = PurchasesErrorHelper.getErrorCode(e);
    //   if (errorCode != PurchasesErrorCode.purchaseCancelledError) {}
    // }

    //print('mua hàng: ${customerInfo?.entitlements.all}');

    changeUI();
    //print('mua hàng 1: ${customerInfo?.toString()}');
  }

  Future<void> restorePucharses() async {
    loadingUI();
    try {
      customerInfo = await Purchases.restorePurchases();
      // ... check restored purchaserInfo to see if entitlement is now active
      try {
        if (customerInfo?.entitlements.all["premium"]?.isActive ?? false) {
          // Unlock that great "pro" content
          user = user?.copyWith(
              latestPurchaseDate: DateTime.parse(customerInfo!
                  .entitlements.all["premium"]!.latestPurchaseDate),
              identifier:
                  customerInfo!.entitlements.all["premium"]?.productIdentifier);
          saveUserInBox(user: user!);
          buildToast(
              message: 'Khôi phục thành công'.tr, status: TypeToast.toastSuccess);
          clearAndResetApp();
        } else {
          user = user?.copyWith(latestPurchaseDate: null, identifier: null);
          saveUserInBox(user: user!);
          buildToast(
              message: 'Khôi phục thất bại'.tr, status: TypeToast.toastError);
        }
      } on PlatformException catch (e) {
        var errorCode = PurchasesErrorHelper.getErrorCode(e);
        if (errorCode != PurchasesErrorCode.purchaseCancelledError) {}
      }

      //print('khôi phục mua hàng: ${customerInfo?.entitlements.all}');
    } catch (e) {
      //print('lỗi mua hàng: ${e}');
    }
    changeUI();
  }

  addStringDes() {
    vipOffer.clear();
    vipOffer.addAll([
      'Không có quảng cáo'.tr,
      '200+ hiệu ứng âm thanh thư giãn'.tr,
      'Không giới hạn tính năng nâng cao'.tr,
      'Không giới hạn bản nhạc thư giãn'.tr,
      (storeProductSelect?.identifier == '1_year')
          ? 'Tăng giới hạn mix âm thanh lên tối đa'.tr
          : 'Tăng giới hạn mix âm thanh lên 10'.tr,
      if (storeProductSelect?.identifier == '1_year') 'Tiết kiệm lên đến 10%'.tr,
    ]);
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
