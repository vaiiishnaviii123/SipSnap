import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view_model/register_page_provider.dart';
import 'package:sipsnap/models/register_page_event.dart';
import 'package:uuid/uuid.dart';
import 'package:sipsnap/router.dart';

class RegisterForm extends StatelessWidget{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterForm({super.key});


  @override
  Widget build(BuildContext context) {

    final registerPageProvider = Provider.of<RegisterPageProvider>(context, listen: false);
    
    return Container(
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
                    goRouter.go('/login'); 
                  });
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }    
}