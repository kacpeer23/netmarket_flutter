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
              child:
                  CachedNetworkImage(imageUrl: widget.product.productImageUrl),
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
                    if(countOfDevices > 0) {
                      widget.product.countOfProducts = countOfDevices;
                      cart.addItem(widget.product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Added to cart'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Please select at least one device'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('Add to cart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      countOfDevices++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
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
                    backgroundColor: Colors.grey,
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
