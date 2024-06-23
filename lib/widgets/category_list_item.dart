import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CategoryListItem(
      {super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
          ),
        ),
        Text(title),
      ],
    );
  }
}
