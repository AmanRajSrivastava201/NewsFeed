import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/news_application.dart';
import 'package:news_feed/util/theme/app_theme_notifier.dart';
import 'package:news_feed/util/theme/theme_util.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    var themeData = await ThemeUtil.getThemeDataFromPref();
    runApp(ChangeNotifierProvider<AppThemeNotifier>(
      create: (_) => AppThemeNotifier(themeData),
      child: const NewsApplication(),
    ));
  }, (error, stack) {
    if (kDebugMode) {
      print(error);
      print(stack);
    }
  });
}
