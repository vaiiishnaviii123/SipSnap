import 'package:flutter/material.dart';
import 'community_posts.dart';
import 'recipe.dart';
import 'boba_recorder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boba Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 150, 196, 226),
              child: PageView(
                controller: _pageController,
                children: const [
                  BobaRecorder(),
                  CommunityPosts(),
                  Recipe(),
                ],
                onPageChanged: (index) {
                  print("Page changed to index: $index");
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Boba',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Recipes',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }
}
