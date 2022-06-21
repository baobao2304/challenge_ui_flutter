import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../home_bloc.dart';

class TitleTabWidget extends StatelessWidget {
  const TitleTabWidget({Key? key, required this.titleTab}) : super(key: key);
  final TitleTab titleTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.sp),
      padding: const EdgeInsets.all(8.0),
      child: Text(titleTab.categoryModel.name,
          style: TextStyle(
              color: titleTab.selected ? Colors.white : Colors.black)),
    );
  }
}