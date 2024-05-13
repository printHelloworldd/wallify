// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallify/home%20page/fetched_images_provider.dart';

class MasonryGridViewComponent extends StatelessWidget {
  final Function(int index) onTap;
  final String query;

  const MasonryGridViewComponent({
    super.key,
    required this.onTap,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: FutureBuilder(
        future: Provider.of<FetchedImagesProvider>(context, listen: false)
            .fetchImages(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MasonryGridView.builder(
              itemCount:
                  Provider.of<FetchedImagesProvider>(context, listen: false)
                      .getAllImages()
                      .length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(4),
                child: GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      Provider.of<FetchedImagesProvider>(context, listen: false)
                          .getAllImages()[index][0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () => onTap(index),
                  onLongPress: () {},
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null) {
            return const Center(child: Text("No data"));
          } else {
            return const Center(child: Text("Error to load data"));
          }
        },
      ),
    );
  }
}
