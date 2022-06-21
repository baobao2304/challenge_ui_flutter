import 'package:flutter/material.dart';

import '../content_model.dart';
import '../main.dart';

class TitleItemWidget extends StatelessWidget {
  const TitleItemWidget({Key? key, required this.categoryModel})
      : super(key: key);
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      height: titleHeight,
      child: Text(
        categoryModel.name,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}