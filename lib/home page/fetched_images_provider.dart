// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchedImagesProvider extends ChangeNotifier {
  List<List<String>> allImages = [];

  // initialize list
  Future<List<List<String>>> initializeImages(String query) async {
    if (allImages.isNotEmpty) {
      return allImages;
    } else {
      allImages = await fetchImages(query);
      return allImages;
    }
  }

  // get images
  List<List<String>> getAllImages() {
    return allImages;
  }

  Future<List<List<String>>> fetchImages(String query) async {
    List<List<String>> fetchedImages = [];
    String url;
    if (query == "Wallpapers") {
      url = "https://api.pexels.com/v1/curated?per_page=15";
    } else {
      url =
          "https://api.pexels.com/v1/search?query=$query&per_page=15&orientation=portrait";
    }
    await http.get(Uri.parse(url), headers: {
      "Authorization":
          "kXYEsDUMnCtWlsp4vhKd1HoUcDKOsqcckaY5mHUoN34jS13U46Mp28MS"
    }).then((value) {
      Map result = jsonDecode(value.body);

      for (var photo in result["photos"]) {
        String mediumImage = photo["src"]["medium"];
        String large2xImage = photo["src"]["large2x"];
        fetchedImages.add([mediumImage, large2xImage]);
      }
    });
    allImages = fetchedImages;
    print("Data fetche from url: $url");
    notifyListeners();
    return allImages;
  }

  Future<List<List<String>>> fetchImagesByQuery(String query) async {
    List<List<String>> fetchedImages = [];
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=15&orientation=portrait"),
        headers: {
          "Authorization":
              "kXYEsDUMnCtWlsp4vhKd1HoUcDKOsqcckaY5mHUoN34jS13U46Mp28MS"
        }).then((value) {
      Map result = jsonDecode(value.body);

      for (var photo in result["photos"]) {
        String mediumImage = photo["src"]["medium"];
        // print(tinyImage);
        String large2xImage = photo["src"]["large2x"];
        fetchedImages.add([mediumImage, large2xImage]);
      }
    });
    notifyListeners();
    return fetchedImages;
  }

  String removeParams(String url) {
    // Проверка, содержит ли URL параметры
    if (url.contains('?')) {
      // Получить часть после знака вопроса
      String queryString = url.split('?')[1];

      // Разбить параметры на список
      List<String> queryParts = queryString.split('&');

      // Удалить последний параметр
      queryParts.removeRange(queryParts.length - 2, queryParts.length);
      // print(queryParts);

      // Собрать новый URL без последнего параметра
      String newQueryString = queryParts.join('&');
      String baseUrl = url.split('?')[0];
      // print('$baseUrl?$newQueryString');

      return newQueryString.isNotEmpty ? '$baseUrl?$newQueryString' : baseUrl;
    }

    // Если параметров нет, вернуть оригинальный URL
    return url;
  }
}
