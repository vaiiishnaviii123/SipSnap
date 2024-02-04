import 'package:flutter/material.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';
import 'package:sipsnap/view_model/register_page_provider.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';
import 'view/home_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'view/login-register/login_page.dart';
import 'view/login-register/register_page.dart';
import 'package:provider/provider.dart';

void main() {
  // this displays the splash screen for a few seconds before the app starts
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    MultiProvider(
      providers: [
        // Add your providers here
        ChangeNotifierProvider(create: (_) => CommunityPostsProvider()),
        ChangeNotifierProvider(create: (_) => RegisterPageProvider()),
        ChangeNotifierProvider(
          create: (context) => RecipePostsProvider(),
        ),
        // Add more providers if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap your MaterialApp with a FutureBuilder to handle the delay
    return FutureBuilder(
      future: Future.delayed(
          const Duration(seconds: 3)), // Adjust the duration as needed
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Remove the splash screen here
          FlutterNativeSplash.remove();

          // Return your MaterialApp with the desired configuration
          return MaterialApp(
              initialRoute: '/',
              routes: {
                '/': (context) => const LoginPage(),
                '/home': (context) => const HomeScreen(),
                '/register': (context) => const RegisterPage(),
              },
              title: 'Sip Snap',
              theme: ThemeData());
        } else {
          // Return a placeholder or loading screen if needed
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
