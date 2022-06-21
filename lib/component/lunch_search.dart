
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LunchSearch extends StatelessWidget {
  const LunchSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 55.sp,
        child: Column(
          children: [
            const Divider(),
            Container(
              margin: const EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text("Lunch", style: TextStyle(fontSize: 15)),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.search)
                ],
              ),
            ),
            const Divider(),
          ],
        ));
  }
}
