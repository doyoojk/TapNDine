import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final titles = ["Chicken Nuggets", "Fries", "Burger"];
  final subtitles = ["Food", "Food", "Food"];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            title: Text(titles[index]),
            subtitle: Text(subtitles[index]),
          ));
        });
  }
}
