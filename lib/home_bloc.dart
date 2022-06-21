import 'package:challengeui/content_model.dart';
import 'package:flutter/material.dart';

import 'mock_data.dart';

class HomeBloc with ChangeNotifier {
  List<TitleTab> tabs = [];
  List<CategoryItemModel> listItem = [];
  late TabController tabController;
  ScrollController scrollController = ScrollController();

  void init(TickerProvider ticker) {
    tabController = TabController(vsync: ticker, length: homeCategories.length);
    loadData();
    scrollController.addListener(onScrollListener);
  }

  void loadData() {
    double offsetFrom = 0.0;
    double offsetTo = 0.0;
    for (int i = 0; i < homeCategories.length; i++) {
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
  }

  // set setContentHeight(double newContentHeight) {
  //   contentHeight = newContentHeight;
  // }
  //
  // set setTitleHeight(double newTitleHeight) {
  //   titleHeight = newTitleHeight;
  // }
  // set setWidgetHeight1(double newWidgetHeight1) {
  //   widgetHeight1 = newWidgetHeight1;
  // }
  // set setWidgetHeight2(double newWidgetHeight2) {
  //   widgetHeight2 = newWidgetHeight2;
  // }
  // set setWidgetHeight3(double newWidgetHeight3) {
  //   widgetHeight3 = newWidgetHeight3;
  // }
  //
  // set setWidgetHeight4(double newWidgetHeight4) {
  //   widgetHeight4 = newWidgetHeight4;
  // }

  void loadDataOffset(
      double contentHeight,
      double titleHeight,
      double widgetHeight1,
      double widgetHeight2,
      double widgetHeight3,
      double widgetHeight4,
      double height5) {
    double offsetFrom = 0.0;
    double offsetTo = 0.0;
    for (int i = 0; i < homeCategories.length; i++) {
      if (i == 0) {
        offsetFrom = widgetHeight1 +
            widgetHeight2 +
            widgetHeight3 +
            widgetHeight4 -
            height5;
        offsetTo = offsetFrom +
            homeCategories[i].product.length * contentHeight +
            titleHeight -20;
      }
      if (i > 0) {
        offsetFrom = offsetTo;
        offsetTo +=
            homeCategories[i].product.length * contentHeight + titleHeight;
      }
      print(
          "loadDataOffset  $i  tab.offsetFrom $offsetFrom    tab.offsetTo $offsetTo");
      tabs[i].setOffsetFrom = offsetFrom;
      tabs[i].setOffsetTo = offsetTo;

    }
    print(tabs);
    print("dfsdf");
  }

  void onScrollListener() {
    print(scrollController.offset);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          print('scroll is stopped');

          if (scrollController.offset ==
              scrollController.position.maxScrollExtent) {
            onCategorySelectedScroll(tabs.length - 1);
            tabController.animateTo(tabs.length - 1);
          }else if(scrollController.offset >= 0 &&scrollController.offset < tabs[0].offsetFrom){
            tabController.animateTo(0);
          }
          else {
            for (int i = 0; i < tabs.length; i++) {
              final tab = tabs[i];

              if (scrollController.offset >= tab.offsetFrom &&
                  scrollController.offset < tab.offsetTo) {
                // print("$i  tab.offsetFrom ${tab.offsetFrom}    tab.offsetTo ${tab.offsetTo}");
                onCategorySelectedScroll(i);
                tabController.animateTo(i);
                break;
              }
            }
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
  double offsetFrom;
  double offsetTo;
  bool selected;

  TitleTab copyWith(bool selected) => TitleTab(
      categoryModel: categoryModel,
      selected: selected,
      offsetFrom: offsetFrom,
      offsetTo: offsetTo);

  set setSelected(bool newSelected) {
    selected = newSelected;
  }

  set setOffsetFrom(double newOffsetFrom) {
    offsetFrom = newOffsetFrom;
  }

  set setOffsetTo(double newOffsetTo) {
    offsetTo = newOffsetTo;
  }
}
