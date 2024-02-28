import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view/common_widgets/comment_drawer.dart';
import 'package:sipsnap/view_model/comment_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  testWidgets('CommentDrawer displays comments and adds new comment',
      (tester) async {
    // Create a FakeFirestore instance
    final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();

    // Initialize the CommentProvider with the fake Firestore instance
    final CommentProvider commentProvider =
        CommentProvider(fakeFirebaseFirestore);

    // Add some fake comments to the fake Firestore before testing
    await fakeFirebaseFirestore
        .collection('comments')
        .add({'comment': 'Test Comment 1', 'username': 'User1'});
    await fakeFirebaseFirestore
        .collection('comments')
        .add({'comment': 'Test Comment 2', 'username': 'User2'});

    // Pump the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<CommentProvider>.value(
            value: commentProvider,
            child: CommentDrawer(controller: TextEditingController()),
          ),
        ),
      ),
    );

    // Wait for asynchronous operation to complete
    await tester.pumpAndSettle();

    // Verify if comments are displayed
    expect(find.text('Test Comment 1'), findsOneWidget);
    expect(find.text('Test Comment 2'), findsOneWidget);

    // Add a new comment
    await tester.enterText(find.byType(TextField), 'New Comment');
    await tester.tap(find.byIcon(Icons.send));

    // Wait for the comment to be added
    await tester.pumpAndSettle();

    // Verify if the new comment is added
    expect(find.text('New Comment'), findsOneWidget);
  });
}
