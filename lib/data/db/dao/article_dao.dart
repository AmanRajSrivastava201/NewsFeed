import 'package:floor/floor.dart';
import 'package:news_feed/model/article.dart';

@dao
abstract class ArticleDao {
  @Query('Select * from article')
  Future<List<Article>?> getAllArticleList();

  @Query('DELETE FROM article WHERE id = :articleId')
  Future<int?> deleteFromArticleList(String articleId);

  @Query('DELETE FROM article')
  Future<int?> clearAllArticleList();

  @insert
  Future<void> insertArticles(List<Article> articles);
}
