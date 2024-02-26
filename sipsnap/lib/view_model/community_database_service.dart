import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/community_posts_model.dart';

class CommunityDatabase{

  final CollectionReference communityCollection = FirebaseFirestore.instance.collection('community');

  Future addCommunityPost(CommunityPost communityPost) async {
    return await communityCollection.add({
      'postTitle': communityPost.postTitle,
      'username': communityPost.username,
      'description': communityPost.description,
      'imageRef': communityPost.imageRef
    });
  }
}