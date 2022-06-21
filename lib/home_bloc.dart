import 'package:challengeui/content_model.dart';
import 'package:challengeui/main.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'mock_data.dart';

class HomeBloc with ChangeNotifier {
  List<TitleTab> tabs = [];
  List<CategoryItemModel> listItem = [];
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  double contentHeight, titleHeight;
  double widgetHeight1, widgetHeight2, widgetHeight3, widgetHeight4;

  HomeBloc(
      {required this.contentHeight,
      required this.titleHeight,
      required this.widgetHeight1,
      required this.widgetHeight2,
      required this.widgetHeight3,
      required this.widgetHeight4});

  void init(TickerProvider ticker) {
    tabController = TabController(vsync: ticker, length: homeCategories.length);
    double offsetFrom = 0.0;
    double offsetTo = 0.0;
    for (int i = 0; i < homeCategories.length; i++) {
      if (i == 0) {
        offsetFrom = 0.0;
        offsetTo = homeCategories[i].product.length * (contentHeight + 10) +
            titleHeight +
            widgetHeight1 +
            widgetHeight2 +
            widgetHeight3 +
            widgetHeight4;
      }
      if (i > 0) {
        offsetFrom = offsetTo;
        offsetTo += homeCategories[i].product.length * (contentHeight + 10) +
            titleHeight;
      }
      print("$i  tab.offsetFrom $offsetFrom    tab.offsetTo $offsetTo");
      CategoryModel item = homeCategories[i];
      tabs.add(TitleTab(
          categoryModel: item,
          selected: (i == 0),
          offsetFrom: offsetFrom,
          offsetTo: offsetTo));
      listItem.add(CategoryItemModel(categoryModel: item));
      for (int j = 0; j < item.product.length; j++) {
        final product = item.product[j];
        listItem.add(CategoryItemModel(productModel: product));
      }
    }
    scrollController.addListener(onScrollListener);
  }

  void onScrollListener() {
    print(scrollController.offset);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          print('scroll is stopped');
          for (int i = 0; i < tabs.length; i++) {
            final tab = tabs[i];

            if (scrollController.offset >= tab.offsetFrom &&
                scrollController.offset <= tab.offsetTo) {
              print(
                  "$i  tab.offsetFrom ${tab.offsetFrom}    tab.offsetTo ${tab.offsetTo}");
              onCategorySelectedScroll(i);
              tabController.animateTo(i);
              break;
            }
          }
          if (scrollController.offset ==
              scrollController.position.maxScrollExtent) {
            onCategorySelectedScroll(tabs.length - 1);
            tabController.animateTo(tabs.length - 1);
          }
        } else {
          print('scroll is started');
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.removeListener(onScrollListener);
    scrollController.dispose();
    tabController.dispose();

    super.dispose();
  }

  void onCategorySelectedScroll(int index) {
    for (var element in tabs) {
      element.setSelected = false;
    }
    tabs[index].setSelected = true;
    tabController.animateTo(index,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
    notifyListeners();
  }

  void onCategorySelected(int index) {
    for (var element in tabs) {
      element.setSelected = false;
    }
    tabs[index].setSelected = true;
    tabController.animateTo(index,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
    scrollController.animateTo(tabs[index].offsetFrom,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
    notifyListeners();
  }
}

class TitleTab {
  TitleTab(
      {required this.categoryModel,
      required this.selected,
      required this.offsetFrom,
      required this.offsetTo});

  final CategoryModel categoryModel;
  final double offsetFrom;
  final double offsetTo;
  bool selected;

  TitleTab copyWith(bool selected) => TitleTab(
      categoryModel: categoryModel,
      selected: selected,
      offsetFrom: offsetFrom,
      offsetTo: offsetTo);

  set setSelected(bool newSelected) {
    selected = newSelected;
  }
}
