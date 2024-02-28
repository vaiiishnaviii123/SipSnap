import 'package:flutter/material.dart';
import 'package:sipsnap/router.dart';
import 'package:sipsnap/view_model/user_provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final UserProvider _userProvider = UserProvider();

  @override
  void initState() {
    super.initState();
    // Listen for user authentication state changes
    _userProvider.userStream.listen((user) {
      // If user is logged in, navigate to home screen
      if (user != null) {
        goRouter.go('/community');
      } else {
        // If user is not logged in, navigate to login screen
        goRouter.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Display a loading indicator
      ),
    );
  }
}
