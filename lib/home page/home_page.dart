// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallify/generated/l10n.dart';
import 'package:wallify/home%20page/components/masonry_grid_view_component.dart';
import 'package:wallify/home%20page/fetched_images_provider.dart';
import 'package:wallify/home%20page/search_image_page.dart';
import 'package:wallify/image_page/image_page.dart';

import 'package:wallify/theme/theme.dart';
import 'package:wallify/theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // void initState() {
  //   super.initState();
  //   // _tabController = TabController(length: 3, vsync: this);
  //   Provider.of<FetchedImagesProvider>(context, listen: false)
  //       .initializeImages();
  // }

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  late final TabController _tabController =
      TabController(length: tabs.length, vsync: this);

  final lightTextFieldTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.grey.shade400,
      surface: Colors.grey.shade200,
    ),
  );

  final List<String> tabs = [
    "Wallpapers",
    "Nature",
    "Cars",
    "Film",
    "Street",
    "Animals",
    "Interiors",
    "Architecture"
  ];

  // final List<String> images = [
  //   "amine-mayoufi-_5PyWBp9HqA-unsplash.jpg",
  //   "john-towner-3Kv48NS4WUU-unsplash.jpg",
  //   "mads-schmidt-rasmussen-6YmzwamGzCg-unsplash.jpg",
  //   "marcelo-cidrack-7jZNgIuJrCM-unsplash.jpg",
  //   "marcelo-vaz-ka6WGHXcFMY-unsplash.jpg",
  //   "paul-pastourmatzis-KT3WlrL_bsg-unsplash.jpg",
  //   "tobias-rademacher-NuBvAE6VfSM-unsplash.jpg"
  // ];

  // final List<String> images = [
  //   "https://unsplash.com/photos/gray-car-FcyipqujfGg",
  //   "https://unsplash.com/photos/gray-sports-coupe-parking-during-daytime-6lSBynPRaAQ",
  //   "https://unsplash.com/photos/black-and-red-lamborghini-aventador-sv-rear-left-side-aTX_bRaOZnA",
  //   "https://unsplash.com/photos/yellow-porsche-911-on-road-during-daytime-DwxlhTvC16Q",
  //   "https://images.unsplash.com/photo-1514316454349-750a7fd3da3a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Y2Fyc3xlbnwwfHwwfHx8MA%3D%3D",
  //   "https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y2Fyc3xlbnwwfHwwfHx8MA%3D%3D",
  //   "https://unsplash.com/photos/orange-lamborghini-car-oUBjd22gF6w",
  // ];

  bool isPressed = false;
  bool isHovered = false;

  // List<List> correctImages(Map imagesList) {
  //   List<List> result = [];
  //   for (int i = 0; i < imagesList.length; i++) {
  //     String tinyImage = removeParams(imagesList[i]["src"]["tiny"]);
  //     String large2xImage = imagesList[i]["src"]["large2x"];
  //     List image = [tinyImage, large2xImage];
  //     result.add(image);
  //   }

  //   return result;
  // }

  // int page = 1;
  // loadMore() async {
  //   setState(() {
  //     page++;
  //   });
  //   String url = "https://api.pexels.com/v1/curated?per_page=15&page=$page";
  //   await http.get(Uri.parse(url), headers: {
  //     "Authorization":
  //         "kXYEsDUMnCtWlsp4vhKd1HoUcDKOsqcckaY5mHUoN34jS13U46Mp28MS"
  //   }).then((value) {
  //     Map result = jsonDecode(value.body);
  //     setState(() {
  //       images.addAll(result["photos"]);
  //     });
  //   });
  // }

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

  void moveToSearchImagePage(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchImagePage(
            query: query,
            onSearchPageClosed: () {
              Provider.of<FetchedImagesProvider>(context, listen: false)
                  .fetchImages(tabs[_tabController.index]);
            }),
      ),
    );
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme =
        Provider.of<ThemeProvider>(context).currentTheme.buttonTheme;
    final textTheme =
        Provider.of<ThemeProvider>(context).currentTheme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Search bar
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: lightTextFieldTheme.colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: lightTextFieldTheme.colorScheme.secondary),
                    ),
                    fillColor: lightTextFieldTheme.colorScheme.surface,
                    filled: true,
                    hintText: S.of(context).search,
                  ),
                  style: const TextStyle(color: Colors.black),
                  onSubmitted: (query) => moveToSearchImagePage(query),
                ),

                // MouseRegion(
                //   onEnter: (_) {
                //     setState(() {
                //       isHovered = true;
                //     });
                //   },
                //   onExit: (_) {
                //     setState(() {
                //       isHovered = false;
                //     });
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.all(10),
                //     height: 48,
                //     decoration: BoxDecoration(
                //       color: isPressed
                //           ? lightTextFieldTheme.colorScheme.background
                //           : (isHovered
                //               ? lightTextFieldTheme.colorScheme.secondary
                //               : lightTextFieldTheme.colorScheme.background),
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(
                //         color: isPressed
                //             ? lightTextFieldTheme.colorScheme.secondary
                //             : lightTextFieldTheme.colorScheme.primary,
                //       ),
                //     ),
                //     child: Row(
                //       children: [
                //         // Search icon
                //         Padding(
                //           padding: const EdgeInsets.only(right: 18),
                //           child: Image.asset(
                //             "assets/icons/magnifying-glass.png",
                //             width: 24,
                //             color: isPressed
                //                 ? lightTextFieldTheme.colorScheme.secondary
                //                 : (isHovered
                //                     ? lightTextFieldTheme
                //                         .colorScheme.background
                //                     : lightTextFieldTheme
                //                         .colorScheme.secondary),
                //           ),
                //         ),

                //         // Search textfield
                //         Expanded(
                //           child: TextField(
                //             controller: searchController,
                //             decoration: const InputDecoration(
                //               border: InputBorder.none,
                //               hintText: "Nature, Film",
                //             ),
                //             onTap: () {
                //               setState(() {
                //                 isPressed = true;
                //               });
                //             },
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                const SizedBox(height: 20),

                // Categories
                Container(
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.only(right: 20),
                    labelColor: textTheme.labelSmall!.color,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelColor: Colors.grey,
                    tabAlignment: TabAlignment.start,
                    indicator: CircleTabIndicator(
                        color: textTheme.labelSmall!.color as Color, radius: 4),
                    tabs: [
                      Tab(
                        text: S.of(context).wallpapers,
                      ),
                      Tab(
                        text: S.of(context).nature,
                      ),
                      Tab(
                        text: S.of(context).cars,
                      ),
                      Tab(
                        text: S.of(context).film,
                      ),
                      Tab(
                        text: S.of(context).street,
                      ),
                      Tab(
                        text: S.of(context).animals,
                      ),
                      Tab(
                        text: S.of(context).interiors,
                      ),
                      Tab(
                        text: S.of(context).architecture,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Images
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MasonryGridViewComponent(
                        onTap: (index) => moveToImagePage(index),
                        query: tabs[0],
                        scrollController: scrollController,
                      ),
                      MasonryGridViewComponent(
                        onTap: (index) => moveToImagePage(index),
                        query: tabs[1],
                        scrollController: scrollController,
                      ),
                      MasonryGridViewComponent(
                        onTap: (index) => moveToImagePage(index),
                        query: tabs[2],
                        scrollController: scrollController,
                      ),
                      MasonryGridViewComponent(
                        onTap: (index) => moveToImagePage(index),
                        query: tabs[3],
                        scrollController: scrollController,
                      ),
                      MasonryGridViewComponent(
                        onTap: (index) => moveToImagePage(index),
                        query: tabs[4],
                        scrollController: scrollController,
                      ),
                      MasonryGridViewComponent(
                        onTap: (index) => moveToImagePage(index),
                        query: tabs[5],
                        scrollController: scrollController,
                      ),
                      MasonryGridViewComponent(
                        onTap: (index) => moveToImagePage(index),
                        query: tabs[6],
                        scrollController: scrollController,
                      ),
                      MasonryGridViewComponent(
                        onTap: (index) => moveToImagePage(index),
                        query: tabs[7],
                        scrollController: scrollController,
                      ),
                    ],
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

class _TabWidget extends StatelessWidget {
  final String text;

  const _TabWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Оборачиваем в InkWell, чтобы добавить эффект нажатия
      onTap:
          () {}, // Пустой обработчик нажатия, чтобы сохранить стандартное поведение
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({
    required this.color,
    required this.radius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;

  _CirclePainter({
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circleOffset = offset +
        Offset(
            configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }
}
