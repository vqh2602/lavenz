import 'package:lavenz/modules/auth/login/login_binding.dart';
import 'package:lavenz/modules/auth/login/login_screen.dart';
import 'package:lavenz/modules/auth/signup/signup_binding.dart';
import 'package:lavenz/modules/auth/signup/signup_screen.dart';
import 'package:lavenz/modules/dashbroad/dashbroad_binding.dart';
import 'package:lavenz/modules/dashbroad/dashbroad_screen.dart';

import 'package:lavenz/modules/home/home_binding.dart';
import 'package:lavenz/modules/home/home_screen.dart';

import 'package:lavenz/modules/splash/splash_binding.dart';
import 'package:lavenz/modules/splash/splash_screen.dart';


import 'package:get/get.dart';

List<GetPage> routes = [
  GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
      binding: SplashBinding()),
  GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fade),
  GetPage(
      name: LoginScreen.routeName,
      page: () => const LoginScreen(),
      binding: LoginBinding()),
  GetPage(
      name: SignupScreen.routeName,
      page: () => const SignupScreen(),
      binding: SignupBinding()),
  GetPage(
      name: DashBroadScreen.routeName,
      page: () => const DashBroadScreen(),
      binding: DashBroadBinding()),
];
