import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view_model/register_page_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Add a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Add a TextEditingController for the email and password fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sip Snap'),
      ),
      body: Consumer(
        builder: (context, RegisterPageProvider registerPageProvider, child) {
          return SingleChildScrollView(
            child:Column(
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
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: const ValueKey('login email field'),
                          controller: emailController,
                          validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
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
                                if (_formKey.currentState!.validate()) {
                                  
                                  // check if the email is email 
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please enter a valid email')),
                                    );
                                    return;
                                  }


                                  // check if the email and password match      
                                  if (registerPageProvider.searchUserCheckPassword(emailController.text, passwordController.text)) {
                                    Navigator.pushNamed(context, '/home');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Invalid email or password'),
                                      ),
                                    );
                                  }
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
        },
      ),
    );
  }
}