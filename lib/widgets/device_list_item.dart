import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/models/product.dart';
import 'package:netmarket_flutter/screens/device_info_screen.dart';

class DeviceListItem extends StatelessWidget {
  final Product product;

  const DeviceListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DeviceInfoScreen(product: product);
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(imageUrl: product.productImageUrl),
            ),
            const SizedBox(height: 5),
            Text(product.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            Text('${product.price} zł'),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add to cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
