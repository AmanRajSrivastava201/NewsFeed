import 'package:flutter/material.dart';
import 'package:news_feed/util/theme/app_theme_notifier.dart';
import 'package:news_feed/view/article_list/article_list_repository.dart';
import 'package:news_feed/view/article_list/article_list_screen.dart';
import 'package:news_feed/view/article_list/article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:news_feed/route/route_flow.dart' as router;

/// Application class
class NewsApplication extends StatefulWidget {
  const NewsApplication({Key? key}) : super(key: key);

  @override
  State<NewsApplication> createState() => _NewsApplicationState();
}

/// State class defined for [NewsApplication]
class _NewsApplicationState extends State<NewsApplication> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<AppThemeNotifier>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ArticleListViewModel(ArticleListRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.getTheme(),
        home: const ArticleListScreen(),
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
