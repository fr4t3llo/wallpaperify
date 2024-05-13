class CategoryModel {
  String catName;
  String catImgUrl;

  CategoryModel({required this.catImgUrl, required this.catName});

  static CategoryModel fromApi2App(Map<String, dynamic>? category) {
    final catImgUrl = category?["imgUrl"] as String?;
    final catName = category?["CategoryName"] as String?;

    return CategoryModel(
      catImgUrl: catImgUrl ?? "",
      catName: catName ?? "",
    );
  }
}
