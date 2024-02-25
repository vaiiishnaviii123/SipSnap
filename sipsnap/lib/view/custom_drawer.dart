import 'package:flutter/material.dart';
import 'package:sipsnap/router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Text('Sip Snap'),
          ),

          // add remove or change any of the ListTile widgets below
          ListTile(
            title: const Text('Profile'),
            trailing: const Icon(Icons.person),
            onTap: () {
              goRouter.go('/profile');  // /profile route is not yet defined first make it in router file
            },
          ),
          ListTile(
            title: const Text('Settings'),
            trailing: const Icon(Icons.settings),
            onTap: () {
              goRouter.go('/settings'); // /setting route is not yet defined first make it in router file
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            trailing: const Icon(Icons.logout),
            onTap: () {
              goRouter.go('/logout'); // /logout route is not yet defined first make it in router file
            },
          ),
        ],
      ),
    );
  }
}