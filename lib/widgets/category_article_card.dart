import 'package:flutter/material.dart';
import 'package:news/model/article.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryArticleCard extends StatelessWidget {
  final Article article;
  const CategoryArticleCard({Key? key, required this.article}) : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    Map<String, Color> categoryColors = {
      'general': Colors.orange,
      'sport': Colors.red,
      'health': Colors.green,
      'entertainment': Colors.amber,
      'science': Colors.blue,
    };

    return GestureDetector(
      onTap: () {
        _launchInBrowser(Uri.parse(article.url ?? ""));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 7,
              offset:
              const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        height: 100,
        margin: const EdgeInsets.fromLTRB(22, 22, 22, 0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.network(
                article.urlToImage!,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: 120,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColors[article.category?.toLowerCase()],
                            borderRadius:
                            BorderRadius.circular(3),
                          ),
                          child: Text(
                            article.category ?? "No category",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 14,
                              color: Color(0xFFD9D9D9),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              article.publishedAt?.substring(11, 16) ?? "Recently",
                              style: const TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title ?? "Error",
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 10,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            article.author!,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 10,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
