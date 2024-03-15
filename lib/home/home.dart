import 'package:flutter/material.dart';
import 'package:todolist/db/rowitemslist.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

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
    const Color.fromARGB(255, 89, 235, 179)
  ];

  Future<void> _saveData() async {
    setState(() {
      if (textFormFieldController.text.isEmpty) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('To Do List'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('You must enter an item before saving!'),
                  ],
                ),
              ),
              actions: <Widget>[
                Center(
                    child: ElevatedButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
              ],
            );
          },
        );
      } else {
        RowItemsList itemsList =
            RowItemsList(textFormFieldController.text, DateTime.now());
        itemsList.saveItems();
        textFormFieldController.clear();
      }
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
          backgroundColor: const Color.fromARGB(255, 89, 235, 179),
          title: const Text("To Do List",
            style: TextStyle(
              color: Colors.white
            ),),
        ),
        body: BootstrapContainer(fluid: false, children: [
          BootstrapRow(
            children: [
            BootstrapCol(
              sizes: "col-12 col-sm-12 col-md-6 col-lg-4 col-xl-3",
                fit: FlexFit.tight,
                child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme:
                            const ColorScheme.light(primary: Color.fromARGB(255, 89, 235, 179))),
                    child: TextField(
                      controller: textFormFieldController,
                      style: const TextStyle(fontFamily: "Nunito"),
                      cursorColor:  const Color.fromARGB(255, 89, 235, 179),
                      onSubmitted: (value) =>{
                           _saveData()
                      },
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Enter item name"),
                    ))),
          ]),
          BootstrapRow(children: [
            BootstrapCol(
              sizes: "col-5 col-sm-3 col-md-2 col-lg-2 col-xl-2",
              fit: FlexFit.tight,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 15, backgroundColor: const Color.fromARGB(255, 89, 235, 179)),
                        onPressed: _saveData,
                        child: const Text("Save",
                          style: TextStyle(
                            color: Colors.white
                          ),))))
          ]),
          BootstrapRow(
            children: [  BootstrapCol(
              child: Center(
                  child: Container(
                      width: 600,
                      height: 600,
                      margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: RowItemsList.getAllItems().length,
                          itemBuilder: (context, index) {
                            return Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 15,
                                child: ListTile(
                                  tileColor: otherColors[index % 2],
                                  title: Text(RowItemsList.getAllItems()
                                      .elementAt(index)["itemName"]
                                      .toString()),
                                  subtitle: Text(
                                      "Date Added:   ${RowItemsList.getAllItems().elementAt(index)["date"].toString().substring(0, 10)}"),
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
                                ));
                          }))))])
        ]));
  }
}
