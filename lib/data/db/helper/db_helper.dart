import '../../../model/article.dart';
import '../database/app_database.dart';

/// This is singleton helper class for database
class DbHelper {
  static DbHelper? _instance;

  /// reference of AppDatabase
  static AppDatabase? _database;

  DbHelper._();

  ///This will initialize database
  Future _init() async {
    _database = await AppDatabase.getAppDb();
  }

  /// This will return singleton instance of database helper
  static Future<DbHelper?>? getInstance() async {
    _instance ??= DbHelper._();
    if (_database == null) {
      await _instance?._init();
    }
    return _instance;
  }

  /// This function is used to return database instance
  AppDatabase? getDatabase() {
    return _database;
  }

  /// This method will insert article list in db
  /// [articleList] defines list of articles
  Future<void> insertArticlesInDb(List<Article> articleList) async {
    var dbHelper = await DbHelper.getInstance();
    await dbHelper?.getDatabase()?.articlesDao.insertArticles(articleList);
  }

  /// This function is use  to get the all articles data entry from database
  Future<List<Article>?> getAllArticlesFromDb() async {
    var dbHelper = await DbHelper.getInstance();
    List<Article>? list =
        await dbHelper?.getDatabase()?.articlesDao.getAllArticleList();
    return list;
  }

  /// This function is use to clear all articles from database
  Future<void> clearAllArticle() async {
    var dbHelper = await DbHelper.getInstance();
    await dbHelper?.getDatabase()?.articlesDao.clearAllArticleList();
  }
}
