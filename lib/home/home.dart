import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      _itemsHiveDB.put(textFormFieldController.text,
          {"itemName": textFormFieldController.value, "date": DateTime.now()});
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("To Do List"),
        ),
        body: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 35, 1400, 0),
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
                padding: const EdgeInsets.fromLTRB(15, 35, 1500, 0),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    onPressed: _saveData,
                    child: const Text("Save"))),
          ]),
          Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.fromLTRB(15, 35, 1400, 0),
              child: ListView.builder(
                itemCount: _itemsHiveDB.length,
                itemBuilder: (context, index) {
                  print(_itemsHiveDB.get(index) + "*********************");
                  return Dismissible(
                      key: ValueKey(_itemsHiveDB.get(index)),
                      child: ListTile(
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: .2)),
                        style: ListTileStyle.drawer,
                        tileColor: otherColors[index % 2],
                        title: Text(
                            _itemsHiveDB.get(index)["itemName"].toString()),
                        subtitle: Text(
                            "Date:   ${_itemsHiveDB.get(index)["expirationDate"].toString().substring(0, 10)}"),
                        // trailing: Text(RowReminderItems.getAllItems()
                        //         .elementAt(index)["notify"]
                        //         .toString() +
                        //     " Week(s) Before")
                      ));
                },
              ))
        ]));
  }
}
