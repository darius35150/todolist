import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/db/rowitemslist.dart';
import 'package:todolist/home/listitems.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  PageController page = PageController();

  Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final textFormFieldController = TextEditingController();
  List otherColors = [const Color.fromARGB(255, 217, 217, 217), Colors.pink];
  static final _itemsHiveDB = Hive.box("items");

  void _saveData() {
    setState(() {
      RowItemsList itemsList =
          RowItemsList(textFormFieldController.text, DateTime.now());
      itemsList.saveItems();

      print(RowItemsList.getAllItems());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("To Do List"),
        ),
        body: Stack(
          children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 85, 1400, 0),
              child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme:
                          const ColorScheme.light(primary: Colors.pink)),
                  child: TextFormField(
                    controller: textFormFieldController,
                    style: const TextStyle(fontFamily: "Nunito"),
                    cursorColor: Colors.pink,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Enter item name"),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 5, 0),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    onPressed: _saveData,
                    child: const Text("Save"))),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
              width: 800,
              height: 500,
              margin: const EdgeInsets.fromLTRB(720, 35, 100, 0),
              child: const ListItems())
            ],
          )
        ]));
  }
}
