import 'package:flutter/material.dart';
import 'package:todolist/db/rowitemslist.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  PageController page = PageController();

  Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final textFormFieldController = TextEditingController();
  List otherColors = [
    const Color.fromARGB(255, 217, 217, 217),
    const Color.fromARGB(255, 236, 113, 154)
  ];
  // static final _itemsHiveDB = Hive.box("items");
  bool checkbox = false;
  void _saveData() {
    setState(() {
      RowItemsList itemsList =
          RowItemsList(textFormFieldController.text, DateTime.now());
      itemsList.saveItems();
      textFormFieldController.clear();
    });
  }

  void _deleteData(int index) {
    setState(() {
      RowItemsList.deleteItem(
          RowItemsList.getAllItems().elementAt(index)["itemName"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("To Do List"),
        ),
        body: Stack(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(520, 25, 520, 0),
                  child: Center(
                      child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: Colors.pink)),
                          child: TextField(
                            controller: textFormFieldController,
                            style: const TextStyle(fontFamily: "Nunito"),
                            cursorColor: Colors.pink,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Enter item name"),
                          ))),
                ),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 495, 0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink),
                            onPressed: _saveData,
                            child: const Text("Save")))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Container(
                            width: 600,
                            height: 500,
                            margin: const EdgeInsets.fromLTRB(0, 95, 0, 0),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: RowItemsList.getAllItems().length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    tileColor: otherColors[index % 2],
                                    title: Text(RowItemsList.getAllItems()
                                        .elementAt(index)["itemName"]
                                        .toString()),
                                    subtitle: Text(
                                        "Date:   ${RowItemsList.getAllItems().elementAt(index)["date"].toString().substring(0, 10)}"),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _deleteData(index);
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              size: 20.0,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  );
                                })))
                  ],
                )
              ])
        ]));
  }
}