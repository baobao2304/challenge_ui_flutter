class CategoryModel {
  String name;
  List<ProductModel> product;

  CategoryModel({required this.name, required this.product});
}

class ProductModel {
  String name;
  String description;
  double price;

  ProductModel(
      {required this.name, required this.description, required this.price});
}

class CategoryItemModel {
  CategoryModel? categoryModel;
  ProductModel? productModel;

   CategoryItemModel({ this.categoryModel,  this.productModel});

  bool get isCategory => categoryModel!=null;
}
