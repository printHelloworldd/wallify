// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:wallify/generated/l10n.dart';
import 'package:wallify/home%20page/fetched_images_provider.dart';

class MasonryGridViewComponent extends StatefulWidget {
  final Function(int index) onTap;
  final String query;
  final ScrollController scrollController;

  const MasonryGridViewComponent({
    super.key,
    required this.onTap,
    required this.query,
    required this.scrollController,
  });

  @override
  State<MasonryGridViewComponent> createState() =>
      _MasonryGridViewComponentState();
}

class _MasonryGridViewComponentState extends State<MasonryGridViewComponent> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(loadMoreImages);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<FetchedImagesProvider>(context, listen: false)
          .fetchImages(widget.query);
    });
    Provider.of<FetchedImagesProvider>(context, listen: false)
        .changeQuery(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: FutureBuilder(
        future: Provider.of<FetchedImagesProvider>(context, listen: false)
            .fetchImages(widget.query),
        builder: (context, snapshot) {
          return Consumer<FetchedImagesProvider>(
            builder: (context, imageProvider, child) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Список пустой только в начале
              }
              if (snapshot.data!.isEmpty) {
                return Text(
                  S.of(context).noImagesBySearch,
                  textAlign: TextAlign.center,
                );
              } else {
                return MasonryGridView.builder(
                  itemCount: imageProvider.getAllImages().length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  controller: widget.scrollController,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: imageProvider.getAllImages()[index][0],
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              //     ConstrainedBox(
                              //   constraints: BoxConstraints(
                              //     maxHeight:
                              //         250, // Устанавливаем максимальную высоту в 200 пикселей
                              //   ),
                              //   child: Shimmer.fromColors(
                              //     baseColor: Colors.white,
                              //     highlightColor: Colors.transparent,
                              //     child: Container(
                              //       color: Colors.purple,
                              //       width: double.infinity,
                              //       height: double.infinity,
                              //     ),
                              //   ),
                              // ), // Change to container animation
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
          );
        },
      ),
    );
  }

  void loadMoreImages() {
    if (widget.scrollController.position.pixels ==
            widget.scrollController.position.maxScrollExtent &&
        Provider.of<FetchedImagesProvider>(context, listen: false)
                .getAllImages()
                .length <
            Provider.of<FetchedImagesProvider>(context, listen: false)
                .totalResults) {
      Provider.of<FetchedImagesProvider>(context, listen: false)
          .loadMoreImages();
    }
  }
}
