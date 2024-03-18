import 'dart:io';
import 'package:flutter/material.dart';
import 'package:the_jokester/screens/category_detail_screen.dart';

class CategoryItem extends StatefulWidget {
  final String title;
  final String imageLoc;

  CategoryItem(this.title, this.imageLoc);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -5, end: 5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectCategory(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CategoryDetailScreen(widget.title),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: InkWell(
        onTap: () => _selectCategory(context),
        child: Card(
          child: Column(children: [
            Container(
              width: 70,
              height: 50,
              child: Image.asset(
                widget.imageLoc,
                fit: BoxFit.contain,
              ),
            ),
            Text(widget.title)
          ]),
        ),
      ),
    );
  }
}
