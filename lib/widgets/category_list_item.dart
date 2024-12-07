import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/screens/category_screen.dart';

class CategoryListItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CategoryListItem(
      {super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryScreen(category: title);
        }));
      },
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: isDarkMode ? Colors.white.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(), // Wskaźnik ładowania
              errorWidget: (context, url, error) => const Icon(Icons.error), // Wskaźnik błędu
            ),


              )),
          Text(title),
        ],
      ),
    );
  }
}
