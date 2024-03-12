import 'dart:io';

import 'package:flutter/material.dart';

import 'package:the_jokester/screens/category_jokes_screen.dart';

class CategoryItem extends StatelessWidget {
  String title;
  String imageLoc; //image needs to be passed somehow
  CategoryItem(
    this.title,
    this.imageLoc,
  );
  void _selectCategory(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CategoryDetailScreen(title),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      child: Card(
        child: Column(children: [
          Container(
            width: 70,
            height: 50,
            child: Image.asset(
              imageLoc,
              fit: BoxFit.contain,
            ),
          ),
          Text(title)
        ]),
      ),
    );
  }
}
