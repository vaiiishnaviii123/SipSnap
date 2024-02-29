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
      backgroundColor:  Color.fromRGBO(250, 238, 230,1),
      appBar: AppBar(
        backgroundColor:  Color.fromRGBO(253,220,198,1),
        title: const Text('Profile Page', style: TextStyle(color: Colors.black),),
        leading: BackButton(
          color: Colors.black,
            onPressed: (){
              goRouter.go('/community');
            },
        ),
      ),
      body: Center(
          child: Column(
          children: [
            const SizedBox(height: 15.0),
            ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(48), // Image radius
                child: Image.network(userProvider.currentUser?.photoUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Center(
                        child: Text('😢 No image found.', style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Text('Name: ${userProvider.currentUser?.name}'),
            const SizedBox(height: 15.0),
            Text('Email: ${userProvider.currentUser?.email}'),
          ],
        ),
        ),
    );
  }
}