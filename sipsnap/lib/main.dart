import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sipsnap/router.dart';
import 'package:sipsnap/view_model/comment_provider.dart';
import 'package:sipsnap/view_model/community_database_service.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';
import 'package:sipsnap/view_model/recipe_database_service.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sipsnap/view_model/user_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );                                           

  // this displays the splash screen for a few seconds before the app starts
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FirebaseFirestore db = FirebaseFirestore.instance;

  runApp(
    // use this future builder to load all the data from DB before the app starts until then it will display the splash screen
    FutureBuilder(
      future: Future.delayed(const Duration(
          seconds:3)), // add your future here to load data now its static to 3 seconds
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          FlutterNativeSplash.remove();
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => RecipePostsProvider()),
              ChangeNotifierProvider(create: (context) => CommunityPostsProvider()),
              ChangeNotifierProvider(create: (context) => UserProvider()),
              ChangeNotifierProvider(create: (context) => CommentProvider(db)),
              Provider(create: (context)=>CommunityDatabase(db)),
              Provider(create: (context)=>RecipeDatabase(db)),
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
