import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';

final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

class FirebaseAnalyticsService with UserMixin {
  appAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);
  evenFistOpen() async {
    User user = getUserInBox();
    await _analytics.setUserId(id: user.id);
    await _analytics.logAppOpen();
  }

  evenBuyApp() async {
    await _analytics.logEvent(name: "buy_app", parameters: {});
  }

  evenRemoveApp() async {
    await _analytics.logEvent(
      name: "app_remove",
    );
  }
}
