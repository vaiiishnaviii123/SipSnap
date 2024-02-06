import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view/login_register/register_page.dart';
import 'package:sipsnap/view_model/register_page_provider.dart';

class MockRegisterPageProvider extends Mock implements RegisterPageProvider {}

void main(){
  testWidgets("not entering any field should display error", (widgetTester) async{

    final MockRegisterPageProvider registerPageProvider = MockRegisterPageProvider();

    //setup
    // Load the register page
    await widgetTester.pumpWidget(
          ChangeNotifierProvider.value(value: registerPageProvider,
        child: const MaterialApp(
          home: RegisterPage(),
        ),
      ),
    );

   // find the register button
    final registerButton = find.byKey(const Key('registerpage register button'));
    print(registerButton);
  });
}