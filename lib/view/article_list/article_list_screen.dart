import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:news_feed/common/app_constant.dart';
import 'package:news_feed/common/string_constant.dart';
import 'package:news_feed/model/article.dart';
import 'package:news_feed/route/route_path.dart';
import 'package:news_feed/util/theme/app_theme_notifier.dart';
import 'package:news_feed/util/theme/theme_details.dart';
import 'package:news_feed/widgets/tag_view.dart';
import 'package:provider/provider.dart';

import '../../common/app_color_constant.dart';
import '../../common/dimens.dart';
import '../../util/shared_pref_util.dart';
import '../../util/theme/theme_util.dart';
import '../../widgets/network_image_view.dart';
import 'article_list_view_model.dart';

/// This class is used to show article list screen
class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  State<ArticleListScreen> createState() => ArticleListScreenState();
}

/// State class defined for [ArticleListScreen]
class ArticleListScreenState extends State<ArticleListScreen> {
  // creating viewModel instance
  late ArticleListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    // assigning viewModel instance
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<ArticleListViewModel>(context, listen: false);
      _setInitialData(viewModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    double statusBarHeight = mediaQueryData.viewPadding.top;
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
        child: Consumer<ArticleListViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                _headerView(context, screenWidth, screenHeight, viewModel),
                _bottomView(context, viewModel, screenWidth,
                    screenHeight - statusBarHeight)
              ],
            );
          },
        ),
      ),
    );
  }

  /// This function is used to create header view
  /// [context] BuildContext
  /// [screenWidth] defines width of the screen
  /// [screenHeight] defines height of the screen
  /// [viewModel] instance of viewModel
  Widget _headerView(BuildContext context, double screenWidth,
      double screenHeight, ArticleListViewModel viewModel) {
    return Container(
      width: screenWidth,
      height: Dimens.dp56,
      padding: const EdgeInsetsDirectional.all(Dimens.dp16),
      decoration: BoxDecoration(
        color: ThemeUtil.getColor(AppColorConstant.white),
        boxShadow: [
          BoxShadow(
              color: ThemeUtil.getColor(AppColorConstant.boxShadow),
              blurRadius: Dimens.dp2,
              offset: const Offset(0, 1),
              spreadRadius: 0)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              StringConstant.topArticles,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          InkWell(
            onTap: () {
              _updateTheme();
            },
            child: Text(
              textAlign: TextAlign.center,
              StringConstant.switchDarkMode,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  /// This function is used to return the bottom view of article list
  /// [context] BuildContext
  /// [viewModel] it takes viewModel object to get or update data
  /// [screenWidth] defines width of the screen
  /// [screenHeight] defines height of the screen
  Widget _bottomView(BuildContext context, ArticleListViewModel viewModel,
      double screenWidth, double screenHeight) {
    return Expanded(
      child: viewModel.isArticleListLoading
          ? _loaderView(context)
          : viewModel.articleList.isNotEmpty
              ? _articleListView(context, screenWidth, screenHeight, viewModel)
              : _noDataView(context),
    );
  }

  /// This function is used to return loader view
  /// [context] BuildContext
  Widget _loaderView(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Dimens.dp32,
        height: Dimens.dp32,
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
      ),
    );
  }

  /// This function is used to return no data found view
  /// [context] BuildContext
  Widget _noDataView(BuildContext context) {
    return Center(
      child: Text(
        StringConstant.noArticleFound,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  /// This function is used to return the view of list of articles
  /// [context] BuildContext
  /// [viewModel] it takes viewModel object to get or update data
  /// [screenWidth] defines width of the screen
  /// [screenHeight] defines height of the screen
  Widget _articleListView(BuildContext context, double screenWidth,
      double screenHeight, ArticleListViewModel viewModel) {
    return RefreshIndicator(
      onRefresh: viewModel.getArticleList,
      child: ListView.builder(
        padding: const EdgeInsetsDirectional.only(
            top: Dimens.dp16,
            bottom: Dimens.dp24,
            start: Dimens.dp16,
            end: Dimens.dp16),
        shrinkWrap: true,
        itemCount: viewModel.articleList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _articleListItem(
            context,
            screenWidth,
            screenHeight,
            viewModel,
            viewModel.articleList[index],
            index,
          );
        },
      ),
    );
  }

  /// This function is used to show article list item
  /// [context] BuildContext
  /// [screenWidth] defines width of the screen
  /// [screenHeight] defines height of the screen
  /// [viewModel] instance of viewModel
  /// [articleItem] defines setting item object
  /// [index] defines index of item
  Widget _articleListItem(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    ArticleListViewModel viewModel,
    Article articleItem,
    int index,
  ) {
    return InkWell(
      onTap: () {
        _handleItemClick(context, articleItem);
      },
      child: Card(
        elevation: Dimens.dp2,
        color: ThemeUtil.getColor(AppColorConstant.white),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(Dimens.dp12),
        ),
        child: Container(
          width: screenWidth,
          margin: const EdgeInsetsDirectional.only(
            bottom: Dimens.dp16,
          ),
          padding: const EdgeInsetsDirectional.all(Dimens.dp8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _articleImageView(context, articleItem.urlToImage),
              const SizedBox(height: Dimens.dp8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TagView(tagName: articleItem.source?.name),
                  Text(
                    articleItem.getArticleDateTimeInFormat(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: Dimens.dp8),
              Text(
                articleItem.title ?? AppConstant.emptyValue,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: Dimens.bold),
              ),
              const SizedBox(height: Dimens.dp8),
              Text(
                articleItem.description ?? AppConstant.emptyValue,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
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
        height: Dimens.dp150,
        imageUrl: imagePath,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.dp24),
          ),
        ),
      ),
    );
  }

  /// This function is used to initialize data
  /// [viewModel] instance of viewModel
  void _setInitialData(ArticleListViewModel viewModel) {
    viewModel.getArticleList();
  }

  /// This function is used to handle click of item
  /// [context] BuildContext
  /// [item] defines article item
  void _handleItemClick(BuildContext context, Article item) {
    Navigator.pushNamed(context, RoutePaths.articleDetail, arguments: item);
  }

  /// This function is used to update theme of app
  Future<void> _updateTheme() async {
    final appTheme = Provider.of<AppThemeNotifier>(context, listen: false);
    bool? isDarkMode = await SharedPrefUtil.isDarkModeTheme();
    if (isDarkMode == true) {
      final theme = ThemeDetails();
      if (context.mounted) {
        appTheme.setTheme(theme);
      }
    } else {
      final theme = ThemeDetails(
          primaryColor: AppColorConstant.grey, secColor: AppColorConstant.bg);
      if (context.mounted) {
        appTheme.setTheme(theme, brightness: Brightness.dark);
      }
    }
  }
}
