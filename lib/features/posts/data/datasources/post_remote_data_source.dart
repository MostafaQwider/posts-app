import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

class PostRemoteDataSource {
  final FirebaseFirestore firestore;

  PostRemoteDataSource({required this.firestore});

  static const String _postsCollection = 'posts';
  static const String _commentsCollection = 'comments';

  Future<List<PostModel>> fetchPosts() async {
    final snapshot = await firestore
        .collection(_postsCollection)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList();
  }

  Future<List<CommentModel>> fetchComments(String postId) async {
    final snapshot = await firestore
        .collection(_commentsCollection)
        .where('postId', isEqualTo: postId)
        .get();
    return snapshot.docs.map((doc) => CommentModel.fromFirestore(doc)).toList();
  }

  Future<List<CommentModel>> fetchAllComments() async {
    final snapshot = await firestore.collection(_commentsCollection).get();
    return snapshot.docs.map((doc) => CommentModel.fromFirestore(doc)).toList();
  }

  Future<PostModel> createPost(Map<String, dynamic> postData) async {
    final ref = await firestore.collection(_postsCollection).add(postData);
    final doc = await ref.get();
    return PostModel.fromFirestore(doc);
  }

  Future<CommentModel> createComment(Map<String, dynamic> commentData) async {
    final ref =
        await firestore.collection(_commentsCollection).add(commentData);
    final doc = await ref.get();
    return CommentModel.fromFirestore(doc);
  }

  Future<void> deletePost(String id) async {
    await firestore.collection(_postsCollection).doc(id).delete();
  }

  Future<void> updatePost(String id, Map<String, dynamic> postData) async {
    await firestore.collection(_postsCollection).doc(id).update(postData);
  }
}
