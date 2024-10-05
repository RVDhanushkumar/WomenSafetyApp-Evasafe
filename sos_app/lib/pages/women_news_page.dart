import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WomenNewsPage extends StatefulWidget {
  @override
  _WomenNewsPageState createState() => _WomenNewsPageState();
}

class _WomenNewsPageState extends State<WomenNewsPage> {
  final String apiKey = '59a803691adb4f6891686e8e25ac5bba'; // Add your NewsAPI key here
  List newsArticles = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchNews(); // Fetch news when the app starts
    timer = Timer.periodic(Duration(minutes: 10), (Timer t) => fetchNews()); // Refresh news every 10 minutes
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> fetchNews() async {
    final String url =
        'https://newsapi.org/v2/everything?q=women&language=en&sortBy=publishedAt&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          newsArticles = filterArticles(data['articles']);
        });
      } else {
        print('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  List filterArticles(List articles) {
    final keywords = ['women', 'female', 'girl', 'woman']; // Define keywords to filter articles
    return articles.where((article) {
      final title = article['title']?.toLowerCase() ?? '';
      final description = article['description']?.toLowerCase() ?? '';
      return keywords.any((keyword) => title.contains(keyword) || description.contains(keyword));
    }).toList();
  }

  void _toggleLikeDislike(int index, bool isLike) {
    setState(() {
      newsArticles[index]['liked'] = isLike;
      newsArticles[index]['disliked'] = !isLike;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Women News Dashboard',
          style: TextStyle(color: Colors.white), // Change title color to white
        ),
        backgroundColor: Colors.purple[800],
        iconTheme: IconThemeData(color: Colors.white), // Set back arrow color to white
      ),
      body: RefreshIndicator(
        onRefresh: fetchNews,
        child: newsArticles.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: newsArticles.length,
                itemBuilder: (context, index) {
                  final article = newsArticles[index];
                  final isLiked = article['liked'] ?? false;
                  final isDisliked = article['disliked'] ?? false;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (article['urlToImage'] != null)
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              child: Image.network(
                                article['urlToImage'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150, // Reduced height to avoid overflow
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(12.0), // Reduced padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article['title'] ?? 'No Title',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16, // Reduced font size
                                  ),
                                  maxLines: 2, // Ensure title fits within two lines
                                  overflow: TextOverflow.ellipsis, // Truncate text if too long
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article['description'] ?? 'No Description',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14, // Reduced font size
                                  ),
                                  maxLines: 3, // Limit description to three lines
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Like button
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      decoration: BoxDecoration(
                                        color: isLiked ? Colors.blue[300] : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.thumb_up_alt_outlined,
                                          color: isLiked ? Colors.blue : Colors.blueGrey,
                                        ),
                                        onPressed: () => _toggleLikeDislike(index, true),
                                      ),
                                    ),
                                    // Dislike button
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      decoration: BoxDecoration(
                                        color: isDisliked ? Colors.red[300] : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.thumb_down_alt_outlined,
                                          color: isDisliked ? Colors.red : Colors.blueGrey,
                                        ),
                                        onPressed: () => _toggleLikeDislike(index, false),
                                      ),
                                    ),
                                    Text(
                                      'Published: ${article['publishedAt']}',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 12, // Reduced font size
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
