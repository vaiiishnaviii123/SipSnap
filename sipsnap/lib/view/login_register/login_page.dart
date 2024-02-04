import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Add a private variable for the email and password just keep this temperory
  String _email = "admin@admin.com";
  String _password = "admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sip Snap'),
      ),
      body: Column(
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

          // add a form with two text fields and a button
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  
                  // Add a SizedBox to create space between the form and the button
                  const SizedBox(height: 30),

                  // make a row with two buttons for login and register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      ElevatedButton(
                        onPressed: () {
                          if (emailController.text == _email && passwordController.text == _password) {
                            Navigator.pushNamed(context, '/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid email or password'),
                              ),
                            );
                          }
                        },
                        child: const Text('Log in'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // add links to reste password for future use
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('This feature is not available yet'),
                ),
              );
            },
            child: const Text('Forgot password?'),
          ),

          // Add a SizedBox to create space between the form and the button
          const SizedBox(height: 20),

          // add links to login with google 
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('This feature is not available yet'),
                ),
              );
            },
            child: const Text('Log in with Google'),
          ),
        ],
      ),
    );
  }
}