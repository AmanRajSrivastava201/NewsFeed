/// This class is a model class for article source
class ArticleSource {
  String? id;
  String? name;

  ArticleSource({this.id, this.name});

  ArticleSource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
