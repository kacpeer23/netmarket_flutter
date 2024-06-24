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
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryScreen(category: title);
        }));
      },
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
