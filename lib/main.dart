import 'package:challengeui/component/location_infoview.dart';
import 'package:challengeui/component/lunch_search.dart';
import 'package:challengeui/content_model.dart';
import 'package:challengeui/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'component/content_item.dart';
import 'component/custom_silver_appbar.dart';
import 'component/title_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

double titleHeight = 55.sp;
double contentHeight = 165.sp;
double widgetHeight1 = 200.sp;
double widgetHeight2 = 50.sp;
double widgetHeight3 = 55.sp;
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _bloc.init(this);
  }

  String image =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png";

  Widget buildBodyList() => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              return Container(
                height: 50.sp,
              );
            } else if (index == 1) {
              return const LocationViewInfo();
            } else if (index == 2) {
              return const LunchSearch();
            } else {
              final item = _bloc.listItem[index - 3];
              if (item.isCategory) {
                return TitleItemWidget(
                  categoryModel: item.categoryModel!,
                );
              } else {
                return ContentItemWidget(productModel: item.productModel!);
              }
            }
          },
          childCount: _bloc.listItem.length + 3,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      // _bloc.setWidgetHeight1 = widgetHeight1;
      // _bloc.setWidgetHeight2 = widgetHeight2;
      // _bloc.setWidgetHeight3 = widgetHeight2;
      // _bloc.setWidgetHeight4 = widgetHeight3;
      // _bloc.setTitleHeight = titleHeight;
      // _bloc.setContentHeight = contentHeight;
      _bloc.loadDataOffset(contentHeight,titleHeight, widgetHeight1,widgetHeight2,widgetHeight2,widgetHeight3,90.sp);
      return MaterialApp(
          debugShowCheckedModeBanner: true,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SafeArea(
            child: Scaffold(
              body: CustomScrollView(
                controller: _bloc.scrollController,
                slivers: [
                  SliverPersistentHeader(
                    floating: false,
                    delegate: CustomSliverAppBarDelegate(
                        expandedHeight: 200.sp, bloc: _bloc),
                    pinned: true,
                  ),
                  buildBodyList()
                ],
              ),
            ),
          ));
    });
  }
}
