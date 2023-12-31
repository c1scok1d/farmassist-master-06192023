import 'package:farmassist/data/farm/models/News.dart';

import 'newsAPI.dart';

class Repository {
  final moviesApiProvider = NewsApiProvider();
  Future<List<Article>> fetchAllNews({String category = 'Science'}) =>
      moviesApiProvider.fetchNewsList(category: category);
}
