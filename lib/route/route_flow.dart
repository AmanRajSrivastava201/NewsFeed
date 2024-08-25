import 'package:flutter/cupertino.dart';
import 'package:news_feed/model/article.dart';
import 'package:news_feed/route/route_path.dart';
import 'package:news_feed/view/article_detail/article_detail_screen.dart';
import 'package:news_feed/view/article_list/article_list_repository.dart';
import 'package:news_feed/view/article_list/article_list_screen.dart';
import 'package:news_feed/view/article_list/article_list_view_model.dart';
import 'package:provider/provider.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutePaths.articleDetail:
      final args = settings.arguments as Article;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ArticleDetailScreen(article: args),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end);
          var scaleAnimation =
              animation.drive(tween.chain(CurveTween(curve: curve)));
          return ScaleTransition(
            scale: scaleAnimation,
            child: child,
          );
        },
      );
    default:
      return CupertinoPageRoute(
        settings: const RouteSettings(name: RoutePaths.articleList),
        builder: (context) => ChangeNotifierProvider(
          create: (context) => ArticleListViewModel(ArticleListRepository()),
          child: const ArticleListScreen(),
        ),
      );
  }
}
