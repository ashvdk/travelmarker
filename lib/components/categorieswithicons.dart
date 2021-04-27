import 'package:flutter/material.dart';

class CategoriesWithIcons extends StatefulWidget {
  final IconData geticons;
  final String title;
  final Function setCategoryFunc;
  final String category;
  CategoriesWithIcons(
      {this.geticons, this.title, this.setCategoryFunc, this.category});
  @override
  _CategoriesWithIconsState createState() => _CategoriesWithIconsState();
}

class _CategoriesWithIconsState extends State<CategoriesWithIcons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.setCategoryFunc(widget.title),
      child: Column(
        children: [
          Icon(
            widget.geticons,
            size: 50.0,
            color: widget.title == widget.category
                ? Colors.blueAccent
                : Colors.black,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '${widget.title}',
            style: TextStyle(
                fontSize: 10.0,
                color: widget.title == widget.category
                    ? Colors.blueAccent
                    : Colors.grey),
          )
        ],
      ),
    );
  }
}
