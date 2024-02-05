import 'package:flutter/material.dart';
import 'package:sipsnap/view/login_register/login_page.dart';
import 'package:sipsnap/view/login_register/register_page.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';
import 'package:sipsnap/view_model/register_page_provider.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';
import 'view/home_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() {
  // this displays the splash screen for a few seconds before the app starts
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)), // Adjust the duration as needed
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Remove the splash screen here
          FlutterNativeSplash.remove();

          // Return your MyApp with the desired configuration
          return const MyApp();
        } else {
          // Return a placeholder or loading screen if needed
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterPageProvider()),
        ChangeNotifierProvider(create: (context) => CommunityPostsProvider()),
        ChangeNotifierProvider(create: (context) => RecipePostsProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/home': (context) => const HomeScreen(),
          '/register': (context) => const RegisterPage(),
        },
        title: 'Sip Snap',
        theme: ThemeData(),
      ),
    );
  }
}
