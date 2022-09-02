import 'dart:convert';
import 'package:news/model/article.dart';
import 'package:http/http.dart' as http;
import 'package:news/extensions/string_extension.dart';

class NewsApiHandler {
  Future<List<Article>> fetchTrendingNews() async {
    List<Article> trendingArticles = [];
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=888617d6c45645ccaa072427bb060404'));
    if (response.statusCode == 200) {
      jsonDecode(response.body)['articles'].forEach((article) {
        trendingArticles.add(Article(
            author: article['author'] ?? "Unknown author",
            title: article['title'] ?? "No Title",
            description: article['description'] ?? "No Description",
            url: article['url'] ?? "",
            urlToImage: article['urlToImage']?.toString() ??
                "https://imageio.forbes.com/specials-images/imageserve/5ed68e8310716f0007411996/0x0.jpg?format=jpg&width=1200",
            publishedAt: article['publishedAt'] ?? "Recently",
            content: article['content'] ?? "",
            category: "Trending"));
      });
      return trendingArticles;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<List<Article>> fetchNewsByCategory(String category) async {
    List<Article> articles = [];
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=888617d6c45645ccaa072427bb060404'));
    if (response.statusCode == 200) {
      jsonDecode(response.body)['articles'].forEach((article) {
        articles.add(Article(
            author: article['author'] ?? "Unknown author",
            title: article['title'] ?? "No Title",
            description: article['description'] ?? "No Description",
            url: article['url'] ?? "",
            urlToImage: article['urlToImage']?.toString() ??
                "https://imageio.forbes.com/specials-images/imageserve/5ed68e8310716f0007411996/0x0.jpg?format=jpg&width=1200",
            publishedAt: article['publishedAt'] ?? "Recently",
            content: article['content'] ?? "No content",
            category: category.toCapitalized()));
      });
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
