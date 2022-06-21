import 'package:flutter/material.dart';

import '../content_model.dart';
import '../main.dart';

class ContentItemWidget extends StatelessWidget {
  const ContentItemWidget({Key? key, required this.productModel})
      : super(key: key);
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            const Divider(),
            Container(
              margin: const EdgeInsets.all(5),
              height: contentHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(productModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    productModel.description,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("\$" + productModel.price.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            const Divider(),
          ],
        ));
  }
}
