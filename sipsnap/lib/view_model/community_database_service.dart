import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';
import '../models/community_posts_model.dart';

class CommunityDatabase {
  late FirebaseFirestore database;
  late CollectionReference communityCollection;

  CommunityDatabase(FirebaseFirestore db){
    database = db;
    communityCollection = database.collection('community');
  }

  Future addCommunityPost(CommunityPost communityPost) async {
    return await communityCollection.add({
      'postTitle': communityPost.postTitle,
      'username': communityPost.username,
      'description': communityPost.description,
      'imageRef': communityPost.imageRef
    });
  }

  Future<void> fetchCommunityPosts(CommunityPostsProvider provider) async {
    try {
      QuerySnapshot querySnapshot = await communityCollection.get();
      List<CommunityPost> posts = [];
      for (var doc in querySnapshot.docs) {
        posts.add(CommunityPost(
          postTitle: doc['postTitle'],
          username: doc['username'],
          description: doc['description'],
          imageRef: doc['imageRef'],
        ));
      }
      provider.setCommunityPosts(posts);
    } catch (error) {
      print("Error fetching community posts: $error");
      throw error;
    }
  }
}
