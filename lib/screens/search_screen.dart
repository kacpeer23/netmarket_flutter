import 'package:flutter/material.dart';
import 'package:netmarket_flutter/models/product.dart';
import 'package:netmarket_flutter/services/database_service.dart';
import 'package:netmarket_flutter/widgets/device_list_item.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> _searchResults = [];
  bool _isLoading = false;

  void _searchProducts(String query) async {
    setState(() {
      _isLoading = true;
    });

    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    final allProducts = await databaseService.fetchItems();

    setState(() {
      _searchResults = allProducts
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  _searchProducts(query);
                } else {
                  setState(() {
                    _searchResults = [];
                  });
                }
              },
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return DeviceListItem(product: _searchResults[index]);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
