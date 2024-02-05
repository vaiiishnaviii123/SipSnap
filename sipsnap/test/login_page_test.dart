// Add a widget test for login page widget
import 'package:flutter_test/flutter_test.dart';
import 'package:sipsnap/main.dart';

void main(){

  testWidgets("Login should not work", (widgetTester) async{
    // Load the app
    await widgetTester.pumpWidget(const MyApp());
    
  });

}
