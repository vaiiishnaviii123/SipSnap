import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/router.dart';
import 'package:sipsnap/view_model/user_provider.dart';


class LoginForm extends StatelessWidget {

  LoginForm({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Add a SizedBox to create space between the form and the button
            const SizedBox(height: 20),
            ElevatedButton(
              key: const ValueKey('loginPage googleButton'),
              onPressed: () async{
                await userProvider.signInWithGoogle();
                if(FirebaseAuth.instance.currentUser != null){
                  goRouter.go('/community');
                }
              },
              child: const Text('Log in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}

          