import 'package:flutter/material.dart';
import 'package:netmarket_flutter/services/database_service.dart';
import 'package:netmarket_flutter/widgets/device_list_item.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: FutureBuilder(
        future: databaseService.fetchItemsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.all(8),
                    child: DeviceListItem(product: snapshot.data![index]));
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
