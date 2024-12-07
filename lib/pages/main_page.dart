import 'package:flutter/material.dart';
import 'package:netmarket_flutter/services/auth_service.dart';
import 'package:netmarket_flutter/widgets/category_list_item.dart';
import 'package:netmarket_flutter/widgets/device_list_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'NetMarket',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                authService.signOut();
              },
            ),
          ],
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(2.0),
              child: Divider(
                color: Colors.grey,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      CategoryListItem(
                          imageUrl:
                              'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/40/4021452/Laptop-ASUS-X515EA-BQ1877-01-front.jpg',
                          title: 'Laptopy'),
                      CategoryListItem(
                          imageUrl:
                              "https://cdn.x-kom.pl/i/setup/images/prod/big/product-new-big,,2023/9/pr_2023_9_12_22_44_57_650_00.jpg",
                          title: 'Smartfony'),
                      CategoryListItem(
                          imageUrl:
                              'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/57/5718208/Telewizor-SHARP-FH2EA-skos-1.jpg',
                          title: 'TV'),
                      CategoryListItem(
                          imageUrl:
                              'https://cdn.x-kom.pl/i/setup/images/prod/big/product-new-big,,2023/5/pr_2023_5_2_8_35_55_691_00.jpg',
                          title: 'Gaming'),
                      CategoryListItem(
                          imageUrl:
                              'https://cdn.x-kom.pl/i/setup/images/prod/big/product-new-big,,2023/3/pr_2023_3_14_11_0_15_443_00.jpg',
                          title: 'Tablety'),
                      CategoryListItem(
                          imageUrl:
                              'https://prod-api.mediaexpert.pl/api/images/gallery_500_500/thumbnails/images/37/3784350/Sluchawki-nauszne-SONY-WH-1000XM5B-ANC-Czarny-skos.jpg',
                          title: 'Headphones'),
                      CategoryListItem(
                          imageUrl:
                              'https://fotoforma.pl/environment/cache/images/500_500_productGfx_136720/aparat-canon-eos-r7-body_1.jpg',
                          title: 'Photo'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bestsellery',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const DeviceListWidget(),
              ],
            ),
          ),
        ));
  }
}
