
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LocationViewInfo extends StatelessWidget {
  const LocationViewInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: 40.sp,
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Location and hours",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              width: 70.sp,
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                      text: "View info   ",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  WidgetSpan(
                    child: Icon(Icons.arrow_forward_ios,
                        size: 15, color: Colors.green),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
