// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wallify/components/custom_bottom_nav_bar.dart';

import 'package:wallify/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 3, vsync: this);
  // }

  final TextEditingController searchController = TextEditingController();

  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  final lightButtonTheme = lightTheme.buttonTheme.colorScheme;
  final lightTextTheme = lightTheme.textTheme;

  final lightTextFieldTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.grey.shade400,
      background: Colors.grey.shade200,
    ),
  );

  final List<String> tabs = ["Cars", "Anime", "Film", "Nature"];

  final List<String> images = [
    "amine-mayoufi-_5PyWBp9HqA-unsplash.jpg",
    "john-towner-3Kv48NS4WUU-unsplash.jpg",
    "mads-schmidt-rasmussen-6YmzwamGzCg-unsplash.jpg",
    "marcelo-cidrack-7jZNgIuJrCM-unsplash.jpg",
    "marcelo-vaz-ka6WGHXcFMY-unsplash.jpg",
    "paul-pastourmatzis-KT3WlrL_bsg-unsplash.jpg",
    "tobias-rademacher-NuBvAE6VfSM-unsplash.jpg"
  ];

  bool isPressed = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = false;
        });
      },
      child: Scaffold(
        backgroundColor: lightTheme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Search bar
                  MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        isHovered = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        isHovered = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 48,
                      decoration: BoxDecoration(
                        color: isPressed
                            ? lightTextFieldTheme.colorScheme.background
                            : (isHovered
                                ? lightTextFieldTheme.colorScheme.secondary
                                : lightTextFieldTheme.colorScheme.background),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isPressed
                              ? lightTextFieldTheme.colorScheme.secondary
                              : lightTextFieldTheme.colorScheme.primary,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Search icon
                          Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: Image.asset(
                              "assets/icons/magnifying-glass.png",
                              width: 24,
                              color: isPressed
                                  ? lightTextFieldTheme.colorScheme.secondary
                                  : (isHovered
                                      ? lightTextFieldTheme
                                          .colorScheme.background
                                      : lightTextFieldTheme
                                          .colorScheme.secondary),
                            ),
                          ),

                          // Search textfield
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Nature, Film",
                              ),
                              onTap: () {
                                setState(() {
                                  isPressed = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Categories
                  Container(
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelPadding: const EdgeInsets.only(right: 20),
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelColor: Colors.grey,
                      tabAlignment: TabAlignment.start,
                      indicator:
                          CircleTabIndicator(color: Colors.black, radius: 4),
                      tabs: const [
                        Tab(
                          text: "Interiors",
                        ),
                        Tab(
                          text: "Architecture",
                        ),
                        Tab(
                          text: "Cars",
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
                        ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: MasonryGridView.builder(
                            itemCount: images.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  "assets/images/${images[index]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text("Architecture"),
                        const Text("Cars"),
                      ],
                    ),
                  ),
                ],
              ),
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
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset = offset +
        Offset(
            configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
