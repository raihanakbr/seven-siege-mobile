import 'package:flutter/material.dart';
import 'package:seven_siege/widgets/left_drawer.dart';
import 'package:seven_siege/screens/itemlist_form.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text(
                'Jumlah: ${items[index].amount}\nHarga: ${items[index].price}\nDeskripsi: ${items[index].description}'),
            // Add an onTap handler if you want to do something when the user taps a product
            onTap: () {},
          );
        },
      ),
    );
  }
}
