import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../home_bloc.dart';
import 'title_tab.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final HomeBloc bloc;

  const CustomSliverAppBarDelegate(
      {required this.expandedHeight, required this.bloc});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 60;
    final top = expandedHeight - shrinkOffset - size * 2;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset),
        buildAppBar(shrinkOffset),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset) => Opacity(
    opacity: appear(shrinkOffset),
    child: AnimatedBuilder(
      animation: bloc,
      builder: (BuildContext context, Widget? child) =>

          AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            toolbarHeight: 100,
            leading: const Icon(Icons.arrow_back_ios),
            title: const Text("Amerigo Italian Restauran"),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10.sp),
                child: const Icon(Icons.search),
              ),
            ],
            centerTitle: true,
            bottom: TabBar(
              padding: EdgeInsets.all(5.sp),
              onTap: bloc.onCategorySelected,
              isScrollable: true,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.black),
              labelColor: Colors.red,
              controller: bloc.tabController,
              indicatorWeight: 0.1,
              tabs: bloc.tabs
                  .map((e) => TitleTabWidget(
                titleTab: e,
              ))
                  .toList(),
            ),
          )
         ,
    ),
  );

  Widget buildBackground(double shrinkOffset) => Opacity(
    opacity: disappear(shrinkOffset),
    child: Image.network(
      'https://source.unsplash.com/random?mono+dark',
      fit: BoxFit.cover,
    ),
  );

  Widget buildFloating(double shrinkOffset) => Opacity(
    opacity: disappear(shrinkOffset),
    child: Card(
      child: Container(
        // height:130.sp,
        padding: EdgeInsets.all(10.sp),
        child: Column(
          children: [
            SizedBox(
                width: 100.w,
                height: 60.sp,
                child: const Text(
                  "Amerigo Italian Restaurant",
                  maxLines: 2,
                  style:
                  TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                )),
            Container(
                width: 100.w,
                margin: EdgeInsets.symmetric(vertical: 5.sp),
                child: const Text(
                  "Breakfast and Brunch Italian %%",
                  style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                )),
            SizedBox(
                width: 100.w,
                child: Row(
                  children: const [
                    Icon(Icons.access_time),
                    Text(
                      "30 - 40 MIN",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "4.6",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Icon(Icons.star, color: Colors.yellow),
                    Text("500+",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.grey)),
                  ],
                )),
          ],
        ),
      ),
    ),
  );

  Widget buildButton({
    required String text,
    required IconData icon,
  }) =>
      TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 20)),
          ],
        ),
        onPressed: () {},
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}