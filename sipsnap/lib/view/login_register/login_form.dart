import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/router.dart';
import 'package:sipsnap/view_model/register_page_provider.dart';

class LoginForm extends StatelessWidget {

  LoginForm({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerPageProvider = context.read<RegisterPageProvider>();
    return Container(
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
              key: const ValueKey('login password field'),
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
                  key: const ValueKey('loginPage loginButton'),
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
                        goRouter.go('/community'); 
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
                  key: const ValueKey('login page registerButton'),
                  onPressed: () {
                    goRouter.go('/register'); 
                  },
                  child: const Text('Register'),
                ),
              ],
            ),

            // Add a SizedBox to create space between the form and the button
            const SizedBox(height: 20),
            TextButton(
              key: const ValueKey('loginPage forgetPasswordButton'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This feature is not available yet')),
                );
              },
              child: const Text('Forgot password?'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const ValueKey('loginPage googleButton'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This feature is not available yet')),
                );
              },
              child: const Text('Log in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}