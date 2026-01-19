import 'dart:convert';
import '../../../../core/services/storage_service.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

class PostLocalDataSource {
  final StorageService storageService;
  static const String _postsKey = 'CACHED_POSTS';
  static const String _commentsKey = 'CACHED_COMMENTS';

  PostLocalDataSource({required this.storageService});

  Future<void> cachePosts(List<PostModel> posts) async {
    final List<String> jsonList =
        posts.map((post) => jsonEncode(post.toJson())).toList();
    await storageService.write(key: _postsKey, value: jsonList);
  }

  List<PostModel> getCachedPosts() {
    final List<String>? jsonList =
        storageService.readTypedData<List<String>>(key: _postsKey);
    if (jsonList != null) {
      return jsonList
          .map((str) => PostModel.fromJson(jsonDecode(str)))
          .toList();
    }
    return [];
  }

  Future<void> cacheComments(List<CommentModel> comments) async {
    final List<String> jsonList =
        comments.map((comment) => jsonEncode(comment.toJson())).toList();
    await storageService.write(key: _commentsKey, value: jsonList);
  }

  List<CommentModel> getCachedComments() {
    final List<String>? jsonList =
        storageService.readTypedData<List<String>>(key: _commentsKey);
    if (jsonList != null) {
      return jsonList
          .map((str) => CommentModel.fromJson(jsonDecode(str)))
          .toList();
    }
    return [];
  }
}
