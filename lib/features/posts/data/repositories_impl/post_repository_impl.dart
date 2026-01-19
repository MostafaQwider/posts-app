import '../../domain/entities/post_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      final remotePosts = await remoteDataSource.fetchPosts();
      await localDataSource.cachePosts(remotePosts);
      return remotePosts.map((model) => model.entity).toList();
    } catch (e) {
      final localPosts = localDataSource.getCachedPosts();
      if (localPosts.isNotEmpty) {
        return localPosts.map((model) => model.entity).toList();
      }
      rethrow;
    }
  }

  @override
  Future<List<CommentEntity>> getComments(String postId) async {
    try {
      final remoteComments = await remoteDataSource.fetchComments(postId);

      return remoteComments.map((model) => model.entity).toList();
    } catch (e) {
      final localComments = localDataSource.getCachedComments();
      return localComments
          .where((model) => model.entity.postId == postId)
          .map((model) => model.entity)
          .toList();
    }
  }

  @override
  Future<List<CommentEntity>> getAllComments() async {
    try {
      final remoteComments = await remoteDataSource.fetchAllComments();
      await localDataSource.cacheComments(remoteComments);
      return remoteComments.map((model) => model.entity).toList();
    } catch (e) {
      final localComments = localDataSource.getCachedComments();
      return localComments.map((model) => model.entity).toList();
    }
  }

  @override
  Future<PostEntity> addPost(PostEntity post) async {
    final modelToCreate = PostModel(entity: post).toFirestore();
    final resultModel = await remoteDataSource.createPost(modelToCreate);
    return resultModel.entity;
  }

  @override
  Future<CommentEntity> addComment(CommentEntity comment) async {
    final modelToCreate = CommentModel(entity: comment).toFirestore();
    final resultModel = await remoteDataSource.createComment(modelToCreate);
    return resultModel.entity;
  }

  @override
  Future<void> deletePost(String id) async {
    await remoteDataSource.deletePost(id);
  }

  @override
  Future<void> updatePost(PostEntity post) async {
    final modelToUpdate = PostModel(entity: post).toFirestore();
    await remoteDataSource.updatePost(post.id, modelToUpdate);
  }
}
