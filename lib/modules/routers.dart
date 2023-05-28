import 'package:lavenz/modules/auth/login/login_binding.dart';
import 'package:lavenz/modules/auth/login/login_screen.dart';
import 'package:lavenz/modules/auth/signup/signup_binding.dart';
import 'package:lavenz/modules/auth/signup/signup_screen.dart';
import 'package:lavenz/modules/dashbroad/dashbroad_binding.dart';
import 'package:lavenz/modules/dashbroad/dashbroad_screen.dart';

import 'package:lavenz/modules/home/home_binding.dart';
import 'package:lavenz/modules/home/home_screen.dart';
import 'package:lavenz/modules/setting/setting_binding.dart';
import 'package:lavenz/modules/setting/setting_screen.dart';
import 'package:lavenz/modules/sound/sound_binding.dart';
import 'package:lavenz/modules/sound/sound_screen.dart';
import 'package:lavenz/modules/sound_control/sound_control_binding.dart';
import 'package:lavenz/modules/sound_control/sound_control_screen.dart';

import 'package:lavenz/modules/splash/splash_binding.dart';
import 'package:lavenz/modules/splash/splash_screen.dart';

import 'package:get/get.dart';
import 'package:lavenz/modules/tools/breath/breath_binding.dart';
import 'package:lavenz/modules/tools/breath/breath_screen.dart';
import 'package:lavenz/modules/tools/horoscope/horoscope_binding.dart';
import 'package:lavenz/modules/tools/horoscope/horoscope_screen.dart';
import 'package:lavenz/modules/tools/meditation/meditation_binding.dart';
import 'package:lavenz/modules/tools/meditation/meditation_screen.dart';
import 'package:lavenz/modules/tools/quote/quote_binding.dart';
import 'package:lavenz/modules/tools/quote/quote_screen.dart';
import 'package:lavenz/modules/tools/tools_binding.dart';
import 'package:lavenz/modules/tools/tools_screen.dart';
import 'package:lavenz/modules/vip/vip_binding.dart';
import 'package:lavenz/modules/vip/vip_screen.dart';

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
      binding: DashBroadBinding(),
      transition: Transition.downToUp),
  GetPage(
      name: SoundScreen.routeName,
      page: () => const SoundScreen(),
      binding: SoundBinding()),
  GetPage(
      name: SoundControlScreen.routeName,
      page: () => const SoundControlScreen(),
      binding: SoundControlBinding()),
  GetPage(
      name: SettingScreen.routeName,
      page: () => const SettingScreen(),
      binding: SettingBinding()),
  GetPage(
      name: VipScreen.routeName,
      page: () => const VipScreen(),
      binding: VipBinding()),
  GetPage(
      name: ToolsScreen.routeName,
      page: () => const ToolsScreen(),
      binding: ToolsBinding()),
  GetPage(
    name: BreathScreen.routeName,
    page: () => const BreathScreen(),
    binding: BreathBinding(),
  ),
  GetPage(
    name: MeditationScreen.routeName,
    page: () => const MeditationScreen(),
    binding: MeditationBinding(),
  ),
  GetPage(
    name: HoroscopeScreen.routeName,
    page: () => const HoroscopeScreen(),
    binding: HoroscopeBinding(),
  ),
  GetPage(
    name: QuoteScreen.routeName,
    page: () => const QuoteScreen(),
    binding: QuoteBinding(),
  ),
];
