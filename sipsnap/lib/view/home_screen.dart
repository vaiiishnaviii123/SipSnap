import 'package:flutter/material.dart';
import 'package:sipsnap/view/create_post/create_community_recipe_post.dart';
import 'package:sipsnap/view/dialog_box.dart';
import 'community_views/community_posts_view.dart';
import 'recipe_views/recipe_posts_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _showPostTypeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Post Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the AlertDialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePost(),
                    ),
                  );
                  // Navigate to post form with Community type
                },
                child: const Text('Community Post'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate to post form with Recipe type
                },
                child: const Text('Recipe'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Color.fromRGBO(255,243,207, 1), // 201, 215, 221
      appBar: AppBar(
        title: const Text('Sip Snap', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(99,122,159, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: PageView(
                controller: _pageController,
                children: const [
                  CommunityPosts(),
                  SizedBox(
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                      child: CreatePost(),
                    ),
                  ),
                  RecipePosts(),
                ],
                onPageChanged: (index) {
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
        backgroundColor: Color.fromRGBO(99,122,159, 1),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _showPostTypeDialog,
      //   child: Icon(Icons.add),
      // ),
    ),
    );
  }
}