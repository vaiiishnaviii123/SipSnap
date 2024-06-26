import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipsnap/view/common_widgets/loading_page.dart';
import 'package:sipsnap/view/community_views/community_posts_page.dart';
import 'package:sipsnap/view/create_post/Create_post_page.dart';
import 'package:sipsnap/view/login_register/login_page.dart';
import 'package:sipsnap/view/profile_views/profile_page.dart';
import 'package:sipsnap/view/recipe_views/recipe_posts_page.dart';
import 'package:sipsnap/view/common_widgets/screens.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();


final goRouter = GoRouter(
  initialLocation: '/loading',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/loading',
      pageBuilder: (context, state) => NoTransitionPage(
          child: LoadingPage()
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginPage()
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: ProfilePage()
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/community',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CommunityPostsPage(),
              ),
              //routes:[]
            ),
          ],
        ),
        StatefulShellBranch(
            routes: [
              // Create
              GoRoute(
                path: '/create',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CreatePostPage(),
                ),
                //routes:[]
              ),
            ]
        ),
        StatefulShellBranch(
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/recipe',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RecipePostsPage(),
              ),
              // use this ti make nested routes
              // routes: [
              //   GoRoute(
              //     path: 'edit/:uuid',
              //     pageBuilder: (context, state) {
              //       final String uuid = state.pathParameters['uuid'].toString();
              //       return NoTransitionPage(
              //         child: EditDietPage(uuid: uuid),
              //       );
              //     }
              //   ),
              // ],
            ),
          ],
        ),
      ],
    ),
  ],
);