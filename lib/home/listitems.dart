import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/db/rowitemslist.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key});

  @override
  State<ListItems> createState() => _ListItems();
}

class _ListItems extends State<ListItems> {
  List otherColors = [const Color.fromARGB(255, 217, 217, 217), Colors.pink];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: RowItemsList.getAllItems().length,
        itemBuilder: (context, index) {
          print(
              "${RowItemsList.getAllItems()}*********************");
          return Dismissible(
              onDismissed: (direction) => RowItemsList.deleteItem(RowItemsList.getAllItems().elementAt(index)["itemName"]),
              key: ValueKey(RowItemsList.getAllItems().elementAt(index)),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: .2)),
                style: ListTileStyle.drawer,
                tileColor: otherColors[index % 2],
                title: Text(RowItemsList.getAllItems()
                    .elementAt(index)["itemName"]
                    .toString()),
                subtitle: const Text("Due:   Today"),
                trailing: Text("Date:   ${RowItemsList.getAllItems().elementAt(index)["date"].toString().substring(0, 10)}")
              ));
        });
  }
}
