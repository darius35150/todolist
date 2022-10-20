import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/scheduler.dart';

class Home extends StatelessWidget {
  PageController page = PageController();

  List<SideMenuItem> items = [
    const SideMenuItem(
      priority: 0,
      title: 'Add Item',
      icon: Icon(Icons.add),
      onTap: () {
        page.jumpToPage(0);
      })
  ];

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Amani's To Do"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              items: items, 
              controller: page
            ),
            Center(
                child: PageView(
                  controller: page,
                  children: [
                    Container()
                  ],
                )
            )
          ],
        ));
  }
}
