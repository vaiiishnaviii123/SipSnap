import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/router.dart';
import 'package:sipsnap/view_model/user_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    return Drawer(
      backgroundColor: Color.fromRGBO(250, 238, 230,1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(253,220,198, 1),
            ),
            child: Text('Sip Snap', style: TextStyle(color: Colors.black, fontSize: 30),),
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
            title: const Text('Log Out'),
            trailing: const Icon(Icons.logout),
            onTap: () {
              userProvider.signOut();
              goRouter.go('/login'); // /logout route is not yet defined first make it in router file
            },
          ),
        ],
      ),
    );
  }
}