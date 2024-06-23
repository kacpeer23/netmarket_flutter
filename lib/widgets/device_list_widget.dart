import 'package:flutter/material.dart';
import 'package:netmarket_flutter/services/database_service.dart';
import 'package:provider/provider.dart';

import 'device_list_item.dart';

class DeviceListWidget extends StatelessWidget {
  const DeviceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context);
    return FutureBuilder(
        future: databaseService.fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(right: 4.0, top: 4.0, bottom: 4.0)
                        : const EdgeInsets.all(4.0),
                    child: DeviceListItem(product: snapshot.data![index]),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}
