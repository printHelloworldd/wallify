// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallify/home%20page/fetched_images_provider.dart';

class MasonryGridViewComponent extends StatefulWidget {
  final Function(int index) onTap;
  final String query;

  const MasonryGridViewComponent({
    super.key,
    required this.onTap,
    required this.query,
  });

  @override
  State<MasonryGridViewComponent> createState() =>
      _MasonryGridViewComponentState();
}

class _MasonryGridViewComponentState extends State<MasonryGridViewComponent> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(loadMoreImages);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FetchedImagesProvider>(context, listen: false)
          .fetchImages(widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      // Можно обвернуть в Future
      child: Consumer<FetchedImagesProvider>(
        builder: (context, imageProvider, child) {
          if (imageProvider.getAllImages().isEmpty) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Список пустой только в начале
          } else {
            return MasonryGridView.builder(
              itemCount: imageProvider.getAllImages().length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              controller: scrollController,
              itemBuilder: (context, index) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        // child: Image.network(
                        //   imageProvider.getAllImages()[index][0],
                        //   fit: BoxFit.cover,
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: imageProvider.getAllImages()[index][0],
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                        ),
                      ),
                      onTap: () => widget.onTap(index),
                      onLongPress: () {},
                    ),
                  ),
                  if (index == imageProvider.getAllImages().length - 1 &&
                      imageProvider.isLoading == true)
                    const Padding(
                      padding: EdgeInsets.all(6),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void loadMoreImages() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        Provider.of<FetchedImagesProvider>(context, listen: false)
                .getAllImages()
                .length <
            Provider.of<FetchedImagesProvider>(context, listen: false)
                .totalResults) {
      Provider.of<FetchedImagesProvider>(context, listen: false)
          .loadMoreImages(widget.query);
    }
  }
}
