import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view_model/register_page_provider.dart';
import 'package:sipsnap/models/register_page_event.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  
  // Add a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Add a TextEditingController for the email and passwords fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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

                // add a form with three text fields and a button
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: const Key('register email field'),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          key: const Key('register password field'),
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) => value!.isEmpty ? 'Please enter your password' : null, 
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          key: const Key('register confirm password field'),
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) => value!.isEmpty ? 'Please confirm your password' : null,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          key: const Key('registerpage register button'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              
                              // Add a check to see if the email is email format
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please enter a valid email')),
                                );
                                return;
                              }

                              // check if the email is already registered
                              if (registerPageProvider.checkForDuplicateEmail(emailController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('User already registered')),
                                );
                                return;
                              }

                              // Add a check to see if the passwords match
                              if (passwordController.text != confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Passwords do not match')),
                                );
                                return;
                              }

                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('registeration successful')),
                              );

                              // Create a RegisterPageEvent and add it to the registerPageProvider
                              RegisterPageEvent registerPageEvent = RegisterPageEvent(
                                id: const Uuid().v4(),  // generate a random uuid
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                              );

                              registerPageProvider.addRegisterPageEvent(registerPageEvent);

                              // after 2 seconds, navigate to the login page
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushNamed(context, '/');
                              });
                            }
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          );
        },
      ),
    );
  }
}