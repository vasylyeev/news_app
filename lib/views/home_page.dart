import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news/api/news_api_handler.dart';
import '../model/article.dart';
import '../widgets/category_article_card.dart';
import '../widgets/trending_article_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  NewsApiHandler newsApiHandler = NewsApiHandler();
  late Future<List<Article>> trendingArticles,
      generalArticles,
      sportArticles,
      healthArticles,
      entertainmentArticles,
      scienceArticles;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    trendingArticles = newsApiHandler.fetchTrendingNews();
    generalArticles = newsApiHandler.fetchNewsByCategory("general");
    sportArticles = newsApiHandler.fetchNewsByCategory("sport");
    healthArticles = newsApiHandler.fetchNewsByCategory("health");
    entertainmentArticles = newsApiHandler.fetchNewsByCategory("entertainment");
    scienceArticles = newsApiHandler.fetchNewsByCategory("science");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Greetings
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good day!",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.grey[600],
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Here's your news feed",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Divider(
                    thickness: 1,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Trending Topics",
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            // Trending News Carousel
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: trendingArticles,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  }
                  if (snapshot.hasData) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index, realIndex) {
                        return TrendingArticleCard(
                          article: snapshot.data[index],
                        );
                      },
                      options: CarouselOptions(
                        viewportFraction:
                            (MediaQuery.of(context).size.width - 44) /
                                MediaQuery.of(context).size.width,
                        autoPlay: false,
                        autoPlayAnimationDuration: const Duration(seconds: 5),
                        enableInfiniteScroll: true,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            // TabBar
            Container(
              margin: const EdgeInsets.fromLTRB(22, 22, 0, 0),
              child: Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE9E9E9), width: 2.0),
                      ),
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.grey[600],
                    isScrollable: true,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 4.0,
                        color: Color(0XFF91bdf1),
                      ),
                    ),
                    unselectedLabelColor: const Color(0xffb9b9b9),
                    labelStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: const [
                      SizedBox(
                        height: 40,
                        width: 60,
                        child: Tab(text: 'Today'),
                      ),
                      SizedBox(
                        height: 40,
                        width: 70,
                        child: Tab(text: 'Sports'),
                      ),
                      SizedBox(
                        height: 40,
                        width: 60,
                        child: Tab(text: 'Health'),
                      ),
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: Tab(text: 'Entertainment'),
                      ),
                      SizedBox(
                        height: 40,
                        width: 60,
                        child: Tab(text: 'Science'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // TabBar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  FutureBuilder(
                    future: generalArticles,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return CategoryArticleCard(
                              article: snapshot.data![index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: sportArticles,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return CategoryArticleCard(
                              article: snapshot.data![index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: healthArticles,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return CategoryArticleCard(
                              article: snapshot.data![index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: entertainmentArticles,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return CategoryArticleCard(
                              article: snapshot.data![index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: scienceArticles,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return CategoryArticleCard(
                              article: snapshot.data![index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
