import 'dart:async';

import 'package:floor/floor.dart';
import 'package:news_feed/data/db/converter/article_source_converter.dart';
import 'package:news_feed/model/article.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../common/app_constant.dart';
import '../dao/article_dao.dart';

part 'app_database.g.dart';

@TypeConverters([ArticleSourceConverter])
@Database(version: 1, entities: [
  Article,
])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articlesDao;

  static Future<AppDatabase> getAppDb() async {
    final database =
        await $FloorAppDatabase.databaseBuilder(AppConstant.appDb).build();
    return database;
  }
}
