import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:news_feed/common/app_constant.dart';
import 'package:news_feed/common/dimens.dart';
import 'package:news_feed/common/string_constant.dart';
import 'package:news_feed/model/article.dart';
import 'package:news_feed/widgets/network_image_view.dart';
import 'package:news_feed/widgets/tag_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/app_color_constant.dart';
import '../../util/theme/theme_util.dart';

/// This class is used to show article detail screen
class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0.0,
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.antiAlias,
        decoration:
            BoxDecoration(color: ThemeUtil.getColor(AppColorConstant.white)),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            _articleView(context, article),
            _viewFullArticleButton(context, article)
          ],
        ),
      ),
    );
  }
}

/// This function is used to return article information view
/// [context] defines BuildContext
/// [article] defines article item
Widget _articleView(BuildContext context, Article article) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _articleImageView(context, article.urlToImage),
        const SizedBox(height: Dimens.dp8),
        _articleDetailView(context, article),
      ],
    ),
  );
}

/// This function is used to return article image view
/// [context] defines BuildContext
/// [imagePath] defines article image
Widget _articleImageView(BuildContext context, String? imagePath) {
  return Align(
    alignment: AlignmentDirectional.center,
    child: NetworkImageView(
      width: double.infinity,
      height: Dimens.dp250,
      imageUrl: imagePath,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dp24),
        ),
      ),
    ),
  );
}

/// This function is used to return button view for view full article
/// [context] defines BuildContext
/// [article] defines article item
Widget _viewFullArticleButton(BuildContext context, Article article) {
  return Positioned(
    bottom: 0,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          alignment: AlignmentDirectional.center),
      onPressed: () {
        _launchURL(article.url ?? "");
      },
      child: Text(
        StringConstant.viewFullArticle,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: ThemeUtil.getColor(AppColorConstant.white)),
      ),
    ),
  );
}

/// This function is used to return full detail of article
/// [context] defines BuildContext
/// [article] defines article item
Widget _articleDetailView(BuildContext context, Article article) {
  return Padding(
    padding: const EdgeInsets.only(
        bottom: Dimens.dp8, left: Dimens.dp16, right: Dimens.dp16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TagView(tagName: article.source?.name),
            Text(
              article.getArticleDateTimeInFormat(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: Dimens.dp8),
        Text(
          article.title ?? AppConstant.emptyValue,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: Dimens.dp4),
        Text(
          "${StringConstant.author}: ${article.author ?? AppConstant.emptyValue}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: Dimens.dp8),
        Text(
          article.description ?? AppConstant.emptyValue,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: Dimens.dp8),
        Text(
          article.content ?? AppConstant.emptyValue,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    ),
  );
}

/// This function is used to launch url in browser
/// [url] defines url to launch in browser
Future<void> _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    if (kDebugMode) {
      print('Could not launch $url');
    }
  }
}
