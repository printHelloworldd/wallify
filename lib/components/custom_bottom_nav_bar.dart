import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallify/authentication/create_account_page/create_account_page.dart';
import 'package:wallify/authentication/login_page/login_page.dart';
import 'package:wallify/home%20page/home_page.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    LoginPage(),
    const CreateAccountPage()
  ];

  void changePageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Home Page, Saved Wallpapers Page, Profile Page
        PageView(
          controller: _pageController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),

        // Bottom Navigation Bar
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Home
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: _currentPageIndex == 0 ? 60 : 50,
                  height: _currentPageIndex == 0 ? 60 : 50,
                  decoration: BoxDecoration(
                    color: _currentPageIndex == 0
                        ? const Color(0xFF014864)
                        : Colors.white,
                    borderRadius:
                        BorderRadius.circular(_currentPageIndex == 0 ? 30 : 25),
                  ),
                  child: IconButton(
                    icon: Icon(_currentPageIndex == 0
                        ? Icons.home
                        : Icons.home_outlined),
                    color: _currentPageIndex == 0 ? Colors.white : Colors.black,
                    onPressed: () {
                      changePageIndex(0);
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),

                // Saved
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: _currentPageIndex == 1 ? 60 : 50,
                  height: _currentPageIndex == 1 ? 60 : 50,
                  decoration: BoxDecoration(
                    color: _currentPageIndex == 1
                        ? const Color(0xFF014864)
                        : Colors.white,
                    borderRadius:
                        BorderRadius.circular(_currentPageIndex == 1 ? 30 : 25),
                  ),
                  child: IconButton(
                    icon: Icon(_currentPageIndex == 1
                        ? Icons.bookmark
                        : Icons.bookmark_border),
                    color: _currentPageIndex == 1 ? Colors.white : Colors.black,
                    onPressed: () {
                      changePageIndex(1);
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),

                // Profile
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: _currentPageIndex == 2 ? 60 : 50,
                  height: _currentPageIndex == 2 ? 60 : 50,
                  decoration: BoxDecoration(
                    color: _currentPageIndex == 2
                        ? const Color(0xFF014864)
                        : Colors.white,
                    borderRadius:
                        BorderRadius.circular(_currentPageIndex == 2 ? 30 : 25),
                  ),
                  child: IconButton(
                    icon: Icon(_currentPageIndex == 1
                        ? Icons.person
                        : Icons.person_outline),
                    color: _currentPageIndex == 2 ? Colors.white : Colors.black,
                    onPressed: () {
                      print('Profile button pressed');
                      changePageIndex(2);
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
