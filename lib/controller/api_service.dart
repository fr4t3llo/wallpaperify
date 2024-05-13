import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaperify/model/model_category.dart';
import 'package:wallpaperify/model/models_photo.dart';

import 'dart:math';

class Api {
  static List<GetPhotos> trendingWallpapers = [];
  static List<GetPhotos> searchWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];

  static const String _apiKey =
      "HAWBZNssVzj2he7iaks5BxUtGoWGk9vlVRes8nkK7CFhEL0ZFgCOS70W";
  static Future<List<GetPhotos>> getTrendingWallpapers() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {"Authorization": _apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      for (var element in photos) {
        trendingWallpapers.add(GetPhotos.fromAPI2App(element));
      }
    });

    return trendingWallpapers;
  }

  static Future<List<GetPhotos>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization": _apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      for (var element in photos) {
        searchWallpapersList.add(GetPhotos.fromAPI2App(element));
      }
    });

    return searchWallpapersList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "iphone",
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "coding",
      "Flowers",
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final random = Random();

      GetPhotos photoModel =
          (await searchWallpapers(catName))[0 + random.nextInt(11 - 0)];
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}
