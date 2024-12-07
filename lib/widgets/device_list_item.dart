import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/models/cart.dart';
import 'package:netmarket_flutter/models/product.dart';
import 'package:netmarket_flutter/screens/device_info_screen.dart';
import 'package:provider/provider.dart';

class DeviceListItem extends StatefulWidget {
  final Product product;

  const DeviceListItem({super.key, required this.product});

  @override
  State<DeviceListItem> createState() => _DeviceListItemState();
}

class _DeviceListItemState extends State<DeviceListItem> {
  int countOfDevices = 0;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DeviceInfoScreen(product: widget.product);
        }));
      },
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: widget.product.productImageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode ? Colors.white.withOpacity(0.25) : Colors.black.withOpacity(0.25),
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
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 5),
            Text(widget.product.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            Text('${widget.product.price} zł'),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (countOfDevices > 0) {
                      widget.product.countOfProducts = countOfDevices;
                      cart.addItem(widget.product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Dodano do koszyka'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content:
                              Text('Wybierz przynajmniej jedno urządzenie'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text('Dodaj do koszyka'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      countOfDevices++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  child: const Text('+'),
                ),
                Text('$countOfDevices'),
                ElevatedButton(
                  onPressed: () {
                    if (countOfDevices > 0) {
                      setState(() {
                        countOfDevices--;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  child: const Text('-'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
