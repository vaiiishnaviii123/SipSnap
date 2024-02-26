import 'package:flutter/material.dart';
import 'package:sipsnap/view/login_register/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Add a SizedBox to create space between the top of the screen and the first widget
              const SizedBox(height: 20),
              const Text(
                'Welcome to Sip Snap',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              
              // Add a SizedBox to create space between the text and the button
              const SizedBox(height: 20),

              // add a logo
              const Image(image: AssetImage('assets/sip_snap@1x.png'), height: 200, width: 200),

              // Add a SizedBox to create space between the logo and the form
              const SizedBox(height: 20),

              // login form
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}