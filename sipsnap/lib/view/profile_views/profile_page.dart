import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/router.dart';
import 'package:sipsnap/view_model/user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Profile Page'),
            Text('Name: ${userProvider.currentUser?.name}'),
            Text('Email: ${userProvider.currentUser?.email}'),
            Text('UUID: ${userProvider.currentUser?.uuid}'),
            Image.network(userProvider.currentUser?.photoUrl ?? ''),
            ElevatedButton(
              onPressed: (){
                goRouter.go('/community');
              }, 
              child: const Text('Back')
            ),
          ],
        ),

      ),
    );
  }
}