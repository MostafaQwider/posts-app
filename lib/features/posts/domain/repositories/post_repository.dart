import '../entities/post_entity.dart';
import '../entities/comment_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts();
  Future<PostEntity> addPost(PostEntity post);
  Future<List<CommentEntity>> getComments(String postId);
  Future<List<CommentEntity>> getAllComments();
  Future<CommentEntity> addComment(CommentEntity comment);
  Future<void> deletePost(String id);
  Future<void> updatePost(PostEntity post);
}
