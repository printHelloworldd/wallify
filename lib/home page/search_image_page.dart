// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:wallify/generated/l10n.dart';

import 'package:wallify/home%20page/components/masonry_grid_view_component.dart';
import 'package:wallify/home%20page/fetched_images_provider.dart';
import 'package:wallify/image_page/image_page.dart';
import 'package:wallify/theme/theme.dart';
import 'package:http/http.dart' as http;

class SearchImagePage extends StatefulWidget {
  final String query;

  const SearchImagePage({
    super.key,
    required this.query,
  });

  @override
  State<SearchImagePage> createState() => _HomePageState();
}

class _HomePageState extends State<SearchImagePage>
    with SingleTickerProviderStateMixin {
  @override
  String toLenguageCode = "en";
  var query = "";
  @override
  // void initState() {
  //   super.initState();
  //   detectLanguage(widget.query).then((value) async {
  //     if (value == "en") {
  //       query = widget.query;
  //     } else {
  //       query = await translateQuery(widget.query, toLenguageCode);
  //     }
  //   });
  // }

  final TextEditingController searchController = TextEditingController();

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  final lightTextFieldTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.grey.shade400,
      surface: Colors.grey.shade200,
    ),
  );

  void moveToImagePage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePage(
          imagePath: Provider.of<FetchedImagesProvider>(context, listen: false)
              .getAllImages()[index][1],
        ),
      ),
    );
  }

  static const projectID = "total-bliss-430816-e3";

  Future<String> detectLanguage(String text) async {
    final url = Uri.parse(
        "https://translation.googleapis.com/v3/projects/$projectID/locations/global:detectLanguage");
    final payload = {"content": text};

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(payload),
    );
    print(response.body);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final languages = body["languages"] as List;
      final languageCode = languages.first["languageCode"];
      print("Detected language: $languageCode");

      return languageCode;
    } else {
      throw Exception();
    }
  }

  static const apiKey = "AIzaSyD7Mwbp2Na6I_UuPnOkHR8q_U5qGP2NHqs";

  static Future<String> translateQuery(
      String query, String toLenguageCode) async {
    final response = await http.post(
        "https://translation.googleapis.com/language/translate/v2?target=$toLenguageCode&key=$apiKey&q=$query"
            as Uri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final translations = body["data"]["translations"] as List;
      final translation = translations.first;
      print("Translated query: $translation");

      return HtmlUnescape().convert(translation["translatedText"]);
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Search bar
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightTextFieldTheme.colorScheme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    lightTextFieldTheme.colorScheme.secondary),
                          ),
                          fillColor: lightTextFieldTheme.colorScheme.surface,
                          filled: true,
                          hintText: S.of(context).search,
                        ),
                        onSubmitted: (query) async {
                          // detectLanguage(query).then((value) async {
                          //   if (value == "en") {
                          //     return;
                          //   } else {
                          //     query =
                          //         await translateQuery(query, toLenguageCode);
                          //   }
                          // });
                          Provider.of<FetchedImagesProvider>(context,
                                  listen: false)
                              .fetchImages(widget.query);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Images
                Expanded(
                  child: MasonryGridViewComponent(
                    onTap: (index) => moveToImagePage(index),
                    query: widget.query,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
