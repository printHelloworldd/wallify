// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wallify/home%20page/components/masonry_grid_view_component.dart';
import 'package:wallify/home%20page/fetched_images_provider.dart';
import 'package:wallify/image_page/image_page.dart';
import 'package:wallify/theme/theme.dart';

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
  final TextEditingController searchController = TextEditingController();

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  final lightTextFieldTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.grey.shade400,
      background: Colors.grey.shade200,
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
                          fillColor: lightTextFieldTheme.colorScheme.background,
                          filled: true,
                          hintText: "Search",
                        ),
                        onSubmitted: (query) =>
                            Provider.of<FetchedImagesProvider>(context,
                                    listen: false)
                                .fetchImages(query),
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
