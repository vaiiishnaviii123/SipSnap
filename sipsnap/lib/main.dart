import 'package:flutter/material.dart';
import 'package:sipsnap/router.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';
import 'package:sipsnap/view_model/register_page_provider.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() async {
  // this displays the splash screen for a few seconds before the app starts
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    // use this future builder to load all the data from DB before the app starts until then it will display the splash screen
    FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)), // add your future here to load data now its static to 3 seconds
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          FlutterNativeSplash.remove();
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => RecipePostsProvider()),
              ChangeNotifierProvider(create: (context) => CommunityPostsProvider()),
              ChangeNotifierProvider(create: (context) => RegisterPageProvider()),
            ],
            child: const MyApp(),
          );
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
    return MaterialApp.router(
      routerConfig: goRouter, 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}
