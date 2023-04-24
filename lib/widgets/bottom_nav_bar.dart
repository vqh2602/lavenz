import 'package:lavenz/modules/dashbroad/dashbroad_screen.dart';
import 'package:lavenz/modules/sound/sound_screen.dart';
import 'package:lavenz/modules/sound_control/sound_control_screen.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'library/flutter_snake_navigationbar/snake_bar_widget.dart';
import 'library/flutter_snake_navigationbar/theming/snake_bar_behaviour.dart';
import 'library/flutter_snake_navigationbar/theming/snake_shape.dart';

Widget bottomNavigationBar(
    {int selectedIndex = 0,
    required Function(int) onSelect,
    required PageController pageController}) {
  return SnakeNavigationBar.color(
    behaviour: SnakeBarBehaviour.floating,
    height: 60,
    snakeShape: SnakeShape.circle,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(55)),
    ),
    padding: const EdgeInsets.only(left: 25, right: 25, bottom: 12, top: 12),

    ///configuration for SnakeNavigationBar.color
    backgroundColor: colorF3.withOpacity(0.7),
    snakeViewColor: colorF3.withOpacity(0.1),
    selectedItemColor: Colors.white,
    unselectedItemColor: colorF1.withOpacity(0.5),
    // height: 56,

    ///configuration for SnakeNavigationBar.gradient
    //snakeViewGradient: selectedGradient,
    //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
    //unselectedItemGradient: unselectedGradient,

    showUnselectedLabels: false,
    showSelectedLabels: false,
    currentIndex: selectedIndex,
    onTap: onSelect,
    items: items,
  );
}

List<BottomNavigationBarItem> items = [
  const BottomNavigationBarItem(
      icon: Icon(
        LucideIcons.home,
        size: 30,
      ),
      label: 'tickets'),
  const BottomNavigationBarItem(
      icon: Icon(
        LucideIcons.listMusic,
        size: 30,
      ),
      label: 'calendar'),
  const BottomNavigationBarItem(
      icon: Icon(
        LucideIcons.moon,
        size: 35,
      ),
      label: 'home'),
  const BottomNavigationBarItem(
      icon: Icon(
        LucideIcons.settings,
        size: 30,
      ),
      label: 'microphone'),
  const BottomNavigationBarItem(
      icon: Icon(
        LucideIcons.rocket,
        size: 30,
      ),
      label: 'search')
];

List<Widget> widgetOptions = <Widget>[
  const DashBroadScreen(),
  const SoundScreen(),
  const SoundControlScreen(),
  Container(
    color: Colors.brown,
  )
];
